FROM node:alpine AS builder
# Setting up the work directory
WORKDIR /app
# Installing dependencies
COPY package*.json ./
RUN npm ci
# Copying all the files in our project
COPY . .
# Building our application
RUN npm run build
# 2nd stage
# Fetching the latest nginx image
FROM nginx:alpine
# Copying built assets from builder
COPY --from=builder /app/build /usr/share/nginx/html
# Copying our nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Expose port
EXPOSE 80
# Start nginx
CMD ["nginx", "-g", "daemon off;"]

# FROM httpd:alpine
# WORKDIR /var/www/html
# COPY --from=builder /app/build .
# # Expose port
# EXPOSE 80
