---
title: Install a Networking Layer
imports:
    - ../../../../kubernetes/kubectl.md
codeblocks:
    - match: ^kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.3.0/kourier.yaml$
      validate: kn service describe kourier
    - match: ^kubectl patch configmap/config-network
      validate: $? -e 0 && exit 0 || exit 1
    - match: ^kubectl --namespace kourier-system get service kourier$
      validate: $? -e 0 && exit 0 || exit 1
    - match: ^kubectl apply -l knative.dev/crd-install=true -f https://github.com/knative/net-istio/releases/download/knative-v1.3.0/istio.yaml
      validate: kn service describe istio
    - match: ^kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.3.0/net-istio.yaml$
      validate: kn service describe net-istio
    - match: ^kubectl --namespace istio-system get service istio-ingressgateway$
      validate: $? -e 0 && exit 0 || exit 1
    - match: ^kubectl apply -f https://github.com/knative/net-contour/releases/download/knative-v1.3.0/contour.yaml$
      validate: kn service describe contour
    - match: ^kubectl apply -f https://github.com/knative/net-contour/releases/download/knative-v1.3.0/net-contour.yaml$
      validate: kn service describe net-contour
    - match: ^kubectl patch configmap/config-network \
          --namespace knative-serving \
          --type merge \
          --patch '{"data":{"ingress-class":"contour.ingress.networking.knative.dev"}}'$
      validate: $? -e 0 && exit 0 || exit 1
    - match: ^kubectl --namespace contour-external get service envoy$
      validate: $? -e 0 && exit 0 || exit 1
---

## Install a networking layer

The following tabs expand to show instructions for installing a networking layer.
Follow the procedure for the networking layer of your choice:

<!-- TODO: Link to document/diagram describing what is a networking layer.  -->
<!-- This indentation is important for things to render properly. -->

=== "Kourier (Choose this if you are not sure)"

    The following commands install Kourier and enable its Knative integration.

    1. Install the Knative Kourier controller by running the command:
    ```bash
    kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.3.0/kourier.yaml
    ```

    1. Configure Knative Serving to use Kourier by default by running the command:
      ```bash
      kubectl patch configmap/config-network \
        --namespace knative-serving \
        --type merge \
        --patch '{"data":{"ingress.class":"kourier.ingress.networking.knative.dev"}}'
      ```

    1. Fetch the External IP address or CNAME by running the command:

        ```bash
        kubectl --namespace kourier-system get service kourier
        ```

        !!! tip
            Save this to use in the following [Configure DNS](#configure-dns) section.


=== "Istio"

    The following commands install Istio and enable its Knative integration.

    1. Install a properly configured Istio by following the
    [Advanced Istio installation](../../installing-istio.md) instructions or by running the command:

        ```bash
        kubectl apply -l knative.dev/crd-install=true -f https://github.com/knative/net-istio/releases/download/knative-v1.3.0/istio.yaml
        kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.3.0/istio.yaml
        ```

    1. Install the Knative Istio controller by running the command:

        ```bash
        kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.3.0/net-istio.yaml
        ```

    1. Fetch the External IP address or CNAME by running the command:

        ```bash
        kubectl --namespace istio-system get service istio-ingressgateway
        ```

        !!! tip
            Save this to use in the following [Configure DNS](#configure-dns) section.


=== "Contour"

    The following commands install Contour and enable its Knative integration.

    1. Install a properly configured Contour by running the command:

        ```bash
        kubectl apply -f https://github.com/knative/net-contour/releases/download/knative-v1.3.0/contour.yaml
        ```
        <!-- TODO(https://github.com/knative-sandbox/net-contour/issues/11): We need a guide on how to use/modify a pre-existing install. -->

    1. Install the Knative Contour controller by running the command:
      ```bash
      kubectl apply -f https://github.com/knative/net-contour/releases/download/knative-v1.3.0/net-contour.yaml
      ```

    1. Configure Knative Serving to use Contour by default by running the command:
      ```bash
      kubectl patch configmap/config-network \
        --namespace knative-serving \
        --type merge \
        --patch '{"data":{"ingress-class":"contour.ingress.networking.knative.dev"}}'
      ```

    1. Fetch the External IP address or CNAME by running the command:

        ```bash
        kubectl --namespace contour-external get service envoy
        ```

        !!! tip
            Save this to use in the following [Configure DNS](#configure-dns) section.