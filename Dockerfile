# Stage 1: Build the application
FROM node:14 AS builder

# Set working directory
WORKDIR /app

# Copy package.json to the working directory
COPY package.json /app/

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve the application
FROM node:14

# Set working directory
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app ./

# Install production dependencies
RUN npm install --only=production

# Expose the port the app runs on
EXPOSE 8080

# Command to run the app
CMD ["npm", "start", "--", "-p", "8080"]
