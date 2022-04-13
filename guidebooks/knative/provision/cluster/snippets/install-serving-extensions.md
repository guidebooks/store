---
title: Install Serving Extensions
imports:
    - ../../../../kubernetes/kubectl.md
codeblocks:
    - match: ^kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.3.1/serving-hpa.yaml$
      validate: kn service describe serving-hpa
    - match: ^kubectl apply -f https://github.com/knative/net-certmanager/releases/download/knative-v1.3.0/release.yaml$
      validate: kn service describe release
    - match: ^kubectl apply -f https://github.com/knative/net-http01/releases/download/knative-v1.3.0/release.yaml$
      validate: kn service describe release
    - match: ^kubectl patch configmap/config-network \
          --namespace knative-serving \
          --type merge \
          --patch '{"data":{"certificate-class":"net-http01.certificate.networking.knative.dev"}}'$
      validate: $? -e 0 && exit 0 || exit 1
    - match: ^kubectl patch configmap/config-network \
          --namespace knative-serving \
          --type merge \
          --patch '{"data":{"auto-tls":"Enabled"}}'$
      validate: $? -e 0 && exit 0 || exit 1
---

## Install optional Serving extensions

The following tabs expand to show instructions for installing each Serving extension.

=== "HPA autoscaling"

    Knative also supports the use of the Kubernetes Horizontal Pod Autoscaler (HPA)
    for driving autoscaling decisions.

    * Install the components needed to support HPA-class autoscaling by running the command:

        ```bash
        kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.3.1/serving-hpa.yaml
        ```

    <!-- TODO(https://github.com/knative/docs/issues/2152): Link to a more in-depth guide on HPA-class autoscaling -->

=== "TLS with cert-manager"

    Knative supports automatically provisioning TLS certificates through
    [cert-manager](https://cert-manager.io/docs/). The following commands
    install the components needed to support the provisioning of TLS certificates
    through cert-manager.

    1. Install [cert-manager version v1.0.0 or later](../../installing-cert-manager.md).

    1. Install the component that integrates Knative with `cert-manager` by running the command:

        ```bash
        kubectl apply -f https://github.com/knative/net-certmanager/releases/download/knative-v1.3.0/release.yaml
        ```

    1. Configure Knative to automatically configure TLS certificates by following the steps in
    [Enabling automatic TLS certificate provisioning](../../../serving/using-auto-tls.md).

=== "TLS with HTTP01"

    Knative supports automatically provisioning TLS certificates using Encrypt HTTP01 challenges. The following commands install the components needed to support TLS.

    1. Install the net-http01 controller by running the command:

        ```bash
        kubectl apply -f https://github.com/knative/net-http01/releases/download/knative-v1.3.0/release.yaml
        ```

    2. Configure the `certificate-class` to use this certificate type by running the command:

        ```bash
        kubectl patch configmap/config-network \
          --namespace knative-serving \
          --type merge \
          --patch '{"data":{"certificate-class":"net-http01.certificate.networking.knative.dev"}}'
        ```

    3. Enable autoTLS by running the command:

        ```bash
        kubectl patch configmap/config-network \
          --namespace knative-serving \
          --type merge \
          --patch '{"data":{"auto-tls":"Enabled"}}'
        ```