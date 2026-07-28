ARG AIRFLOW_VERSION=3.3.0
FROM apache/airflow:${AIRFLOW_VERSION}-python3.13

ARG AIRFLOW_VERSION

COPY --chown=airflow:root requirements-airflow.txt /tmp/requirements-airflow.txt
COPY --chown=airflow:root requirements-dbt.txt /tmp/requirements-dbt.txt

RUN pip install --no-cache-dir \
        "apache-airflow==${AIRFLOW_VERSION}" \
        -r /tmp/requirements-airflow.txt \
    && python -m venv /opt/airflow/dbt_venv \
    && /opt/airflow/dbt_venv/bin/pip install --no-cache-dir \
        -r /tmp/requirements-dbt.txt
