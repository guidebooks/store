---
title: Install Docker
codeblocks:
    - match: ^(docker info >& /dev/null) && echo “You have Docker” || (>&2 echo “Please install Docker” && exit 1)$
      validate: $body
---

### [Docker](https://docs.docker.com/get-docker/)

```bash
(docker info >& /dev/null) && echo “You have Docker” || (>&2 echo 'Please install Docker' && exit 1)
```
