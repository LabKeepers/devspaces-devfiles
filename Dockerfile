FROM python:3-alpine AS builder
COPY devfiles/ /devfiles/
COPY scripts/generate-index.py /generate-index.py
RUN python3 /generate-index.py

FROM quay.io/eclipse/che-devfile-registry:latest
COPY --chown=0:0 --from=builder /devfiles/ /var/www/html/devfiles/
EXPOSE 8080
CMD ["httpd-foreground"]
