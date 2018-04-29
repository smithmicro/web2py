FROM centos:7
LABEL AUTHOR "Dave Sperling <dsperling@smithmicro.com>"

ENV WEB2PY_ROOT=/opt/web2py

# overridable environment variables
ENV WEB2PY_VERSION=
ENV WEB2PY_PASSWORD=
ENV WEB2PY_ADMIN_SECURITY_BYPASS=
ENV UWSGI_OPTIONS=

WORKDIR $WEB2PY_ROOT

RUN yum -y update && yum -y install \
    epel-release \
 && yum -y install \
    gcc \
    git \
    pcre-devel \
    python-devel \
    python-pip \
    tkinter \
 && pip install --upgrade pip \
 && pip install uwsgi \
 && git clone --recursive https://github.com/web2py/web2py.git $WEB2PY_ROOT \
 && mv $WEB2PY_ROOT/handlers/wsgihandler.py $WEB2PY_ROOT \
 && groupadd -g 1000 web2py \
 && useradd -r -u 1000 -g web2py web2py \
 && chown -R web2py:web2py $WEB2PY_ROOT

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "http" ]
USER web2py

EXPOSE 8080 9090
