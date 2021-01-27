# OaaS Secure Config flux2 Example

This branch contains an example configuring a cluster and using the oaas-namespace chart to bootstrap
namespace configuration. It will setup team a and team b to be reconciled from [secure-namespace-team-a](https://github.com/neticdk/k8s-oaas-sccd/tree/examples/secure-namespace-team-a)
and [secure-namespace-team-b](https://github.com/neticdk/k8s-oaas-sccd/tree/examples/secure-namespace-team-b).

## Migration from Flux and Helm Operator

Migration from teams using the Helm Operator may be handled by having the Helm Operator deployed alongside
the new helm-controller. This is enabled by setting `helm-operator.enabled` to `true` in the value of the
namespace chart (see [team-a.yaml](secure-cluster/namespaces/team-a.yaml) or [team-b.yaml](secure-cluster/namespaces/team-b.yaml)).
