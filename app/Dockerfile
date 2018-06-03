FROM node:8.9.2
#Create app directory
RUN mkdir -p /data/app/sampleapp

WORKDIR /data/app/sampleapp

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY app .
RUN pwd
#RUN cd sampleapp

#COPY package*.json ./

RUN ls
RUN npm install
#RUN node RealtorSearch.js

# If you are building your code for production
# RUN npm install --only=production

# Bundle app sourc

EXPOSE 3000
CMD node index.js
