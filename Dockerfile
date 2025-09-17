FROM python:3.9 AS server
WORKDIR /usr/server/src/fastapi
COPY ./server/src /usr/server/src/fastapi/server/src
COPY ./server/Pipfile /usr/server/src/fastapi/
RUN python -m pip install pipenv \
   && pipenv install
EXPOSE 8000
HEALTHCHECK --interval=5s --timeout=5s --start-period=5s \
   CMD curl localhost:8000/health
CMD pipenv run fastapi run server/src/main.py --proxy-headers --host 0.0.0.0 --port 8000

FROM python:3.9 AS client
WORKDIR /usr/client/
COPY ./client/src /usr/client/src/
COPY ./client/Pipfile /usr/client/
RUN python -m pip install pipenv \
   && pipenv install
CMD pipenv run python src/main.py

FROM nginx AS load_balancer
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt install -y wget unzip
RUN wget https://releases.hashicorp.com/consul-template/0.41.1/consul-template_0.41.1_linux_amd64.zip -P /tmp
RUN unzip /tmp/consul-template_0.41.1_linux_amd64.zip -d /tmp && mv /tmp/consul-template /usr/local/bin/consul-template
# RUN rm /etc/nginx/conf.d/default.conf
# COPY loadbalancer/nginx.conf /etc/nginx/conf.d/default.conf
