FROM python:2-alpine
LABEL AUTHOR "Dave Sperling <dsperling@smithmicro.com>"

ENV WEB2PY_ROOT=/opt/web2py

# overridable environment variables
ENV WEB2PY_VERSION=
ENV WEB2PY_PASSWORD=
ENV WEB2PY_ADMIN_SECURITY_BYPASS=

WORKDIR $WEB2PY_ROOT

RUN apk update && apk add \
    build-base \
    git \
    linux-headers \
 && pip install --upgrade pip \
 && pip install uwsgi \
 && git clone --recursive https://github.com/web2py/web2py.git $WEB2PY_ROOT \
 && mv $WEB2PY_ROOT/handlers/wsgihandler.py $WEB2PY_ROOT \
 && addgroup -g 1000 -S web2py \
 && adduser -u 1000 -S web2py -G web2py \
 && chown -R web2py:web2py $WEB2PY_ROOT

COPY entrypoint.sh /opt

ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD [ "http" ]
USER web2py

EXPOSE 8080 9090
