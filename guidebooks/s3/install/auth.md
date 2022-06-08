# Initialize the minio client config file

```shell
export MC_CONFIG_DIR=$(mktemp -d)
```

```shell
echo "$MC_CONFIG_DIR"
```

```shell
cat << EOF > ${MC_CONFIG_DIR}/config.json
{
  "version": "10",
  "aliases": {
    "s3": {
      "url": "${S3_ENDPOINT}",
      "accessKey": "${S3_ACCESS_KEY_ID}",
      "secretKey": "${S3_SECRET_ACCESS_KEY}",
      "api": "S3v4",
      "path": "dns"
    }
  }
}
EOF
```
