# Use a imagem base do Python
FROM python:3.9-slim

# Atualize o índice de pacotes e instale as dependências necessárias
RUN apt-get update && \
    apt-get install -y \
    openjdk-11-jre-headless \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Baixe e instale o OWASP ZAP
RUN wget -q -O - https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions.xml | grep -oP 'http.*?weekly[^<]+' | xargs wget -O /tmp/zap.tar.gz && \
    tar -xzf /tmp/zap.tar.gz -C /tmp && \
    mv /tmp/ZAP* /zap && \
    rm -rf /tmp/*

# Configure o OWASP ZAP e instale as dependências Python
RUN chmod +x /zap/zap.sh && \
    /zap/zap.sh -daemon -port 8083 && \
    pip install --upgrade pip && \
    pip install python-owasp-zap-v2.4

# Copie o arquivo index.html para o diretório padrão do Nginx
COPY index.html /usr/share/nginx/html

# Exponha a porta 8083 para o OWASP ZAP e a porta 80 para o Nginx
EXPOSE 8083 80

# Comando de inicialização padrão do contêiner Nginx
CMD ["nginx", "-g", "daemon off;"]
