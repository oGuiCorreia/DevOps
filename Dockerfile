# Use a imagem base do OWASP ZAP Stable
FROM zaproxy/zap-stable

# Copie o arquivo index.html para o diretório padrão do Nginx
COPY index.html /usr/share/nginx/html

# Exponha a porta 8080 para o OWASP ZAP e a porta 80 para o Nginx
EXPOSE 8080 80

# Comando de inicialização padrão do contêiner Nginx
CMD ["nginx", "-g", "daemon off;"]
