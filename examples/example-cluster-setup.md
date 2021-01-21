# The example for cluster and teams

## Brief overview

- A namespace for the cluster flux instance is created (netic-oaas-system)
- Flux is deployed in this namespace using it's own git repository
- The helm operator is deployed in this namespace
- Code in the cluster flux git repository deploys the team namespaces.
- A Team may have their own git repository from which the flux instance, deployed in the team namespace, pulls.
- A nginx is installed by the Team A flux gitops engine in the team-a namespace.
- An apache is installed by the Team AB flux gitops engine in the team-b namespace.

## Cluster
If you already have a cluster, jump this section.
If you want a local cluster for the trial it can be setup using kind.
- Create a kind cluster with one control plane node and one worker node

### Create the cluster

```bash
kind create cluster --config examples/local/k8s.yaml --name oaas-sccd
```

## Install Secure Cluster
- Add the fluxcd helm repository
- Create the `netic-oaas-system` namespace
- Install the fluxcd helm operator CRDs
- Create kubernetes secrets for cluster flux and the helm operator
- Install fluxcd in the `netic-oaas-system` namespace
- Install the helm operator in the `netic-oaas-system` namespace

### Add helm repository

```bash
helm repo add oaas-flux https://neticdk.github.io/flux
helm repo add oaas-helm-operator https://neticdk.github.io/helm-operator
```

### Update Helm dependencies
If necessary update dependencies
```bash
$ helm dependency update .
```

### Create the `netic-oaas-system` namespace

```bash
kubectl apply -f examples/netic-oaas-system-bootstrap/namespace.yaml
```

### Create secrets for cluster flux

Create a keypair for the cluster and replace the private and public files under ssh folder or change the path for the secrets underneath

```bash
kubectl create secret generic cluster-flux-ssh --from-file=identity=examples/ssh/cluster --namespace netic-oaas-system
```

### Create secrets for operator

Create a keypair for the cluster and replace the private and public files under ssh folder or change the path for the secrets underneath

```bash
kubectl create secret generic helm-operator-ssh --from-file=identity=examples/ssh/operator --namespace netic-oaas-system
```

### Install fluxcd in `netic-oaas-system` namespace

Create a known_hosts file and replace that in the ssh folder or change the path in the command below underneath

```bash
helm upgrade -i flux oaas-flux/flux \
  --namespace netic-oaas-system \
  --set git.url=git@github.com:neticdk/k8s-oaas-sccd.git \
  --set git.secretName=cluster-flux-ssh \
  --set git.path=secure-cluster \
  --set git.readonly=true \
  --set sync.state=secret \
  --set git.branch=examples \
  --set git.pollInterval=2m \
  --set rbac.pspEnabled=true \
  --set registry.disableScanning=true \
  --set-file ssh.known_hosts=examples/ssh/known_hosts
```

### Install the operator in `netic-oaas-system` namespace
In order for this to work your are recommeded to create a separate repo for Team A e.g. on gihthub. Once you have done that, make sure that you copy the contents under `examples/secure-namespace-team-a` in a repo e.g. ´https://github.com/<user>/<team-a-repo>.git´ and update that in the `team-a.yaml` file placed in the `examples/secure-namespace-team-a` folder, and do the same for Team B.

```bash
helm upgrade -i helm-operator oaas-helm-operator/helm-operator \
  --namespace netic-oaas-system \
  --set helm.versions=v3 \
  --set allowNamespace=netic-oaas-system \
  --set rbac.pspEnabled=true \
  --set git.ssh.secretName=helm-operator-ssh \
  --set-file git.ssh.known_hosts=examples/ssh/known_hosts
```

### Example Configuration for a cluster and two teams
the cluster configuration is placed on a separate branc `examples` branch under [`secure-cluster`](https://github.com/neticdk/k8s-oaas-sccd/tree/examples/secure-cluster) and each of the teams are placed under the same branch. 
The teams are called [`team-a`](https://github.com/neticdk/k8s-oaas-sccd/tree/examples/secure-namespace-team-a) and [`team-b`](https://github.com/neticdk/k8s-oaas-sccd/tree/examples/secure-namespace-team-b)





