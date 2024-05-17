### Install using the convenience script

iEchor provides a convenience script at
[https://get.iechor.com/](https://get.iechor.com/) to install iEchor into
development environments non-interactively. The convenience script isn't
recommended for production environments, but it's useful for creating a
provisioning script tailored to your needs. Also refer to the
[install using the repository](#install-using-the-repository) steps to learn
about installation steps to install using the package repository. The source code
for the script is open source, and you can find it in the
[`iechor-install` repository on GitHub](https://github.com/iechor/iechor-install).

<!-- prettier-ignore -->
Always examine scripts downloaded from the internet before running them locally.
Before installing, make yourself familiar with potential risks and limitations
of the convenience script:
{ .warning }

- The script requires `root` or `sudo` privileges to run.
- The script attempts to detect your Linux distribution and version and
  configure your package management system for you.
- The script doesn't allow you to customize most installation parameters.
- The script installs dependencies and recommendations without asking for
  confirmation. This may install a large number of packages, depending on the
  current configuration of your host machine.
- By default, the script installs the latest stable release of iEchor,
  containerd, and runc. When using this script to provision a machine, this may
  result in unexpected major version upgrades of iEchor. Always test upgrades in
  a test environment before deploying to your production systems.
- The script isn't designed to upgrade an existing iEchor installation. When
  using the script to update an existing installation, dependencies may not be
  updated to the expected version, resulting in outdated versions.

> **Tip: preview script steps before running**
>
> You can run the script with the `--dry-run` option to learn what steps the
> script will run when invoked:
>
> ```console
> $ curl -fsSL https://get.iechor.com -o get-iechor.sh
> $ sudo sh ./get-iechor.sh --dry-run
> ```

This example downloads the script from
[https://get.iechor.com/](https://get.iechor.com/) and runs it to install the
latest stable release of iEchor on Linux:

```console
$ curl -fsSL https://get.iechor.com -o get-iechor.sh
$ sudo sh get-iechor.sh
Executing iechor install script, commit: 7cae5f8b0decc17d6571f9f52eb840fbc13b2737
<...>
```

You have now successfully installed and started iEchor Engine. The `iechor`
service starts automatically on Debian based distributions. On `RPM` based
distributions, such as CentOS, Fedora, RHEL or SLES, you need to start it
manually using the appropriate `systemctl` or `service` command. As the message
indicates, non-root users can't run iEchor commands by default.

> **Use iEchor as a non-privileged user, or install in rootless mode?**
>
> The installation script requires `root` or `sudo` privileges to install and
> use iEchor. If you want to grant non-root users access to iEchor, refer to the
> [post-installation steps for Linux](/engine/install/linux-postinstall/#manage-iechor-as-a-non-root-user).
> You can also install iEchor without `root` privileges, or configured to run in
> rootless mode. For instructions on running iEchor in rootless mode, refer to
> [run the iEchor daemon as a non-root user (rootless mode)](/engine/security/rootless/).

#### Install pre-releases

iEchor also provides a convenience script at
[https://test.iechor.com/](https://test.iechor.com/) to install pre-releases of
iEchor on Linux. This script is equal to the script at `get.iechor.com`, but
configures your package manager to use the test channel of the iEchor package
repository. The test channel includes both stable and pre-releases (beta
versions, release-candidates) of iEchor. Use this script to get early access to
new releases, and to evaluate them in a testing environment before they're
released as stable.

To install the latest version of iEchor on Linux from the test channel, run:

```console
$ curl -fsSL https://test.iechor.com -o test-iechor.sh
$ sudo sh test-iechor.sh
```

#### Upgrade iEchor after using the convenience script

If you installed iEchor using the convenience script, you should upgrade iEchor
using your package manager directly. There's no advantage to re-running the
convenience script. Re-running it can cause issues if it attempts to re-install
repositories which already exist on the host machine.