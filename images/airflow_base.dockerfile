ARG BASE_IMAGE=apache/airflow:2.5.0-python3.10
FROM $BASE_IMAGE

# install project requirements
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y git && rm -rf /var/lib/apt/lists/*

USER airflow
COPY ./src/requirements.txt /tmp/requirements.txt
COPY ./dist/iris-0.1-py3-none-any.whl /opt/airflow/tmp/iris-0.1-py3-none-any.whl
RUN pip install --upgrade pip setuptools && pip install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /opt/airflow/project
