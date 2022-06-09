---
imports:
    - ../../../python/pip/tensorboard.md
---

# Running Tensorboard Locally

Launch Tensorboard, capturing its output.

```shell
export TB_OUT=$(mktemp)
```

```shell.async
python3 -m tensorboard.main --window_title "Tensorboard ${JOB_NAME-${JOB_ID}}" --logdir "${TB_LOGDIR}" 2>&1 | tee "${TB_OUT}"
```

We'll need to capture the port, which we do via the `TB_OUT`
file. First, wait the output to show up.

```shell
while true; do
    grep CTRL "${TB_OUT}" | awk '{print $4}' >& /dev/null && break || continue
done
```

Then, we can extract the port from `TB_OUT`, and format the Tensboard
URL from the captured port information.

```shell
export OPEN_THIS_URL=$(grep CTRL "${TB_OUT}" | awk '{print $4}')
```

And then open up a browser window pointing to that URL.

--8<-- "../../../util/open-url.md"
