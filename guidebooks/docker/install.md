# Install and Run Docker

This guidebook checks whether [Docker](https://docs.docker.com/get-docker/) is installed and running.

```bash
---
validate: $body
---
(which docker >& /dev/null || (>&2 echo 'Please install Docker' && exit 1)) && (docker info >& /dev/null) && echo 'Docker is good to go' || (>&2 echo 'Please ensure that Docker is running' && exit 1)
```
