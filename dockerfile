FROM nginx

RUN apt-get update && apt-get install -y \
    python \
    python-pip \
    && pip install --upgrade pip

RUN pip install python-owasp-zap-v2.4

COPY index.html /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
