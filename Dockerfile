# Use an Nginx image to serve the app
FROM nginx:alpine

# Copy the built Angular app into the Nginx server
COPY ./dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]