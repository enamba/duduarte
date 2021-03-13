FROM python:3.6.13-alpine3.13
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
RUN apk add --update nodejs npm
RUN npm install -g serverless
RUN mkdir /app
WORKDIR /app
RUN npm init -f
RUN npm install --save-dev serverless-wsgi serverless-python-requirements
RUN pip install flask
RUN pip install boto3

COPY *.py .
COPY *.yml .
RUN pip freeze > requirements.txt
RUN sls deploy
