# oaas-namespace

![Version: 1.2.0](https://img.shields.io/badge/Version-1.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart to initialize new namespace

**Homepage:** <https://github.com/neticdk/k8s-oaas-sccd>

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm repo add netic-oaas http://neticdk.github.io/k8s-oaas-sccd
$ helm install my-release netic-oaas/oaas-namespace
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://neticdk.github.io/flux | flux | 1.6.2 |
| https://neticdk.github.io/helm-operator | helm-operator | 1.2.2 |

## Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| createServiceAccount | bool | `false` | createServiceAccount to access the namespace with "edit" permissions (https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles) |
| flux | object | `{"clusterRole":{"create":false},"enabled":true,"memcached":{"enabled":true,"resources":{"limits":{"cpu":"50m","memory":"256Mi"},"requests":{"cpu":"50m","memory":"64Mi"}}},"rbac":{"create":true,"pspEnabled":true,"rules":[{"apiGroups":[""],"resources":["secrets"],"verbs":["patch"]},{"apiGroups":["apps"],"resources":["deployments","daemonset","statefulset"],"verbs":["get","list","watch"]},{"apiGroups":[""],"resources":["secrets","serviceaccounts"],"verbs":["get","list","watch"]},{"apiGroups":["helm.fluxcd.io"],"resources":["helmreleases"],"verbs":["*"]}]},"resources":{"limits":{"cpu":"75m","memory":"128Mi"},"requests":{"cpu":"75m","memory":"64Mi"}},"syncGarbageCollection":{"enabled":true}}` | flux installed by subchart (see https://neticdk.github.io/flux) |
| global.networkPolicyEnabled | bool | `true` | deploy network policy rules (including default deny rule) |
| helm-operator | object | `{"clusterRole":{"create":false},"enabled":true,"helm":{"versions":"v3"},"rbac":{"create":true,"pspEnabled":true,"rules":[{"apiGroups":[""],"resources":["services","configmaps","secrets","persistentvolumeclaims"],"verbs":["*"]},{"apiGroups":["apps"],"resources":["deployments","statefulsets"],"verbs":["*"]},{"apiGroups":["batch"],"resources":["cronjobs","jobs"],"verbs":["*"]},{"apiGroups":["extensions","networking.k8s.io"],"resources":["ingresses"],"verbs":["*"]},{"apiGroups":["monitoring.coreos.com"],"resources":["servicemonitors","podmonitors","prometheusrules","probes"],"verbs":["*"]},{"apiGroups":["projectcontour.io"],"resources":["httpproxies"],"verbs":["*"]},{"apiGroups":["policy"],"resources":["poddisruptionbudgets"],"verbs":["*"]}]},"resources":{"limits":{"cpu":"100m","memory":"256Mi"},"requests":{"cpu":"50m","memory":"64Mi"}}}` | helm-operator installed by subchart (see https://neticdk.github.io/helm-operator) |
| limitRange | object | `{"enabled":true,"spec":{"limits":[{"default":{"cpu":"250m","memory":"512Mi"},"defaultRequest":{"cpu":"100m","memory":"256Mi"},"type":"Container"}]}}` | limitRange can be used to set up the default used if a pod does not provide resource limits and requests |
| networkPolicies | list | `[]` | networkPolicies defines extra policies for namespace E.g., the below policy allowing ingress traffic for port 8080 for any pod/services labelled "netic.dk/network-ingress=default" ```yaml - name: default-ingress   spec:    podSelector:      matchLabels:        netic.dk/network-ingess: default    policyTypes:    - Ingress    ingress:      - from:        - podSelector: {}        ports:        - protocol: TCP          port: 8080 ``` |
| pspClusterRole | string | `""` | pspClusterRole makes a rolebinding for the default service account with the given cluster role setting up the default pod security policy for the default service account. |
| resourceQuota | object | `{"enabled":true,"spec":{"hard":{"limits.cpu":"2","limits.memory":"2Gi","requests.cpu":"1","requests.memory":"1Gi"}}}` | resourceQuota specifies quota restrictions for namespace |

