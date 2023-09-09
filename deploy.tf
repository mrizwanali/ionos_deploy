provider "kubernetes" {
  config_path = env.KUBECONFIG
  context    = "cluster-admin@ionos_kube"
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  #version    = "your-prometheus-version"  # Replace with the desired version
  namespace   = "monitoring"

  values = [
    "${file("prometheus.yaml")}"
  ]
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace   = "monitoring"

  values = [
    "${file("grafana-values.yaml")}"
  ]
}


resource "helm_release" "blackbox-exporter" {
  name       = "blackbox-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-blackbox-exporter"
  #version    = "your-prometheus-version"  # Replace with the desired version
  namespace   = "monitoring"

  values = [
    "${file("black-box-values.yaml")}"
  ]
}

