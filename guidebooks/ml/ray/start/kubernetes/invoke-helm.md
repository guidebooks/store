---
imports:
  - kubernetes/helm3
---

```shell
export RAY_OPERATOR_IMAGE=${RAY_OPERATOR_IMAGE-rayproject/ray:2.1.0}
```

```shell
export RAY_VERSION=${RAY_VERSION=2.1.0}
```

```shell
export RAY_IMAGE=${RAY_IMAGE-$([ $NUM_GPUS = 0 ] && echo ${RAY_IMAGE_ORG-rayproject}/${RAY_IMAGE_NAME-ray}:${RAY_VERSION}${RAY_TAG_SUFFIX} || echo ${RAY_IMAGE_ORG-rayproject}/${RAY_IMAGE_NAME-ray-ml}:${RAY_VERSION}-gpu)}
```

```shell
--8<-- "./install-via-helm.sh"
```
