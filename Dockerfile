# --- Build stage: build Hugo site ---
FROM klakegg/hugo:0.121.2-ext-alpine AS builder

WORKDIR /app
COPY . .

ARG HUGO_BASEURL=https://example.com/
RUN hugo --baseURL="${HUGO_BASEURL}"

# --- Serve stage: chạy site bằng nginx ---
FROM nginx:alpine
COPY --from=builder /app/public /usr/share/nginx/html
EXPOSE 80
