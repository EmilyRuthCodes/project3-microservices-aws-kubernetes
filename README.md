This project deploys a simple coworking space service using Docker, AWS, and Kubernetes.

The goal was to learn how to build Docker images, push them to AWS ECR, and deploy them using EKS.

The application is containerized using a Dockerfile, and the build process is managed by AWS CodeBuild. A buildspec.yml file defines the steps needed to authenticate with Amazon ECR, build the image, and push it to a container registry.

Amazon ECR stores the container images, tagged automatically during the build process. Every new code commit triggers the build pipeline, generating a fresh image and storing it in ECR.

Kubernetes configuration files include deployments, services, a ConfigMap and a Secret for database credentials.

The application connects to a PostgreSQL database, which is also deployed via Kubernetes using postgresql-deployment.yaml and postgresql-service.yaml.
Service status is verified using kubectl get pods, kubectl get svc, and kubectl describe commands to ensure the application and database are running correctly.

AWS CloudWatch Container Insights is used to monitor logs and application health. Logs show periodic health checks and confirm that the application runs without errors.

To release an updated version, changes are pushed to the github repository,  a webhook is used to trigger a new build and image upload via CodeBuild.
Once the image is updated, the Kubernetes deployment can be reapplied to update the running service.