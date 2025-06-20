FROM golang:1.24 AS builder

WORKDIR /src/ecs-envier/

COPY ./go.mod ./go.sum ./
RUN go mod download

COPY ./cmd/ ./cmd/
COPY ./main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -v -trimpath -a -o /ecs-envier ./main.go

FROM scratch

COPY --from=builder /ecs-envier /ecs-envier
COPY ./LICENSE /ecs-envier.LICENSE
