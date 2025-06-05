# ScalableUECICDPipeline

> CI/CD pipeline template for Unreal Engine 5 projects using GitHub Actions, Kubernetes, and Helm.

This project aims to simplify the build, packaging, and deployment of Unreal Engine 5 projects in scalable environments using containerised infrastructure.

---

## 🚀 Features

- 🔁 GitHub Actions-based CI/CD
- 🐳 Containerised Unreal Engine build pipeline
- ☸️ Kubernetes-native deployment
- 🎛️ Helm charts with separate config for dev / sit / prod
- 🔄 GitOps ready (Flux / ArgoCD compatible)
- 📊 Optional observability with Prometheus & Grafana

---

## 🗂 Project Structure

├── .github/workflows/
│ └── deploy.yml
├── helm/
│ ├── Chart.yaml
│ ├── templates/
│ │ ├── deployment.yaml
│ │ ├── ingress.yaml
│ │ ├── service.yaml
│ │ └── _helpers.tpl
│ ├── values-dev.yaml
│ ├── values-sit.yaml
│ └── values-prod.yaml
├── Dockerfile
└── README.md

---

## 🖥️ Local Development

To run the UE5 container locally:

1. **Build the Docker image:**

```bash
docker build -t ue5-local-pipeline .

docker run -it --rm \
  -e LOG_LEVEL=debug \
  -e UE_MODE=development \
  -p 8080:8080 \
  ue5-local-pipeline

curl http://localhost:8080
```

🔄 CI/CD Overview

GitHub Actions is configured to deploy to Kubernetes based on branch:

dev - Development - helm upgrade --install with values-dev.yaml
sit - SIT/UAT - helm upgrade --install with values-sit.yaml
main - Production - helm upgrade --install with values-prod.yaml


☸️ Kubernetes Deployment via Helm

To deploy manually (e.g., for dev):

```bash
helm upgrade --install ue5-dev ./helm \
  -f ./helm/values-dev.yaml \
  --namespace ue5-dev \
  --create-namespace
```

To rollback:

```bash
helm rollback ue5-dev 1
```

🔁 GitOps Integration

This project is GitOps-ready. You can define an ArgoCD Application like so:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: ue5-dev
spec:
  project: default
  source:
    repoURL: https://github.com/AGreatPigeon/ScalableUECICDPipeline.git
    path: helm
    targetRevision: dev
    helm:
      valueFiles:
        - values-dev.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: ue5-dev
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

Similar manifests can be created for sit and prod.

📈 Observability (Optional)

Prometheus and Grafana support can be toggled in the values.yaml files:

```yaml
observability:
  enabled: true
  prometheus: true
  grafana: true
```

📋 Roadmap

- Package build artifacts from UE5 into persistent volume
- Publish to artifact repo (e.g., GitHub Releases or S3)
- Slack / Discord notifications
- Cloud-native asset delivery pipeline (CDN)

📄 License
MIT License – see LICENSE file for details.
