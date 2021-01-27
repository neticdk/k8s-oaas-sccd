# The example for cluster and teams

This directory contains files to showcase a multitenant/multiteam setup using the oaas-namespace chart
for setting up namespaces. Basically it will setup Flux as GitOps engine to control all deployments
and then assign limited privileges to a (simulated) Git repository for Team A and Team B.

## Brief overview

The following will be created.

- A namespace for the cluster flux instance is created (netic-gitops-system)
- The Flux components are deployed in this namespace
- Setup Flux configuration (`GitRepository` and `Kustomize`) to bootstrap cluster
- The bootstrap will deploy the team namespaces
- Each team may have their own Git repository - for the sake of simplicity this is just a subpath within the examples branch
- Team A GitOps code will deploy nginx in team-a namespace
- Team B GitOps code will deploy Apache in team-b namespace

## Installation requirements

The following dependencies are needed to run the example:
 - kind is installed
 - kubectl is installed
 - flux is installed

or using brew:
```bash
brew install kubectl
brew install kind
brew install fluxcd/tap/flux
```

## Cluster
If you already have a cluster, skip this section.

If you want a local cluster for the trial it can be setup using kind - a sample cluster configuration is provided.

```bash
kind create cluster --config examples/local/k8s.yaml --name oaas-sccd
```

## Install the Secure Cluster

- Install flux components
- Deploy cluster bootstrap configuration

### Install flux Components

The following will render manifests for all flux components and apply to the cluster which is
current in your kube config.

```bash
flux install -n netic-gitops-system \
  --components=source-controller,kustomize-controller,helm-controller,notification-controller \
  --network-policy=true \
  --watch-all-namespaces=true \
  --export \
  | sed 's/namespace: flux-system/namespace: netic-gitops-system/' \
  | kubectl apply -f -
```

### Deploy Bootstrap Configuration

The below will deploy manifests for flux to start reconciliation of the cluster configuration.

```bash
kubectl create secret generic cluster-flux-ssh \
  --from-file=identity=examples/ssh/cluster \
  --from-file=identity.pub=examples/ssh/cluster.pub \
  --from-file=known_hosts=examples/ssh/known_hosts \
  --namespace netic-gitops-system
kubectl apply -f examples/bootstrap/cluster.yaml
```

### Example Configuration for a cluster and two teams
The cluster configuration is placed on a separate branch `examples` in directory [`secure-cluster`](https://github.com/neticdk/k8s-oaas-sccd/tree/examples/secure-cluster). Each of the teams are placed under the same branch.
The teams are called [`team-a`](https://github.com/neticdk/k8s-oaas-sccd/tree/examples/secure-namespace-team-a) and [`team-b`](https://github.com/neticdk/k8s-oaas-sccd/tree/examples/secure-namespace-team-b)

### Verifying
Wait until everything is up an running, the last things to happen is seeing nginx and apache nginx running in the two namespaces created for `team-a` and `team-b` repectively. The namespaces are named after the teams. Once you see that is running and ready - it is possible to verify the setup as follows:

Perform a port forward locally:
```bash
$ kubectl port-forward service/contour-envoy -n netic-oaas-system 4444:80
```

And find a browser and type `http://localhost:4444` see kuard running (kubernetes up and running demo)
and check that the teams applications get traffic by typing `http://localhost:4444/team-a` and `http://localhost:4444/team-b` or use curl.

That's it.
