FROM node:18.17.1-bullseye as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app

#RUN npm install -g @angular/cli@18.17.1
RUN npm install
COPY . /app
RUN npm run build --prod

FROM nginx:1.17.1-alpine
COPY --from=build-step /app/dist/web-app /usr/share/nginx/html

# docker build --rm -t web-app/webapp:latest . 
#docker run --rm -d -p 4200:80 web-app/webapp
#docker build --rm -t poc/democorewebapi:latest .
#docker run --rm -d -p 8080:80 poc/democorewebapi