# ScalableUECICDPipeline
Scalable Unreal Engine Game Backend CI/CD Pipeline

# Unreal Engine Backend Server

A scalable, containerised backend for an Unreal Engine project designed for online/multiplayer experiences. Built with DevOps best practices in mind — GitHub Actions CI/CD, Docker, Kubernetes, and GitOps-friendly.

## Features

- 🔁 CI/CD pipeline with GitHub Actions
- 🐳 Dockerised Unreal Engine dedicated server
- ☸️ Kubernetes deployment-ready
- 🔐 Supports GitHub Container Registry (GHCR)
- 🧠 Built with Infrastructure as Code and GitOps in mind

---

## 📁 Project Structure
/root
├── .github/workflows/ci-cd.yml # GitHub Actions pipeline
├── Dockerfile # Docker build for Unreal Engine server
├── k8s/
│ └── deployment.yml # Kubernetes deployment
├── MyGame.uproject # Unreal Engine project file
└── Source/ # Game source code


---

## ⚙️ Prerequisites

- [Unreal Engine 5.x](https://www.unrealengine.com/)
- [Docker](https://www.docker.com/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Optional: [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) for GitOps

---

## 🧪 Local Development & Testing

### Build Docker Image Locally

```bash
docker build -t mygame-server .
```

### Run Locally

```bash
docker run -it --rm -p 7777:7777/udp mygame-server
```

## GitHub Actions CI/CD

A GitHub Actions workflow is included to:
- Build and containerise the Unreal Engine server
- Push the image to GitHub Container Registry (GHCR)
- (Optional) Deploy to Kubernetes using ArgoCD or kubectl

See .github/workflows/ci-cd.yml for details.

## Kubernetes Deployment

### To deploy to Kubernetes:

```bash
kubectl apply -f k8s/deployment.yml
```

### To verify:

```bash
kubectl get pods
kubectl get svc
```

## Observability & Monitoring (Planned)

- Grafana dashboards for CPU/RAM/net usage
- Prometheus metrics scraping
- Optional Sentry integration for crash reporting

## Container Registry (GHCR)

To push manually:

```bash
docker tag mygame-server ghcr.io/YOUR-USERNAME/your-repo:latest
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
docker push ghcr.io/YOUR-USERNAME/your-repo:latest
```

## Roadmap / Ideas

- Helm chart for easier deployment
- Game state syncing backend (using Redis or PostgreSQL)
- NAT traversal & matchmaking service
- ArgoCD GitOps support
- Testing framework integration

## License
MIT License
