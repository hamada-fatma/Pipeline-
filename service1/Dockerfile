# Un simple Dockerfile qui exécute un conteneur Nginx
#FROM nginx:latest
# Utiliser l'image Nginx officielle
FROM nginx:latest

# Exposer le port 8080 au lieu du port par défaut 80
EXPOSE 8080

# Modifier le fichier de configuration Nginx pour écouter sur le port 8080
RUN sed -i 's/listen 80;/listen 8080;/' /etc/nginx/conf.d/default.conf
