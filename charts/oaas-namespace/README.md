# oaas-namespace

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart to initialize new namespace

**Homepage:** <https://github.com/neticdk/k8s-oaas-sccd>

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm repo add netic-oaas http://neticdk.github.io/k8s-oaas-sccd
$ helm install my-release netic-oaas/oaas-namespace
```

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

The chart will install configuration for Flux to deploy/reconcile based on a specific Git repository. It is necessary to configure this.

```yaml
git:
  url: ssh://git@github.com/neticdk/k8s-oaas-sccd.git
  ref:
    branch: examples
  secretRef:
    name: team-a-flux-ssh
kustomize:
  path: secure-namespace-team-a
```

By default the configuration will be restricted to only allow what is defined in `rbac.rules` full access may be granted setting `rbac.enabled` to `false`.

### Helm Operator

The chart allows for installing and configuring [Helm Operator](https://github.com/fluxcd/helm-operator/) to ease migration to `helm-controller`. This is disabled by default and
may be enabled setting `helm-operator.enabled` to `true`.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://neticdk.github.io/helm-operator | helm-operator | 1.2.2 |

## Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| createServiceAccount | bool | `false` | createServiceAccount to access the namespace with "edit" permissions (https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles) |
| git | object | `{"interval":"2m","ref":null,"secretRef":null,"url":null}` | configure git source repository |
| git.interval | string | `"2m"` | interval to check for updates |
| git.ref | string | `nil` | git reference (optional) |
| git.secretRef | string | `nil` | reference to secret with git credentials (optional) |
| git.url | string | `nil` | repository url |
| global.networkPolicyEnabled | bool | `true` | deploy network policy rules (including default deny rule) |
| helm-operator | object | `{"clusterRole":{"create":false},"enabled":false,"helm":{"versions":"v3"},"rbac":{"create":true,"pspEnabled":true,"rules":[{"apiGroups":[""],"resources":["services","configmaps","secrets","persistentvolumeclaims"],"verbs":["*"]},{"apiGroups":["apps"],"resources":["deployments","statefulsets"],"verbs":["*"]},{"apiGroups":["batch"],"resources":["cronjobs","jobs"],"verbs":["*"]},{"apiGroups":["extensions","networking.k8s.io"],"resources":["ingresses"],"verbs":["*"]},{"apiGroups":["monitoring.coreos.com"],"resources":["servicemonitors","podmonitors","prometheusrules","probes"],"verbs":["*"]},{"apiGroups":["projectcontour.io"],"resources":["httpproxies"],"verbs":["*"]},{"apiGroups":["policy"],"resources":["poddisruptionbudgets"],"verbs":["*"]}]},"resources":{"limits":{"cpu":"100m","memory":"256Mi"},"requests":{"cpu":"50m","memory":"64Mi"}}}` | helm-operator installed by subchart (see https://neticdk.github.io/helm-operator) DEPRECATED! This is kept currently to allow a smooth transition from Helm Operator to helm-controller of flux2 |
| kustomize | object | `{"interval":"5m","path":null,"prune":true}` | configure the kustomize applied to ns |
| kustomize.interval | string | `"5m"` | reconciliation interval |
| kustomize.path | string | `nil` | sub path within git source repo (optional) |
| kustomize.prune | bool | `true` | enables garbage collection |
| limitRange | object | `{"enabled":true,"spec":{"limits":[{"default":{"cpu":"250m","memory":"512Mi"},"defaultRequest":{"cpu":"100m","memory":"256Mi"},"type":"Container"}]}}` | limitRange can be used to set up the default used if a pod does not provide resource limits and requests |
| networkPolicies | list | `[]` | networkPolicies defines extra policies for namespace E.g., the below policy allowing ingress traffic for port 8080 for any pod/services labelled "netic.dk/network-ingress=default" ``` - name: default-ingress   spec:    podSelector:      matchLabels:        netic.dk/network-ingess: default    policyTypes:    - Ingress    ingress:      - from:        - podSelector: {}        ports:        - protocol: TCP          port: 8080 ``` |
| pspClusterRole | string | `""` | pspClusterRole makes a rolebinding for the default service account with the given cluster role setting up the default pod security policy for the default service account. |
| rbac.enabled | bool | `true` | restrict access to namespace |
| rbac.rules | list | `[{"apiGroups":[""],"resources":["services","configmaps","secrets","persistentvolumeclaims"],"verbs":["*"]},{"apiGroups":["apps"],"resources":["deployments","daemonset","statefulsets"],"verbs":["*"]},{"apiGroups":["batch"],"resources":["cronjobs","jobs"],"verbs":["*"]},{"apiGroups":["extensions","networking.k8s.io"],"resources":["ingresses"],"verbs":["*"]},{"apiGroups":["monitoring.coreos.com"],"resources":["servicemonitors","podmonitors","prometheusrules","probes"],"verbs":["*"]},{"apiGroups":["projectcontour.io"],"resources":["httpproxies"],"verbs":["*"]},{"apiGroups":["policy"],"resources":["poddisruptionbudgets"],"verbs":["*"]},{"apiGroups":["helm.toolkit.fluxcd.io"],"resources":["helmreleases"],"verbs":["*"]},{"apiGroups":["helm.fluxcd.io"],"resources":["helmreleases"],"verbs":["*"]}]` | default rules restricting access to namespace |
| resourceQuota | object | `{"enabled":true,"spec":{"hard":{"limits.cpu":"2","limits.memory":"2Gi","requests.cpu":"1","requests.memory":"1Gi"}}}` | resourceQuota specifies quota restrictions for namespace |

