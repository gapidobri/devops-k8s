package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"

	"github.com/gin-gonic/gin"
	healthcheck "github.com/tavsec/gin-healthcheck"
	"github.com/tavsec/gin-healthcheck/checks"
	"github.com/tavsec/gin-healthcheck/config"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func getEnvOr(key string, defaultVal string) string {
	val, exists := os.LookupEnv(key)
	if exists {
		return val
	}
	return defaultVal
}

func setupDatabase() *gorm.DB {
	log.Println("Setting up database connection")

	dbHost := getEnvOr("DB_HOST", "localhost")
	dbPort := getEnvOr("DB_PORT", "5432")
	dbUser := getEnvOr("DB_USER", "postgres")
	dbPass := getEnvOr("DB_PASS", "postgres")
	dbName := getEnvOr("DB_NAME", "postgres")

	dsn := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable", dbHost, dbPort, dbUser, dbPass, dbName)
	db, err := gorm.Open(postgres.Open(dsn))
	if err != nil {
		log.Fatalf("failed to connect to database: %v", err)
	}

	err = db.AutoMigrate(&Task{})
	if err != nil {
		log.Fatalf("failed to apply database migrations: %v", err)
	}

	return db
}

func setupRouter(db *gorm.DB) *gin.Engine {
	log.Println("Setting up router")

	templatesPath := getEnvOr("TEMPLATES_PATH", "templates")
	staticPath := getEnvOr("STATIC_PATH", "./static")

	router := gin.Default()
	router.LoadHTMLGlob(fmt.Sprintf("%s/*", templatesPath))
	router.Static("/static", staticPath)

	sqlDB, _ := db.DB()
	_ = healthcheck.New(router, config.DefaultConfig(), []checks.Check{
		checks.SqlCheck{Sql: sqlDB},
	})

	router.GET("/", func(c *gin.Context) {
		tasks, err := gorm.G[Task](db).Find(c.Request.Context())
		if err != nil {
			c.AbortWithStatus(http.StatusInternalServerError)
			return
		}

		title := getEnvOr("APP_TITLE", "Hiter To‑Do")

		c.HTML(http.StatusOK, "index.gohtml", gin.H{"title": title, "tasks": tasks})
	})

	router.POST("/add", func(c *gin.Context) {
		err := c.Request.ParseForm()
		if err != nil {
			c.AbortWithStatus(http.StatusBadRequest)
			return
		}
		title := strings.TrimSpace(c.Request.Form.Get("title"))
		err = gorm.G[Task](db).Create(c.Request.Context(), &Task{
			Title: title,
			Done:  false,
		})
		if err != nil {
			c.AbortWithStatus(http.StatusInternalServerError)
			return
		}

		c.Redirect(http.StatusFound, "/")
	})

	router.POST("/toggle/:id", func(c *gin.Context) {
		id := c.Param("id")

		_, err := gorm.G[Task](db).Where("id = ?", id).Update(c.Request.Context(), "done", gorm.Expr("NOT done"))
		if err != nil {
			c.AbortWithStatus(http.StatusInternalServerError)
			return
		}

		c.Redirect(http.StatusFound, "/")
	})

	router.POST("/delete/:id", func(c *gin.Context) {
		id := c.Param("id")

		_, err := gorm.G[Task](db).Where("id = ?", id).Delete(c.Request.Context())
		if err != nil {
			c.AbortWithStatus(http.StatusInternalServerError)
			return
		}

		c.Redirect(http.StatusFound, "/")
	})

	return router
}

func main() {
	db := setupDatabase()

	router := setupRouter(db)

	log.Println("server listening on port 8080")

	err := router.Run(":8080")
	if err != nil {
		log.Fatalf("failed to run server: %v", err)
	}
}
