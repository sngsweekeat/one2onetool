FROM nodejscn/node:latest
ARG QNDATA
ENV DATA_FILE=${QNDATA}

RUN apk add --update sudo

RUN addgroup -S npmuser && adduser -D -S npmuser -G npmuser

RUN echo "npmuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/npmuser && chmod 0440 /etc/sudoers.d/npmuser

WORKDIR /one2onetool

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000/tcp

USER npmuser

CMD ["sudo","npm","start"]

