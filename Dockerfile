# Base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy Strapi source code
COPY . .

# Set app keys for Strapi (needed by config/server.js)
ENV APP_KEYS=myKeyA,myKeyB

# Build admin panel
RUN npm run build

# Expose Strapi port
EXPOSE 1337

# Start Strapi
CMD ["npm", "start"]

