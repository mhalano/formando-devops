variable "cluster_name" {
  type    = string
  default = "cluster"
}

variable "kubernetes_version" {
  type    = string
  default = "v1.22.0"
}

variable "kind_config" {
  default = <<EOT
kind: InitConfiguration
nodeRegistration: 
  kubeletExtraArgs: 
    node-labels: role=infra
    taints: 
    - effect: NoSchedule
      key: dedicated
      value: infra
EOT
}
