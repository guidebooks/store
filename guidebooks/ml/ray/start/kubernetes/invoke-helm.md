---
imports:
  - kubernetes/helm3
---

# Start A Ray Job via Helm

```shell
export RAY_OPERATOR_IMAGE=${RAY_OPERATOR_IMAGE-rayproject/ray:2.1.0}
```

```shell
export RAY_VERSION=${RAY_VERSION=2.1.0}
```

```shell
export RAY_IMAGE=${RAY_IMAGE-$([ $NUM_GPUS = 0 ] && echo ${RAY_IMAGE_ORG-rayproject}/${RAY_IMAGE_NAME-ray}:${RAY_VERSION}${RAY_TAG_SUFFIX--py38} || echo ${RAY_IMAGE_ORG-rayproject}/${RAY_IMAGE_NAME-ray-ml}:${RAY_VERSION}-gpu)}
```

```shell
--8<-- "./install-via-helm.sh"
```

```shell.async
for i in $(seq 1 2); do
    echo "🚀 $(tput setaf 3)You job has been submitted. It is now safe to disconnect from this session if you need to.$(tput sgr0)"
    sleep 10
done
```
