FROM node:14-alpine AS development
ENV NODE_ENV development
# Add a work directory
WORKDIR /app
# Cache and Install dependencies
COPY package.json .
COPY package-lock.json .
RUN npm install
# Copy app files
COPY . .
# Start the app
CMD [ "npm", "start" ]

# pull official base image
FROM node:14-alpine

# set working directory
WORKDIR /app

# Copies package.json and package-lock.json to Docker environment
COPY package.json .
COPY package-lock.json .

# Installs all node packages
RUN npm install

# Copies everything over to Docker environment
COPY . .

# Build for production.
RUN npm run build --production

# Install `serve` to run the application.
RUN npm install -g serve

# Uses port which is used by the actual application
EXPOSE 5000

# Run application
#CMD [ "npm", "start" ]
CMD serve -s build

# Utilise l'image node version 14 à partir d'un iso alpine
FROM node:14-alpine
# Défini un dossier de travail
WORKDIR /app
# Copie les fichiers package.json et package-lock.json sur l'environnement Docker
COPY package.json .
COPY package-lock.json .
# Installe toute les dépendances node définie dans le fichier package.json
RUN npm install
# Copie tout dans l'environnement Docker
COPY . .
# Lance le build de production
RUN npm run build --production
# Installe `serve` pour lancer l'application
RUN npm install -g serve
# Commande pour lancer l'application
CMD [ "serve", "-s", "build" ]