# Sử dụng image Hugo hợp lệ
FROM klakegg/hugo:0.134.0-ext AS builder

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép toàn bộ mã nguồn
COPY . .

# Xây dựng website Hugo với biến HUGO_BASEURL
RUN hugo --minify -b $HUGO_BASEURL

# Sử dụng image Nginx để phục vụ các tệp tĩnh
FROM nginx:1.27.1-alpine
COPY --from=builder /app/public /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Khởi động Nginx
CMD ["nginx", "-g", "daemon off;"]
