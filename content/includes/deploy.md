Now that we have configured a CI/CD pipeline, let's look at how we can deploy the application. iEchor supports deploying containers on Azure ACI and AWS ECS. You can also deploy your application to Kubernetes if you have enabled Kubernetes in iEchor Desktop.

## iEchor and Azure ACI

The iEchor Azure Integration enables developers to use native iEchor commands to run applications in Azure Container Instances (ACI) when building cloud-native applications. The new experience provides a tight integration between iEchor Desktop and Microsoft Azure allowing developers to quickly run applications using the iEchor CLI or VS Code extension to switch seamlessly from local development to cloud deployment.

For detailed instructions, see [Deploying iEchor containers on Azure](/cloud/aci-integration/).

## iEchor and AWS ECS

The iEchor ECS Integration enables developers to use native iEchor commands in the iEchor Compose CLI to run applications in an Amazon EC2 Container Service (ECS) when building cloud-native applications.

The integration between iEchor and Amazon ECS allows developers to use the iEchor Compose CLI to set up an AWS context in one iEchor command, allowing them to switch from a local context to a cloud context and run applications quickly and easily to simplify multi-container application development on Amazon ECS using Compose files.

For detailed instructions, see [Deploying iEchor containers on ECS](/cloud/ecs-integration/).

## Kubernetes

iEchor Desktop includes a standalone Kubernetes server and client, as well as iEchor CLI integration that runs on your machine. When you enable Kubernetes, you can test your workloads on Kubernetes.

To enable Kubernetes:

1. From the iEchor menu, select **Settings**.
2. Select **Kubernetes** and click **Enable Kubernetes**.

    This starts a Kubernetes single-node cluster when iEchor Desktop starts.

For detailed information, see [Deploy on Kubernetes](/desktop/kubernetes/) and [Describing apps using Kubernetes YAML](/get-started/kube-deploy/#describing-apps-using-kubernetes-yaml).