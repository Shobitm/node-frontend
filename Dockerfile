#build environment
FROM node:alpine as build 
# Define working  directory 
WORKDIR /user/src/app
#Copy all Json files and packages from local to container
COPY package*.json ./
#Install all json packages and dependencies through npm
RUN npm install
#Now Copy all source code from local to container
COPY . .
#Expose the container port
#To run the project source code
RUN npm run build

#production environment
FROM nginx:stable-alpine
COPY --from=build /user/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx","-g", "daemon off;"]
