FROM python:3.9 as server
WORKDIR /usr/server/src/fastapi
COPY ./server/src /usr/server/src/fastapi/server/src
COPY ./server/Pipfile /usr/server/src/fastapi/
RUN python -m pip install pipenv \
   && pipenv install
EXPOSE 8000
HEALTHCHECK --interval=5s --timeout=5s --start-period=5s \
   CMD curl localhost:8000/health
CMD pipenv run fastapi run server/src/main.py --proxy-headers --host 0.0.0.0 --port 8000

FROM python:3.9 as client
WORKDIR /usr/client/
COPY ./client/src /usr/client/src/
COPY ./client/Pipfile /usr/client/
RUN python -m pip install pipenv \
   && pipenv install
CMD ["pipenv", "run", "python", "src/main.py"]

FROM nginx as load_balancer
RUN rm /etc/nginx/conf.d/default.conf
COPY loadbalancer/nginx.conf /etc/nginx/conf.d/default.conf
