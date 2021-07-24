FROM python:3.7-alpine
MAINTAINER Atul Rai

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

RUN pip install --upgrade pip && \
	apk add --update --no-cache postgresql-client && \
	apk add --update alpine-sdk && apk add libffi-dev \
		openssl-dev cargo rust && \
	apk add --update --no-cache --virtual .tmp-deps \
		build-base postgresql-dev musl-dev && \
	pip install -r /requirements.txt && \
	apk del .tmp-deps && \
	adduser --disabled-password --no-create-home app

USER app
