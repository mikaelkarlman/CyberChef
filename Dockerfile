FROM node:10.24.0-stretch as builder

RUN mkdir -p /code && \
    chown node:node /code

USER node:node 

WORKDIR /code

COPY --chown=node:node . . 

RUN npm install && npm run build

FROM nginx:1.19.9-alpine

COPY --from=builder /code/build/prod /usr/share/nginx/html

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \
    --retries=3 CMD [ "curl" , "-f" "localhost:80", "||", "exit", "1"]

CMD ["nginx", "-g", "daemon off;"]