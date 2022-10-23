from airflow import DAG
from airflow.models import Variable

from datetime import datetime

from airflow.providers.google.cloud.operators.gcs import GCSSynchronizeBucketsOperator

