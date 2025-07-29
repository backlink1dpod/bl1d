# --- Build Hugo site ---
FROM klakegg/hugo:0.121.2-ext-alpine AS builder
WORKDIR /app
COPY . .
ARG HUGO_BASEURL=https://example.com/
RUN hugo --baseURL="${HUGO_BASEURL}"

# --- Serve with Node.js ---
FROM node:18-alpine
WORKDIR /site
COPY --from=builder /app/public .

# Install lightweight static server
RUN npm install -g serve

# Railway cung cấp $PORT
ENV PORT=8080

# Chạy server
CMD ["serve", "-s", ".", "-l", "8080"]
