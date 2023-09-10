# Defining Terraform Kuberenetes Provider
provider "kubernetes" {
 # context    = "cluster-admin@ionos_kube" # Already mentioned in config file.
}

# Defining a Kubernetes namespace for monitoring
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

# Defining a Helm release for Prometheus
resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  # Using values from prometheus.yaml file
  values = [
    file("prometheus.yaml")
  ]
}

# Defining a Helm release for Grafana
resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  # Using values from grafana-values.yaml file
  values = [
    file("grafana-values.yaml")
  ]
}

# Defining a Helm release for Blackbox Exporter
resource "helm_release" "blackbox-exporter" {
  name       = "blackbox-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-blackbox-exporter"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  # Using values from black-box-values.yaml file
  values = [
    file("black-box-values.yaml")
  ]
}
