# Build stage
FROM golang:1.23-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git ca-certificates tzdata

# Set working directory
WORKDIR /build

# Copy go mod files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the main binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags '-w -s' -o rancher-mcp ./cmd

# Build verify-token tool
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags '-w -s' -o verify-token ./cmd/verify-token

# Final stage
FROM alpine:latest

# Install ca-certificates for HTTPS requests
RUN apk --no-cache add ca-certificates tzdata

# Create app user
RUN addgroup -S app && adduser -S app -G app

# Set working directory
WORKDIR /app

# Copy binaries from builder
COPY --from=builder /build/rancher-mcp .
COPY --from=builder /build/verify-token .

# Copy example env file (optional, for reference)
COPY --from=builder /build/.env.example .

# Set ownership
RUN chown -R app:app /app

# Switch to non-root user
USER app

# Expose HTTP port (if using HTTP transport)
EXPOSE 8080

# Default to stdio transport
ENTRYPOINT ["./rancher-mcp"]
CMD ["--transport", "stdio"]
