import os
from re import template
import yaml
from ray.job_submission import JobSubmissionClient

"""
    uses the job SDK to submit the command
"""
def execute_job():
    assigned_job_id = os.getenv("JOB_ID")
    cluster_address = os.getenv("RAY_ADDRESS")
    template_location = os.getenv("CUSTOM_WORKING_DIR")
    config_file_location = f"{template_location}/config.yaml"

    assert assigned_job_id is not None, "JOB_ID cannot be none"
    assert cluster_address is not None, "RAY_ADDDRESS cannot be none"
    assert template_location is not None, "RAY_ADDDRESS cannot be none"
    assert os.path.isfile(config_file_location), f"config file config.yaml should be present at {template_location}"

    with open(config_file_location, "r") as config_file:
        print(f"reading configuration from {config_file_location}")
        config = yaml.safe_load(config_file)
        validate_config(config)
        #set the working directory to be what is provided by the user
        config["runtime_env"] = config.get("runtime_env", {})
        config["runtime_env"]["working_dir"] = template_location

    print(f"executing command ray job submit wiith job-id: {assigned_job_id} working_dir: ${template_location} address: {cluster_address}")
    client = JobSubmissionClient(address=cluster_address)
    job_id = client.submit_job(
        job_id=assigned_job_id,
        entrypoint=config['entrypoint'],
        runtime_env=config['runtime_env'],
        metadata=config['metadata']
    )


def validate_config(config):
    #print(f"config {config}")
    assert config['entrypoint'], "entry point cannot be empty"
    
if __name__ == "__main__":
    execute_job()