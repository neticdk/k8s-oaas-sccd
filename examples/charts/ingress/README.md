# poc-kind-contour-httpproxies

![Version: 1.0.3](https://img.shields.io/badge/Version-1.0.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart to create http proxies on contour

**Homepage:** <https://github.com/neticdk/k8s-oaas-sccd>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Kim Nørgaard | kn@netic.dk |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | contour | 2.3.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| contour.envoy.dnsPolicy | string | `"ClusterFirstWithHostNet"` |  |
| contour.envoy.hostNetwork | bool | `true` |  |
| http_proxies[0].labels."netic.dk/cni.id" | string | `"root-context-hander"` |  |
| http_proxies[0].name | string | `"handle-root-context"` |  |
| http_proxies[0].namespace | string | `"netic-oaas-system"` |  |
| http_proxies[0].spec.includes[0].conditions[0].prefix | string | `"/team-a"` |  |
| http_proxies[0].spec.includes[0].name | string | `"team-a-proxy"` |  |
| http_proxies[0].spec.includes[0].namespace | string | `"team-a"` |  |
| http_proxies[0].spec.includes[1].conditions[0].prefix | string | `"/team-b"` |  |
| http_proxies[0].spec.includes[1].name | string | `"team-b-proxy"` |  |
| http_proxies[0].spec.includes[1].namespace | string | `"team-b"` |  |
| http_proxies[0].spec.routes[0].services[0].name | string | `"kuard"` |  |
| http_proxies[0].spec.routes[0].services[0].port | int | `80` |  |
| http_proxies[0].spec.routes[1].conditions[0].prefix | string | `"/oaas-prometheus"` |  |
| http_proxies[0].spec.routes[1].pathRewritePolicy.replacePrefix[0].prefix | string | `"/oaas-prometheus"` |  |
| http_proxies[0].spec.routes[1].pathRewritePolicy.replacePrefix[0].replacement | string | `"/"` |  |
| http_proxies[0].spec.routes[1].services[0].name | string | `"netic-oaas-prometheus"` |  |
| http_proxies[0].spec.routes[1].services[0].port | int | `9090` |  |
| http_proxies[0].spec.routes[2].conditions[0].prefix | string | `"/oaas-grafana"` |  |
| http_proxies[0].spec.routes[2].pathRewritePolicy.replacePrefix[0].prefix | string | `"/oaas-grafana"` |  |
| http_proxies[0].spec.routes[2].pathRewritePolicy.replacePrefix[0].replacement | string | `"/"` |  |
| http_proxies[0].spec.routes[2].services[0].name | string | `"netic-oaas-grafana"` |  |
| http_proxies[0].spec.routes[2].services[0].port | int | `80` |  |
| http_proxies[0].spec.virtualhost.fqdn | string | `"testing.local"` |  |

