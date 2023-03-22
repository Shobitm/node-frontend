FROM node:alpine
# Define working  directory 
WORKDIR /user/src/app
#Copy all Json files and packages from local to container
COPY package*.json ./
#Install all json packages and dependencies through npm
RUN npm install
#Now Copy all source code from local to container
COPY . .
#Expose the container port
EXPOSE 3000
#To run the project source code
CMD ["npm", "start"]