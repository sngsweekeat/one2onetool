FROM nodejscn/node:latest
ARG QNDATA
ENV DATA_FILE=${QNDATA}

WORKDIR /one2onetool

COPY package*.json ./

RUN npm install

EXPOSE 3000/tcp

COPY . .

CMD ["npm","start"]

