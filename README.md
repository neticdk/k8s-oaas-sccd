# k8s-oaas-sccd
a gitops based secure cluster and secure namespaces setup for kubernetes as a part of Operations as a Service (OaaS)

Operations as a Service for kubernetes is a "shift-left" approach for development for security and operations. 
Operations as a Service for kubernetes consists of a number of repositories, where this is the foundation because it contains the Observability part that makes operations possible. 
This repository includes the gitOps secure cluster packages, there are other foundational packages under the OaaS umbrella such as:


* [observable cluster (potential common ingestpoint for operations on-demand)](https://github.com/neticdk/k8s-oaas-observability)

* [secure cluster (gitOps based secDevOps Control Plane)](https://github.com/neticdk/k8s-oaas-sccd)
  
* [cluster tools (advanced secrets management including backup and restore)](https://github.com/neticdk/k8s-oaas-tools)

Kubernetes Operations as a Service - Secure Cluster consist of a helm chart, scripts etc and will be include an Operator that prepares a kubernetes cluster for being secure and gitOps enabled at the cluster level as well as at the namespace level.

# Operations as a Service - Secure Cluster
The Secure Cluster is the coined term used for a gitOps enabled cluster setup, that installs a gitOps engine in a dedicated namespace and sets a number of sensible defaults for the cluster as well as for each additionally generated namespace.
The defaults are e.g. pod security policies, pod security context, default limits and network polices which should be hellpful to have configured from the start of development. The target audience for this is clusters used by one or more teams developing applications and services.

Currently this is based on FluxCD and Helm Operator.
