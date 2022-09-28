# Install and Run Docker

This guidebook checks whether [Docker](https://docs.docker.com/get-docker/) is installed and running.

```bash
---
validate: $body
---
(which docker >& /dev/null || (>&2 echo 'Error: Docker is not installed' && exit 1)) && (docker info >& /dev/null) && echo 'Docker is good to go' || (>&2 echo 'Error: Docker is not running' && exit 1)
```
