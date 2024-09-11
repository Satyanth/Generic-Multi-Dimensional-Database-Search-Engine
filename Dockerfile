FROM node 
WORKDIR /app
COPY ./package*.json ./

# Install dependencies
RUN npm install
RUN npm install -g @angular/cli
# Copy the application code
COPY . .

# Build the application
RUN npm run build

# Expose the port Angular CLI uses by default
EXPOSE 4200

# Start the Angular application
CMD ["ng", "serve", "--host", "0.0.0.0"]