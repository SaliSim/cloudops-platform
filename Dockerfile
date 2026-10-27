
FROM node:22-alpine AS dependencies

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci --omit=dev


FROM node:22-alpine AS runtime

ENV NODE_ENV=production

ENV PORT=8080


WORKDIR /app

COPY --from=dependencies --chown=node:node /app/node_modules  ./node_modules
COPY --chown=node:node app/src ./app/src
COPY --chown=node:node package.json ./

USER node

EXPOSE 8080

CMD ["node", "app/src/server.js"]