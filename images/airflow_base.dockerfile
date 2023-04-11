ARG BASE_IMAGE=apache/airflow:2.5.0-python3.10
FROM $BASE_IMAGE

# install project requirements
COPY ./src/requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip setuptools && pip install --no-cache-dir -r /tmp/requirements.txt

COPY ./dist/iris-0.1-py3-none-any.whl /tmp/iris-0.1-py3-none-any.whl
RUN pip install /tmp/iris-0.1-py3-none-any.whl

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y git && rm -rf /var/lib/apt/lists/*

USER airflow
WORKDIR /opt/airflow/project
