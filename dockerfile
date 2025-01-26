# Use the official Nginx image from DockerHub
FROM nginx:latest

# Set the working directory to Nginx's default directory for serving HTML files
WORKDIR /usr/share/nginx/html

# Copy the HTML, CSS, and image files to the container
COPY . /usr/share/nginx/html

# Expose port 80 to allow external access
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
