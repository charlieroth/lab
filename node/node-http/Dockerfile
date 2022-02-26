FROM node:17.2-alpine

WORKDIR node-http

COPY src/ .
COPY .nodemonrc.development package*.json ./
COPY .env.development .

RUN npm ci --production

USER node

ENV NODE_VERSION=17.2.0
ENV NODE_ENV=development

EXPOSE 3000:3000

CMD ["npm", start"]
