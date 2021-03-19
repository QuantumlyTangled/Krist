FROM node:15-alpine

WORKDIR /usr/src/krist

# Install packages
COPY package*.json ./
COPY yarn.lock /

# Install packages
RUN \
    apk add --no-cache --update \
        git \
        ca-certificates \
        python2 && \
    update-ca-certificates --fresh && \
    rm -rf /var/cache/apk/*

# Install dependencies
RUN yarn install

# Install source
COPY . .

# Generate docs
RUN \
    yarn run docs

# Run Krist
EXPOSE 8080
ENV NODE_ENV=production

CMD ["yarn", "run", "start"]
