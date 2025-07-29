# ---- Build stage ----
FROM klakegg/hugo:0.147.6-ext-alpine AS builder
WORKDIR /app
COPY . .
ARG HUGO_BASEURL
RUN hugo --baseURL="${HUGO_BASEURL}"

# ---- Serve stage ----
FROM nginx:alpine
COPY --from=builder /app/public /usr/share/nginx/html
EXPOSE 80
