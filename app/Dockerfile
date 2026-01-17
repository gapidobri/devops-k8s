FROM golang:1.25.5 AS build

WORKDIR /build

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o todoapp


FROM scratch

COPY --from=build /build/todoapp /todoapp
COPY --from=build /build/templates /templates
COPY --from=build /build/static /static

ENV TEMPLATES_PATH=/templates
ENV STATIC_PATH=/static

ENV GIN_MODE=release

ENTRYPOINT ["/todoapp"]