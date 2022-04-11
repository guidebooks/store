---
layout: wizard
---

# Installing Knative Serving using YAML files

This topic describes how to install Knative Serving by applying YAML files using the `kubectl` CLI.

---

--8<-- "snippets/prerequisites.md"

---

## Install the Knative Serving component

To install the Knative Serving component:

1. Install the required custom resources by running the command:

    ```bash
    kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.3.1/serving-crds.yaml
    ```

1. Install the core components of Knative Serving by running the command:

    ```bash
    kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.3.1/serving-core.yaml
    ```

    !!! info
        For information about the YAML files in Knative Serving, see [Knative Serving installation files](serving-installation-files.md).

## Verify the installation

!!! success
    Monitor the Knative components until all of the components show a `STATUS` of `Running` or `Completed`.
    You can do this by running the following command and inspecting the output:

    ```bash
    kubectl get pods -n knative-serving
    ```

    Example output:

    ```{ .bash .no-copy }
    NAME                                      READY   STATUS    RESTARTS   AGE
    3scale-kourier-control-54cc54cc58-mmdgq   1/1     Running   0          81s
    activator-67656dcbbb-8mftq                1/1     Running   0          97s
    autoscaler-df6856b64-5h4lc                1/1     Running   0          97s
    controller-788796f49d-4x6pm               1/1     Running   0          97s
    domain-mapping-65f58c79dc-9cw6d           1/1     Running   0          97s
    domainmapping-webhook-cc646465c-jnwbz     1/1     Running   0          97s
    webhook-859796bc7-8n5g2                   1/1     Running   0          96s
    ```

---

--8<-- "snippets/install-networking-layer.md"

---

<!-- These are snippets from the docs/snippets directory -->
<!-- {% include "dns.md" %}
{% include "real-dns-yaml.md" %}
{% include "temporary-dns.md" %} -->
--8<-- "https://raw.githubusercontent.com/mra-ruiz/docs/guidebooks/docs/snippets/dns.md"
--8<-- "https://raw.githubusercontent.com/mra-ruiz/docs/guidebooks/docs/snippets/real-dns-yaml.md"
--8<-- "https://raw.githubusercontent.com/mra-ruiz/docs/guidebooks/docs/snippets/temporary-dns.md"

---

--8<-- "snippets/install-serving-extensions.md"
