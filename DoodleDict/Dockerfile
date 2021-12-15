FROM python:3.8.3-slim
RUN apt-get update \
	&& apt-get -y install libpq-dev gcc

RUN pip install --upgrade pip

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /code

COPY requirements.txt .
RUN pip install -r requirements.txt --default-timeout=1000

COPY . .
# ENTRYPOINT ["sh", "/code/entrypoint.sh"]
