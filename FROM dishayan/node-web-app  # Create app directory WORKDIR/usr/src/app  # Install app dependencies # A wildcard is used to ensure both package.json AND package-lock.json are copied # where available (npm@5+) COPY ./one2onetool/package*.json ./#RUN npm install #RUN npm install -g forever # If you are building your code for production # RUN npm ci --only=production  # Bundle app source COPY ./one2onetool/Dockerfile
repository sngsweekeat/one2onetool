FROM dishayan/node-web-app

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY ./one2onetool/package*.json ./

#RUN npm install
#RUN npm install -g forever
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY ./one2onetool/ .

EXPOSE 3000
CMD [ "forever", "--minUptime", "10000", "index.js" ]
