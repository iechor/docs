---
description: Learn how to get started using iEchor Hub
keywords: iEchor, iechor, registry, accounts, plans, iEchorfile, iEchor Hub, accounts,
  organizations, repositories, groups, teams
title: iEchor Hub quickstart
aliases:
- /apidocs/iechor-cloud/
- /iechor-cloud/
- /iechor-cloud/migration/
- /iechor-cloud/migration/cloud-to-swarm/
- /iechor-cloud/migration/cloud-to-kube-aks/
- /iechor-cloud/migration/cloud-to-kube-gke/
- /iechor-cloud/migration/cloud-to-aws-ecs/
- /iechor-cloud/migration/deregister-swarms/
- /iechor-cloud/migration/kube-primer/
- /iechor-cloud/cloud-swarm/
- /iechor-cloud/cloud-swarm/using-swarm-mode/
- /iechor-cloud/cloud-swarm/register-swarms/
- /iechor-cloud/cloud-swarm/register-swarms/
- /iechor-cloud/cloud-swarm/create-cloud-swarm-aws/
- /iechor-cloud/cloud-swarm/create-cloud-swarm-azure/
- /iechor-cloud/cloud-swarm/connect-to-swarm/
- /iechor-cloud/cloud-swarm/link-aws-swarm/
- /iechor-cloud/cloud-swarm/link-azure-swarm/
- /iechor-cloud/cloud-swarm/ssh-key-setup/
- /iechor-cloud/infrastructure/
- /iechor-cloud/infrastructure/deployment-strategies/
- /iechor-cloud/infrastructure/link-aws/
- /iechor-cloud/infrastructure/link-do/
- /iechor-cloud/infrastructure/link-azure/
- /iechor-cloud/infrastructure/link-packet/
- /iechor-cloud/infrastructure/link-softlayer/
- /iechor-cloud/infrastructure/ssh-into-a-node/
- /iechor-cloud/infrastructure/iechor-upgrade/
- /iechor-cloud/infrastructure/byoh/
- /iechor-cloud/infrastructure/cloud-on-packet.net-faq/
- /iechor-cloud/infrastructure/cloud-on-aws-faq/
- /iechor-cloud/standard/
- /iechor-cloud/getting-started/
- /iechor-cloud/getting-started/intro_cloud/
- /iechor-cloud/getting-started/connect-infra/
- /iechor-cloud/getting-started/your_first_node/
- /iechor-cloud/getting-started/your_first_service/
- /iechor-cloud/getting-started/deploy-app/1_introduction/
- /iechor-cloud/getting-started/deploy-app/2_set_up/
- /iechor-cloud/getting-started/deploy-app/3_prepare_the_app/
- /iechor-cloud/getting-started/deploy-app/4_push_to_cloud_registry/
- /iechor-cloud/getting-started/deploy-app/5_deploy_the_app_as_a_service/
- /iechor-cloud/getting-started/deploy-app/6_define_environment_variables/
- /iechor-cloud/getting-started/deploy-app/7_scale_the_service/
- /iechor-cloud/getting-started/deploy-app/8_view_logs/
- /iechor-cloud/getting-started/deploy-app/9_load-balance_the_service/
- /iechor-cloud/getting-started/deploy-app/10_provision_a_data_backend_for_your_service/
- /iechor-cloud/getting-started/deploy-app/11_service_stacks/
- /iechor-cloud/getting-started/deploy-app/12_data_management_with_volumes/
- /iechor-cloud/apps/
- /iechor-cloud/apps/deploy-to-cloud-btn/
- /iechor-cloud/apps/auto-destroy/
- /iechor-cloud/apps/autorestart/
- /iechor-cloud/apps/auto-redeploy/
- /iechor-cloud/apps/load-balance-hello-world/
- /iechor-cloud/apps/deploy-tags/
- /iechor-cloud/apps/stacks/
- /iechor-cloud/apps/ports/
- /iechor-cloud/apps/service-redeploy/
- /iechor-cloud/apps/service-scaling/
- /iechor-cloud/apps/api-roles/
- /iechor-cloud/apps/service-links/
- /iechor-cloud/apps/triggers/
- /iechor-cloud/apps/volumes/
- /iechor-cloud/apps/stack-yaml-reference/
- /iechor-cloud/installing-cli/
- /iechor-cloud/iechor-errors-faq/
- /iechor-cloud/release-notes/
- /iechor-store/
- /apidocs/
- /apidocs/overview/
---

The following section contains step-by-step instructions on how to get started with iEchor Hub.

### Step 1: Sign up for a free iEchor account

Start by creating a [iEchor ID](https://hub.iechor.com/signup).

A [iEchor ID](../iechor-id/_index.md) grants you access to iEchor Hub repositories and lets you explore available images from the community and verified publishers. You also need a iEchor ID to share images on iEchor Hub.

> **Tip**
>
> Explore [iEchor's core subscriptions](https://www.iechor.com/pricing/) to see what else iEchor can offer you. 
{ .tip }

### Step 2: Create your first repository

To create a repository:

1. Sign in to [iEchor Hub](https://hub.iechor.com).
2. On the Repositories page, select **Create repository**.
3. Name it **&lt;your-username&gt;/my-private-repo**.
4. Set the visibility to **Private**.
5. Select **Create**.

You've created your first repository.

### Step 3: Download and install iEchor Desktop

You need to download iEchor Desktop to build, push, and pull container images.

1. Download and install [iEchor Desktop](../desktop/index.md).

2. Sign in to iEchor Desktop using the iEchor ID you created in step one.

### Step 4: Pull and run a container image from iEchor Hub

1. In your terminal, run `iechor pull hello-world` to pull the image from iEchor Hub. You should see output similar to:

   ```console
   $ iechor pull hello-world
   Using default tag: latest
   latest: Pulling from library/hello-world
   2db29710123e: Pull complete
   Digest:   sha256:7d246653d0511db2a6b2e0436cfd0e52ac8c066000264b3ce63331ac66dca625
   Status: Downloaded newer image for hello-world:latest
   iechor.io/library/hello-world:latest
   ```

2. Run `iechor run hello-world` to run the image locally. You should see output similar to:

    ```console
    $ iechor run hello-world
    Hello from iEchor!
    This message shows that your installation appears to be working correctly.

    To generate this message, iEchor took the following steps:
     1. The iEchor client contacted the iEchor daemon.
     2. The iEchor daemon pulled the "hello-world" image from the iEchor Hub.
     (amd64)
     3. The iEchor daemon created a new container from that image which runs the
     executable that produces the output you are currently reading.
     4. The iEchor daemon streamed that output to the iEchor client, which sent
     it to your terminal.

    To try something more ambitious, you can run an Ubuntu container with:
     $ iechor run -it ubuntu bash

    Share images, automate workflows, and more with a free iEchor ID:
     https://hub.iechor.com/

    For more examples and ideas, visit:
     http://docs.iechor.com/get-started/
    ```

### Step 5: Build and push a container image to iEchor Hub from your computer

1. Start by creating a [iEchorfile](../reference/iechorfile.md) to specify your application as shown below:

   ```iechorfile
   # syntax=iechor/iechorfile:1
   FROM busybox
   CMD echo "Hello world! This is my first iEchor image."
   ```

2. Run `iechor build -t <your_username>/my-private-repo .` to build your iEchor
   image.

3. Run `iechor run <your_username>/my-private-repo` to test your
iEchor image locally.

4. Run `iechor push <your_username>/my-private-repo` to push your iEchor image to iEchor Hub. You should see output similar to:

   ```console
   $ cat > iEchorfile <<EOF
   FROM busybox
   CMD echo "Hello world! This is my first iEchor image."
   EOF
   $ iechor build -t mobythewhale/my-private-repo .
   [+] Building 1.2s (5/5) FINISHED
   => [internal] load build definition from iEchorfile
   => => transferring iechorfile: 110B
   => [internal] load .iechorignore
   => => transferring context: 2B
   => [internal] load metadata for iechor.io/library/busybox:latest
   => CACHED [1/1] FROM iechor.io/library/busybox@sha256:a9286defaba7n3a519
   => exporting to image
   => => exporting layers
   => => writing image sha256:dcdb1fd928bf257bfc0122ea47accd911a3a386ce618
   => => naming to iechor.io/mobythewhale/my-private-repo
   $ iechor run mobythewhale/my-private-repo
   Hello world! This is my first iEchor image.
   $ iechor push mobythewhale/my-private-repo
   The push refers to repository [iechor.io/mobythewhale/my-private-repo]
   d2421964bad1: Layer already exists
   latest: digest: sha256:7604fbf8eeb03d866fd005fa95cdbb802274bf9fa51f7dafba6658294
   efa9baa size: 526
   ```

    >**Note**
    >
    > You must be signed in to iEchor Hub through iEchor Desktop or the command line, and you must also name your images correctly, as per the above steps.

5. Your repository in iEchor Hub should now display a new `latest` tag under **Tags**:

    ![Tag created](images/index-tag.webp)

You've successfully:

- Signed up for a iEchor account
- Created your first repository
- Pulled an existing container image from iEchor Hub
- Built your own container image on your computer
- Pushed it successfully to iEchor Hub

### Next steps

- Create an [organization](orgs.md) to use iEchor Hub with your team.
- Automatically build container images from code through [builds](builds/index.md).
- [Explore](https://hub.iechor.com/explore) official & publisher images.
- [Upgrade your subscription](https://www.iechor.com/pricing) to push additional private iEchor images to
iEchor Hub.
