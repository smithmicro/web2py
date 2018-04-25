#!/bin/bash

selectVersion() {
  if [ "$WEB2PY_VERSION" != '' ]; then
    git checkout $WEB2PY_VERSION
  fi
}

adminPassword() {
  if [ "$WEB2PY_PASSWORD" != '' ]; then
    python -c "from gluon.main import save_password; save_password('$WEB2PY_PASSWORD',443)"
  fi
}

# Run uWSGI using the uwsgi protocol
if [ "$1" = 'uwsgi' ]; then
  # switch to a particular Web2py version if specificed
  selectVersion
  # add an admin password if specified
  adminPassword
  # run uwsgi
  exec uwsgi --socket 0.0.0.0:9090 --protocol uwsgi --chdir /opt/web2py --wsgi wsgihandler:application --master
fi

# Run uWSGI using http
if [ "$1" = 'http' ]; then
  # switch to a particular Web2py version if specificed
  selectVersion
  # add an admin password if specified
  adminPassword
  # run uwsgi
  exec uwsgi --http 0.0.0.0:8080 --chdir /opt/web2py --wsgi wsgihandler:application --master
fi

# Run using the builtin Rocket web server
if [ "$1" = 'rocket' ]; then
  # switch to a particular Web2py version if specificed
  selectVersion
  # Use the -a switch to specify the password
  exec python web2py.py -a '$WEB2PY_PASSWORD' -i 0.0.0.0 -p 8080
fi

exec "$@"
