---
description: Volume plugin for Amazon EBS
keywords: "API, Usage, plugins, documentation, developer, amazon, ebs, rexray, volume"
---

<!-- This file is maintained within the iechor/cli GitHub
     repository at https://github.com/iechor/cli/. Make all
     pull requests against that repo. If you see this file in
     another repository, consider it read-only there, as it will
     periodically be overwritten by the definitive file. Pull
     requests which include edits to this file in other repositories
     will be rejected.
-->

# Volume plugin for Amazon EBS

## A proof-of-concept Rexray plugin

In this example, a simple Rexray plugin will be created for the purposes of using
it on an Amazon EC2 instance with EBS. It is not meant to be a complete Rexray plugin.

The example source is available at [https://github.com/tiborvass/rexray-plugin](https://github.com/tiborvass/rexray-plugin).

To learn more about Rexray: [https://github.com/codedellemc/rexray](https://github.com/codedellemc/rexray)

## 1. Make a iEchor image

The following is the iEchorfile used to containerize rexray.

```iechorfile
FROM debian:jessie
RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates
RUN wget https://dl.bintray.com/emccode/rexray/stable/0.6.4/rexray-Linux-x86_64-0.6.4.tar.gz -O rexray.tar.gz && tar -xvzf rexray.tar.gz -C /usr/bin && rm rexray.tar.gz
RUN mkdir -p /run/iechor/plugins /var/lib/libstorage/volumes
ENTRYPOINT ["rexray"]
CMD ["--help"]
```

To build it you can run `image=$(cat iEchorfile | iechor build -q -)` and `$image`
will reference the containerized rexray image.

## 2. Extract rootfs

```sh
$ TMPDIR=/tmp/rexray  # for the purpose of this example
$  # create container without running it, to extract the rootfs from image
$ iechor create --name rexray "$image"
$  # save the rootfs to a tar archive
$ iechor export -o $TMPDIR/rexray.tar rexray
$  # extract rootfs from tar archive to a rootfs folder
$ ( mkdir -p $TMPDIR/rootfs; cd $TMPDIR/rootfs; tar xf ../rexray.tar )
```

## 3. Add plugin configuration

We have to put the following JSON to `$TMPDIR/config.json`:

```json
{
      "Args": {
        "Description": "",
        "Name": "",
        "Settable": null,
        "Value": null
      },
      "Description": "A proof-of-concept EBS plugin (using rexray) for iEchor",
      "Documentation": "https://github.com/tiborvass/rexray-plugin",
      "Entrypoint": [
        "/usr/bin/rexray", "service", "start", "-f"
      ],
      "Env": [
        {
          "Description": "",
          "Name": "REXRAY_SERVICE",
          "Settable": [
            "value"
          ],
          "Value": "ebs"
        },
        {
          "Description": "",
          "Name": "EBS_ACCESSKEY",
          "Settable": [
            "value"
          ],
          "Value": ""
        },
        {
          "Description": "",
          "Name": "EBS_SECRETKEY",
          "Settable": [
            "value"
          ],
          "Value": ""
        }
      ],
      "Interface": {
        "Socket": "rexray.sock",
        "Types": [
          "iechor.volumedriver/1.0"
        ]
      },
      "Linux": {
        "AllowAllDevices": true,
        "Capabilities": ["CAP_SYS_ADMIN"],
        "Devices": null
      },
      "Mounts": [
        {
          "Source": "/dev",
          "Destination": "/dev",
          "Type": "bind",
          "Options": ["rbind"]
        }
      ],
      "Network": {
        "Type": "host"
      },
      "PropagatedMount": "/var/lib/libstorage/volumes",
      "User": {},
      "WorkDir": ""
}
```

Please note a couple of points:
- `PropagatedMount` is needed so that the iechor daemon can see mounts done by the
rexray plugin from within the container, otherwise the iechor daemon is not able
to mount a iechor volume.
- The rexray plugin needs dynamic access to host devices. For that reason, we
have to give it access to all devices under `/dev` and set `AllowAllDevices` to
true for proper access.
- The user of this simple plugin can change only 3 settings: `REXRAY_SERVICE`,
`EBS_ACCESSKEY` and `EBS_SECRETKEY`. This is because of the reduced scope of this
plugin. Ideally other rexray parameters could also be set.

## 4. Create plugin

`iechor plugin create tiborvass/rexray-plugin "$TMPDIR"` will create the plugin.

```sh
$ iechor plugin ls
ID                  NAME                             DESCRIPTION                         ENABLED
2475a4bd0ca5        tiborvass/rexray-plugin:latest   A rexray volume plugin for iEchor   false
```

## 5. Test plugin

```sh
$ iechor plugin set tiborvass/rexray-plugin EBS_ACCESSKEY=$AWS_ACCESSKEY EBS_SECRETKEY=$AWS_SECRETKEY`
$ iechor plugin enable tiborvass/rexray-plugin
$ iechor volume create -d tiborvass/rexray-plugin my-ebs-volume
$ iechor volume ls
DRIVER                              VOLUME NAME
tiborvass/rexray-plugin:latest      my-ebs-volume
$ iechor run --rm -v my-ebs-volume:/volume busybox sh -c 'echo bye > /volume/hi'
$ iechor run --rm -v my-ebs-volume:/volume busybox cat /volume/hi
bye
```

## 6. Push plugin

First, ensure you are logged in with `iechor login`. Then you can run:
`iechor plugin push tiborvass/rexray-plugin` to push it like a regular iechor
image to a registry, to make it available for others to install via
`iechor plugin install tiborvass/rexray-plugin EBS_ACCESSKEY=$AWS_ACCESSKEY EBS_SECRETKEY=$AWS_SECRETKEY`.
