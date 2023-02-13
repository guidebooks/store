# Use Ray v1

Override default Ray v2, since we depend on Ray v1.

```shell
export RAY_VERSION_MAJOR=1
```

```shell
export RAY_VERSION_MINOR=13
```

```shell
export RAY_VERSION_PATCH=1
```

```shell
export RAY_VERSION=${RAY_VERSION_MAJOR}.${RAY_VERSION_MINOR}.${RAY_VERSION_PATCH}
```

```shell
export RAY_PIP_VERSION=${RAY_VERSION_MAJOR}.${RAY_VERSION_MINOR}
```
