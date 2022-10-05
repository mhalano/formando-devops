resource "kind_cluster" "default" {
  name       = var.cluster_name
  node_image = "kindest/node:${var.kubernetes_version}"

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    node {
      role = "worker"
      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"role=infra\"\n"
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    taints:\n    - effect: \"NoSchedule\"\n      key: \"dedicated\"\n      value: \"infra\"\n"
      ]
    }

    node {
      role = "control-plane"
      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"role=app\"\n"
      ]
    }
  }
}
