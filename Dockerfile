FROM node:14-alpine
WORKDIR /usr/src/krist

# Install packages
COPY package*.json ./
COPY yarn.lock /

RUN apk add git ca-certificates

RUN yarn

# Install source
COPY . .

# Generate docs
RUN yarn run docs

# Run Krist
EXPOSE 8080
ENV NODE_ENV=production
CMD ["yarn", "run", "start"]
