# Enable Ray Workflows?

=== "I need to configure S3 storage for Ray Workflows"

    Choose this if your code uses [Ray Workflows](https://docs.ray.io/en/latest/workflows/management.html) **and** you want to run workflows across more than one node. In this case, Ray requires that you set up S3 storage to facilitate the communication between the workers. If you will running only against the Ray head node, with no additional workers, you will **not** need this.
    
    :import{./index}

=== "My code does not need this"

    :import{./default}
