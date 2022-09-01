---
imports:
    - ml/ray/install/cli
---

# Stopping Ray Locally

This will stop Ray on your laptop.

```shell
export RAY_ADDRESS=http://127.0.0.1:8265
```
        
```shell
curl $RAY_ADDRESS/api/cluster_status >& /dev/null && ray stop
```
