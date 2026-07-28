from datetime import timedelta
from pathlib import Path

import pendulum
from cosmos import DbtDag, ExecutionConfig, ProfileConfig, ProjectConfig, RenderConfig
from cosmos.constants import ExecutionMode, InvocationMode, LoadMode

DBT_PROJECT_PATH = Path("/opt/airflow/dbt/dbt_demo")
DBT_EXECUTABLE_PATH = Path("/opt/airflow/dbt_venv/bin/dbt")

dbt_demo_prod_watcher = DbtDag(
    dag_id="dbt_demo_prod_watcher",
    project_config=ProjectConfig(
        dbt_project_path=DBT_PROJECT_PATH,
        install_dbt_deps=True,
    ),
    profile_config=ProfileConfig(
        profile_name="dbt_demo",
        target_name="prod",
        profiles_yml_filepath=DBT_PROJECT_PATH / "profiles.yml",
    ),
    execution_config=ExecutionConfig(
        execution_mode=ExecutionMode.WATCHER,
        invocation_mode=InvocationMode.SUBPROCESS,
        dbt_executable_path=DBT_EXECUTABLE_PATH,
    ),
    render_config=RenderConfig(
        load_method=LoadMode.DBT_LS,
        invocation_mode=InvocationMode.SUBPROCESS,
        dbt_executable_path=DBT_EXECUTABLE_PATH,
    ),
    operator_args={
        "deferrable": True,
        "execution_timeout": timedelta(hours=2),
    },
    default_args={
        "owner": "data-platform",
        "retries": 1,
        "retry_delay": timedelta(minutes=1),
    },
    schedule=None,
    start_date=pendulum.datetime(2026, 1, 1, tz="UTC"),
    catchup=False,
    max_active_runs=1,
    tags=["dbt", "cosmos", "prod", "watcher"],
)
