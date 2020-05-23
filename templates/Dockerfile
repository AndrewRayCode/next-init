FROM node:12 as base

EXPOSE 3099

RUN apt-get update -qq && apt-get install -qy \ 
  vim\
  --no-install-recommends

ENV NODE_ENV=production
WORKDIR /node
RUN mkdir app && chown -R node:node .

WORKDIR /node/app

COPY package.json package-lock.json* ./
RUN npm ci && npm cache clean --force

USER node

# Development
FROM base as dev

ENV NODE_ENV=development
RUN npm install --only=development

CMD [ "npm", "run", "dev" ]

# Production
FROM base as prod

# In local development we bind mount the code, so we don't need it in container
COPY . .

CMD [ "next", "start" ]
