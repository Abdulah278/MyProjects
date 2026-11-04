# Use the official Nginx base image from Docker Hub
FROM nginx

# Copy the favicon to the default Nginx HTML directory
COPY favicon.ico /usr/share/nginx/html/favicon.ico

# Copy the main HTML file to serve as the landing page
COPY index.html /usr/share/nginx/html/index.html

# Copy the JavaScript file to enable client-side functionality
COPY script.js /usr/share/nginx/html/script.js

# Copy the CSS file to define the visual presentation and styling
COPY style.css /usr/share/nginx/html/style.css

# Copy the JSON data file to serve structured content to the frontend
COPY data.json /usr/share/nginx/html/data.json
