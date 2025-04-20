ARG BUILD_FROM
FROM $BUILD_FROM

# Instala o nginx e o jq
RUN apk add --no-cache jq nginx

# Copia o nginx.conf personalizado
COPY nginx.conf /etc/nginx/nginx.conf

# Copia o script de inicialização
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expõe a porta usada pelo ingress
EXPOSE 21465

ENTRYPOINT [ "sh", "/start.sh" ]