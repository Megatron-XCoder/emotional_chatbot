FROM node:18-alpine

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies using pnpm
RUN pnpm install

# Copy the rest of your application code
COPY . .

EXPOSE 3000

CMD [ "npm", "run", "dev" ]
