---
title: Install Knative - Quickstart
layout:
    1: left
    2: right
    default: wizard
imports:
    - ../../../kubernetes/kubectl.md
    - ../../kn.md
wizard:
    steps:
        - name: Install required tools
        - name: Install the quickstart CLI plugin
          description: The plugin sets up Knative against kind by creating a kind cluster populated with Knative
        - Instantiate Knative
        # - Clean Up
codeblocks:
    # Validation for step 2: install the knative quickstart plugin
    - match: ^brew install knative-sandbox/kn-plugins/quickstart$
      validate: kn quickstart --help
    - match: ^brew upgrade knative-sandbox/kn-plugins/quickstart$
      optional: true
    - match: ^kn quickstart --help$
      validate: $body
    - match: ^git clone https://github.com/knative-sandbox/kn-plugin-quickstart.git
      validate: $? -e 0 && exit 0 || exit 1
    - match: ^hack/build.sh$
      validate: $? -e 0 && exit 0 || exit 1
    - match: ^mv kn-quickstart /usr/local/bin$
      validate: kn quickstart --help
    # Validation for step 3: Run the knative quickstart plugin
    - match: ^kn quickstart kind$
      validate: kubectl cluster-info --context kind-knative
    - match: ^kn quickstart minikube$
      validate: minikube profile list
    - match: ^minikube tunnel --profile knative$
      validate: $? -e 0 && exit 0 || exit 1
    # Validation for Step 4: Clean Up
    # - match: ^kubectl delete --filename service.yaml$
    # - match : ^kn service delete helloworld-go$
    # - match: ^kind delete clusters knative$
    #   validate: (kubectl cluster-info --context kind-knative) && exit 1 || exit 0
    # - match: ^minikube delete -p knative$
    #   validate: (kubectl cluster-info --context kind-knative) && exit 1 || exit 0
---

--8<-- "https://raw.githubusercontent.com/kubernetes-sigs/kui/master/plugins/plugin-kubectl/notebooks/knative-what-is-it-good-for.md"

---

::imports

---

# Install Knative on kind or minikube

This solution gives you a quick way to install
[Knative](https://knative.dev) on your local machine. You may choose
to install Knative on either [kind](https://kind.sigs.k8s.io/) or
[minikube](https://minikube.sigs.k8s.io/).

---

# Install required tools

--8<-- "./snippets/quickstart.md"

<!-- --8<-- "./clean-up.md" -->
