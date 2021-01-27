# k8s-oaas-sccd

A GitOps based approach to configuring a [secure cluster](docs/secure-cluster-concepts.md) and
provisioning [secure namespaces](README.md) as a part of Operations as a Service (OaaS).

Kubernetes Operations as a Service - [Secure Cluster](docs/secure-cluster-concepts.md) consists
of a Helm chart for provisioning namespaces as well as an example setting this up. The roadmap
includes creating a Kubernetes operator to take over responsibility for namespace provisioning
in a more powerful and dynamic way.

## Operation as a Service for Kubernetes

Operations as a Service (OaaS) for Kubernetes is a "shift-left" approach for development for security and operations. OaaS for Kubernetes
consists of a number of repositories besides this one:

* [observable cluster (potential common ingestpoint for operations on-demand)](https://github.com/neticdk/k8s-oaas-observability)

* [cluster tools (advanced secrets management including backup and restore)](https://github.com/neticdk/k8s-oaas-tools)


## Operations as a Service - Secure Cluster
The Secure Cluster is the coined term used for a gitOps enabled cluster setup, that installs a gitOps engine in a
dedicated namespace and sets a number of sensible defaults for the cluster as well as for each additionally generated namespace.

## Operations as a Service - Secure Namespace
The defaults are e.g. pod security policies, pod security context, default limits and network polices which should be
helpful to have configured from the start of development. The target audience for this is clusters used by one or more
teams developing applications and services.

## Examples

An example setting up a cluster configured using GitOps and flux2 as well as using the `oaas-namespace` chart creating
namespaces for two teams is found under [examples](examples).
