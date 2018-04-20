# Web2py Docker Image
This image combines web2py and uWSGI into one flexible image.  It supports 3 modes: HTTP via web2py, HTTP via uWSGI or the uwsgi protocol.

## Getting started
To run a simple example using HTTP:
```
docker run -p 8080:8080 smithmicro/web2py
```
Then open a web browser to:  http://localhost:8080

## Features
* Supports the HTTP protocol to support standalone testing.
* Supports uWSGI to be used in conjuntion with a web server such as nginx.
* Image offloads concerns for HTTPS to another container, such as nginx.  This simplifies the web2py container and makes it general purpose.
* Applications can be added by a volume share to /opt/web2py/applications/appname

## Command Line Options

|command|operation|
|-------|---------|
|http   |Listen on port 8080 using `http://` using uWSGI in HTTP mode  (default) |
|uwsgi  |Listen on port 9090 using `uwsgi://` which is useful for connecting to a reverse proxy like nginx|
|rocket |Listen on port 8080 using `http:// ` with the built in Web2py Rocket web server|

Example:
```
docker run -it -p 8080:8080 smithmicro/web2py web2py
```

## Docker Environment Variables

|command|operation|default|
|-------|---------|-------|
|WEB2PY_VERSION |Use a specific version of web2pi | empty (current version) |
|WEB2PY_PASSWORD|Set the adminitrative password | empty |

## nginx example
To use the adminstration functions of web2py, you will need an SSL connection.
This can be achived by using the docker-compose.yml file at the root.
Run the following:

```
cd keys
./create-keys.sh
cd ..
docker-compose up
```

Steps:
* Visit: https://localhost:8443
* You will need to accept the browser warning of an unsafe site.
* Press the `Administrative Interface` button
* Enter `password` as the password to see the admin site.

## Useful Links
Web2py

http://www.web2py.com/

Install uWSGI on Centos

http://uwsgi-docs.readthedocs.io/en/latest/Install.html

How to split uWSGI and nginx into 2 microservices

https://medium.com/@greut/minimal-python-deployment-on-docker-with-uwsgi-bc5aa89b3d35

Configuring uWSGI

http://uwsgi-docs.readthedocs.io/en/latest/Configuration.html
