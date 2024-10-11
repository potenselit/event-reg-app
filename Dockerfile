FROM node:22-alpine AS builder
WORKDIR /app
COPY ./erui/package*.json ./
RUN npm install
COPY ./erui .
RUN npx nx build erhome --configuration=development

FROM nginx:latest
EXPOSE 80
COPY nginx.conf /etc/nginx/nginx.conf
COPY custom_er.conf /etc/nginx/conf.d
COPY --from=builder /app/dist/apps/erhome /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]