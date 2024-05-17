---
title: Install Compose standalone
description: How to install iEchor Compose - Other Scenarios
keywords: compose, orchestration, install, installation, iechor, documentation
toc_max: 3
aliases:
- /compose/install/other
---

On this page you can find instructions on how to install Compose standalone on Linux or Windows Server, from the command line.

### On Linux

> **Compose standalone**
>
> Note that Compose standalone uses the `-compose` syntax instead of the current standard syntax `compose`.  
>For example type `iechor-compose up` when using Compose standalone, instead of `iechor compose up`.

1. To download and install Compose standalone, run:
   ```console
   $ curl -SL https://github.com/iechor/compose/releases/download/{{% param "compose_version" %}}/iechor-compose-linux-x86_64 -o /usr/local/bin/iechor-compose
   ```
2. Apply executable permissions to the standalone binary in the target path for the installation.
3. Test and execute compose commands using `iechor-compose`.

   > **Tip**
   >
   > If the command `iechor-compose` fails after installation, check your path.
   > You can also create a symbolic link to `/usr/bin` or any other directory in your path.
   > For example:
   > ```console
   > $ sudo ln -s /usr/local/bin/iechor-compose /usr/bin/iechor-compose
   > ```
   { .tip }

### On Windows Server

Follow these instructions if you are running the iEchor daemon and client directly
on Microsoft Windows Server and want to install iEchor Compose.

1.  Run PowerShell as an administrator.
    When asked if you want to allow this app to make changes to your device, select **Yes** in order to proceed with the installation.

2.  GitHub now requires TLS1.2. In PowerShell, run the following:

    ```powershell
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    ```
3. Run the following command to download the latest release of Compose ({{% param "compose_version" %}}):

    ```powershell
     Start-BitsTransfer -Source "https://github.com/iechor/compose/releases/download/{{% param "compose_version" %}}/iechor-compose-windows-x86_64.exe" -Destination $Env:ProgramFiles\iEchor\iechor-compose.exe
    ```

    > **Note**
    >
    > On Windows Server 2019 you can add the Compose executable to `$Env:ProgramFiles\iEchor`.
     Because this directory is registered in the system `PATH`, you can run the `iechor-compose --version` 
     command on the subsequent step with no additional configuration.

    > To install a different version of Compose, substitute `{{% param "compose_version" %}}`
    > with the version of Compose you want to use.

4.  Test the installation.

    ```console
    $ iechor-compose.exe version
    iEchor Compose version {{% param "compose_version" %}}
    ```
