FROM python:2-slim-stretch
LABEL AUTHOR "Dave Sperling <dsperling@smithmicro.com>"

ENV WEB2PY_ROOT=/opt/web2py

# overridable environment variables
ENV WEB2PY_VERSION=
ENV WEB2PY_PASSWORD=
ENV WEB2PY_ADMIN_SECURITY_BYPASS=

WORKDIR $WEB2PY_ROOT

RUN apt-get update && apt-get -y install \
    gcc \
    git \
 && pip install uwsgi \
 && git clone --recursive https://github.com/web2py/web2py.git $WEB2PY_ROOT \
 && mv $WEB2PY_ROOT/handlers/wsgihandler.py $WEB2PY_ROOT \
 && groupadd -g 1000 web2py \
 && useradd -r -u 1000 -g web2py web2py \
 && chown -R web2py:web2py $WEB2PY_ROOT

COPY entrypoint.sh /opt

ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD [ "http" ]
USER web2py

EXPOSE 8080 9090
