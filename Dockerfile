FROM node:10.24.0-stretch

RUN mkdir -p /usr/src/app && \
    chown node:node /usr/src/app

USER node:node 

WORKDIR /usr/src/app

COPY --chown=node:node . . 

RUN npm install

ENV PORT=8080

EXPOSE ${PORT}
STOPSIGNAL SIGINT

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \
    --retries=3 CMD [ "curl" , "-f" "localhost:${PORT}", "||", "exit", "1"]
CMD ["npm", "start"]