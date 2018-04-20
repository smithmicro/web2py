FROM centos:7
LABEL AUTHOR "Dave Sperling <dsperling@smithmicro.com>"

# overridable environment variables
ENV WEB2PY_VERSION=
ENV WEB2PY_PASSWORD=

WORKDIR /opt/web2py

RUN yum -y update && yum -y install \
  	epel-release \
 && yum -y install \
  	gcc \
    git \
  	python-devel \
  	python-pip \
  	tkinter \
 && pip install \
    requests \
    uwsgi \
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
