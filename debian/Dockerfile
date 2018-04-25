FROM python:2-slim-stretch
LABEL AUTHOR "Dave Sperling <dsperling@smithmicro.com>"

# overridable environment variables
ENV WEB2PY_VERSION=
ENV WEB2PY_PASSWORD=
ENV WEB2PY_ADMIN_IP=

WORKDIR /opt/web2py

RUN apt-get update && apt-get -y install \
    gcc \
    git \
 && pip install uwsgi \
 && git clone --recursive https://github.com/web2py/web2py.git /opt/web2py \
 && mv /opt/web2py/handlers/wsgihandler.py /opt/web2py \
 && groupadd -g 1000 web2py \
 && useradd -r -u 1000 -g web2py web2py \
 && chown -R web2py:web2py /opt/web2py

COPY entrypoint.sh /opt

ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD [ "http" ]
USER web2py

EXPOSE 8080 9090
