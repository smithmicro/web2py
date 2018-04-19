#!/bin/bash

# In order to use the docker-compose.yml at the root of this project, you need to create
# self-signed keys for nginx.

openssl req -x509 -new -newkey rsa:4096 -days 3652 -nodes -keyout web2py.key -out web2py.crt
