# Use uma imagem base do Ubuntu
FROM ubuntu:latest

# Atualize o índice de pacotes e instale as dependências necessárias
RUN apt-get update && \
    apt-get install -y \
    openjdk-11-jre-headless \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Baixe e instale o OWASP ZAP
RUN wget -q -O - https://github.com/zaproxy/zaproxy/releases/download/v2.10.0/ZAP_2.10.0_Linux.tar.gz | tar -xzf - -C /opt

# Defina o comando de entrada padrão para iniciar o OWASP ZAP
ENTRYPOINT ["/opt/ZAP_2.10.0/zap.sh"]
