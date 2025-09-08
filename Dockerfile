# Stage 1: Build React app
FROM node:18-alpine as builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
# Elastic Beanstalk expects port 8080
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]