# Netic Namespace Template

The chart is intended to bootstrap new namespace with necessary policies and deployments. 

## To try this out in a cluster:
You can try it out on a local cluster or try it on a cluster you have already.

The chart can be tested locally using Kubernetes in Docker (kind).
A kind cluster can be created based on the cluster definition `local/kind-cluster.yaml`.

## Installation requirements
First make sure that:
 - kind is installed
 - kubectl is installed
 - helm is installed

or using brew:
```bash
brew install kubectl
brew install helm
brew install kind
```

### Create a local cluster
All the following commands assume current directory is the chart root.
Starting up a local kind cluster on the cluster definition `examples/local/kind-cluster.yaml`.
```bash
$ kind create cluster --name oaas --config examples/local/k8s.yaml 
```
### Access the created local kind cluster
```bash
$ kubectl cluster-info --context kind-oaas
```

### Create the desired namespace in the created local kind cluster
```bash
$ kubectl create ns netic-oaas-ateam
$ kubectl get ns
```

### Initialize Helm (if this is first time running this).
```bash
$ helm repo add fluxcd https://charts.fluxcd.io
```

### Update Helm dependencies
If necessary update dependencies
```bash
$ helm dependency update .
```

### Deploy the chart to the local kind cluster.
```bash
$ helm upgrade -i -n netic-oaas-ateam --create-namespace netic-oaas-ateam .
```
### See that the cluster is running with flux
```bash
$ kubectl get all -A 
```
### Delete the local created cluster
If you are done with the local cluster - you can delete that
```bash
$ kind delete cluster --name=oaas
```
## Default installation

### Namespace Resource Quotas

By default the chart will install a resource quota defined by `resourceQuota.spec`. This may disabled setting `resourceQuota.enabled` to false. See also [values.yaml](./values.yaml).


### Network Policies

A default network policy of deny all will be installed into the namespace. Additional policies may be
added as `networkPolicies`, e.g.:

```yaml
networkPolicies:
 - name: default-ingress
   spec:
     podSelector:
       matchLabels:
         netic.dk/network-ingess: default
     policyTypes:
      - Ingress
     ingress:
      - from:
        - podSelector: {}
        ports:
        - protocol: TCP
          port: 8080
```

The above allows ingress trafic to any pod labelled `netic.dk/network-ingress=default` from any other pod.


### Flux

By default the chart will install FluxCD into the namespace using the
official [Flux Helm Chart](https://github.com/fluxcd/flux/tree/master/chart/flux). It is necessary, though, to setup credentials for the GitOps repository, e.g.

```yaml
flux:
  git:
    url: "https://my.git.com/repo.git"
```

See the Flux chart documentation but not that the properties are "prefixed" with `flux`.

Flux will be locked down by default only able to create helmrelease manifests. This is configured from `flux.rbac.rules` - see the [values.yaml](./values.yaml) for defaults.


### Helm Operator

By default the chart will install Flux Helm Operator into the namespace using the official [Helm Operator Chart](https://github.com/fluxcd/helm-operator/tree/master/chart/helm-operator). The documented options are available using a prefix of `helm-operator`.

The Helm Operator will be locked down by default able to create `deployments`, `statefulsets`, `services`, `ingress`, `secrets`, and `configmaps`. See the default rules of the role in [values.yaml](./values.yaml).
