FROM quay.io/eclipse/che-devfile-registry:latest AS base
COPY --chown=0:0 . /var/www/html/devfiles/
USER 0
RUN cd /var/www/html && \
    find devfiles -name "devfile.yaml" | \
    python3 -c "
import sys, json
items = []
for f in sys.stdin:
    d = f.strip().split('/')
    items.append({'displayName': d[1], 'links': {'v2': '/devfiles/' + d[1] + '/devfile.yaml'}})
print(json.dumps(items))
" > /var/www/html/devfiles/index.json
EXPOSE 8080
CMD [\"httpd-foreground\"]
