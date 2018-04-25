FROM python:2-alpine
LABEL AUTHOR "Dave Sperling <dsperling@smithmicro.com>"

# overridable environment variables
ENV WEB2PY_VERSION=
ENV WEB2PY_PASSWORD=
ENV WEB2PY_ADMIN_IP=

WORKDIR /opt/web2py

RUN apk update && apk add \
    build-base \
    git \
    linux-headers \
 && pip install --upgrade pip \
 && pip install uwsgi \
 && git clone --recursive https://github.com/web2py/web2py.git /opt/web2py \
 && mv /opt/web2py/handlers/wsgihandler.py /opt/web2py \
 && addgroup -g 1000 -S web2py \
 && adduser -u 1000 -S web2py -G web2py \
 && chown -R web2py:web2py /opt/web2py

COPY entrypoint.sh /opt

ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD [ "http" ]
USER web2py

EXPOSE 8080 9090
