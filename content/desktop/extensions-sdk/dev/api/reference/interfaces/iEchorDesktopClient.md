---
description: iEchor extension API reference
keywords: iEchor, extensions, sdk, API, reference
---

# Interface: iEchorDesktopClient

An amalgam of the v0 and v1 interfaces of the iEchor Desktop API client,
provided for backwards compatibility reasons. Unless you're working with
a legacy extension, use the v1 type instead.

## Properties

### backend

• `Readonly` **backend**: `undefined` \| [`BackendV0`](BackendV0.md)

The `window.ddClient.backend` object can be used to communicate with the backend defined in the vm section of
the extension metadata.
The client is already connected to the backend.

>**Warning**
>
> It will be removed in a future version. Use [extension](iEchorDesktopClient.md#extension) instead.
{ .warning }

#### Inherited from

iEchorDesktopClientV0.backend

___

### extension

• `Readonly` **extension**: [`Extension`](Extension.md)

The `ddClient.extension` object can be used to communicate with the backend defined in the vm section of the
extension metadata.
The client is already connected to the backend.

#### Inherited from

iEchorDesktopClientV1.extension

___

### desktopUI

• `Readonly` **desktopUI**: [`DesktopUI`](DesktopUI.md)

#### Inherited from

iEchorDesktopClientV1.desktopUI

___

### host

• `Readonly` **host**: [`Host`](Host.md)

#### Inherited from

iEchorDesktopClientV1.host

___

### iechor

• `Readonly` **iechor**: [`iEchor`](iEchor.md)

#### Inherited from

iEchorDesktopClientV1.iechor

## Container Methods

### listContainers

▸ **listContainers**(`options`): `Promise`<`unknown`\>

Get the list of running containers (same as `iechor ps`).

By default, this will not list stopped containers.
You can use the option `{"all": true}` to list all the running and stopped containers.

```typescript
const containers = await window.ddClient.listContainers();
```

>**Warning**
>
> It will be removed in a future version. Use [listContainers](iEchor.md#listcontainers) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `options` | `never` | (Optional). A JSON like `{ "all": true, "limit": 10, "size": true, "filters": JSON.stringify({ status: ["exited"] }), }` For more information about the different properties see [the iEchor API endpoint documentation](http://docs.iechor.com/engine/api/v1.41/#operation/ContainerList). |

#### Returns

`Promise`<`unknown`\>

#### Inherited from

iEchorDesktopClientV0.listContainers

___

## Image Methods

### listImages

▸ **listImages**(`options`): `Promise`<`unknown`\>

Get the list of images

```typescript
const images = await window.ddClient.listImages();
```

> **Warning**
> 
> It will be removed in a future version. Use [listImages](iEchor.md#listimages) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `options` | `never` | (Optional). A JSON like `{ "all": true, "filters": JSON.stringify({ dangling: ["true"] }), "digests": true }` For more information about the different properties see [the iEchor API endpoint documentation](http://docs.iechor.com/engine/api/v1.41/#tag/Image). |

#### Returns

`Promise`<`unknown`\>

#### Inherited from

iEchorDesktopClientV0.listImages

___

## Navigation Methods

### navigateToContainers

▸ **navigateToContainers**(): `void`

Navigate to the container's window in iEchor Desktop.
```typescript
window.ddClient.navigateToContainers();
```

> **Warning**
> 
> It will be removed in a future version. Use [viewContainers](NavigationIntents.md#viewcontainers) instead.
{ .warning }

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.navigateToContainers

___

### navigateToContainer

▸ **navigateToContainer**(`id`): `Promise`<`any`\>

Navigate to the container window in iEchor Desktop.
```typescript
await window.ddClient.navigateToContainer(id);
```

> **Warning**
>
> It will be removed in a future version.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `id` | `string` | The full container id, e.g. `46b57e400d801762e9e115734bf902a2450d89669d85881058a46136520aca28`. You can use the `--no-trunc` flag as part of the `iechor ps` command to display the full container id. |

#### Returns

`Promise`<`any`\>

A promise that fails if the container doesn't exist.

#### Inherited from

iEchorDesktopClientV0.navigateToContainer

___

### navigateToContainerLogs

▸ **navigateToContainerLogs**(`id`): `Promise`<`any`\>

Navigate to the container logs window in iEchor Desktop.
```typescript
await window.ddClient.navigateToContainerLogs(id);
```

> **Warning**
>
> It will be removed in a future version.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `id` | `string` | The full container id, e.g. `46b57e400d801762e9e115734bf902a2450d89669d85881058a46136520aca28`. You can use the `--no-trunc` flag as part of the `iechor ps` command to display the full container id. |

#### Returns

`Promise`<`any`\>

A promise that fails if the container doesn't exist.

#### Inherited from

iEchorDesktopClientV0.navigateToContainerLogs

___

### navigateToContainerInspect

▸ **navigateToContainerInspect**(`id`): `Promise`<`any`\>

Navigate to the container inspect window in iEchor Desktop.
```typescript
await window.ddClient.navigateToContainerInspect(id);
```

> **Warning**
>
> It will be removed in a future version.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `id` | `string` | The full container id, e.g. `46b57e400d801762e9e115734bf902a2450d89669d85881058a46136520aca28`. You can use the `--no-trunc` flag as part of the `iechor ps` command to display the full container id. |

#### Returns

`Promise`<`any`\>

A promise that fails if the container doesn't exist.

#### Inherited from

iEchorDesktopClientV0.navigateToContainerInspect

___

### navigateToContainerStats

▸ **navigateToContainerStats**(`id`): `Promise`<`any`\>

Navigate to the container stats to see the CPU, memory, disk read/write and network I/O usage.

```typescript
await window.ddClient.navigateToContainerStats(id);
```

> **Warning**
> 
> It will be removed in a future version.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `id` | `string` | The full container id, e.g. `46b57e400d801762e9e115734bf902a2450d89669d85881058a46136520aca28`. You can use the `--no-trunc` flag as part of the `iechor ps` command to display the full container id. |

#### Returns

`Promise`<`any`\>

A promise that fails if the container doesn't exist.

#### Inherited from

iEchorDesktopClientV0.navigateToContainerStats

___

### navigateToImages

▸ **navigateToImages**(): `void`

Navigate to the images window in iEchor Desktop.
```typescript
await window.ddClient.navigateToImages(id);
```

> **Warning**
>
> It will be removed in a future version. Use [viewImages](NavigationIntents.md#viewimages) instead.
{ .warning }

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.navigateToImages

___

### navigateToImage

▸ **navigateToImage**(`id`, `tag`): `Promise`<`any`\>

Navigate to a specific image referenced by `id` and `tag` in iEchor Desktop.
In this navigation route you can find the image layers, commands, created time and size.

```typescript
await window.ddClient.navigateToImage(id, tag);
```

> **Warning**
>
> It will be removed in a future version. Use [viewImage](NavigationIntents.md#viewimage) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `id` | `string` | The full image id (including sha), e.g. `sha256:34ab3ae068572f4e85c448b4035e6be5e19cc41f69606535cd4d768a63432673`. |
| `tag` | `string` | The tag of the image, e.g. `latest`, `0.0.1`, etc. |

#### Returns

`Promise`<`any`\>

A promise that fails if the container doesn't exist.

#### Inherited from

iEchorDesktopClientV0.navigateToImage

___

### navigateToVolumes

▸ **navigateToVolumes**(): `void`

Navigate to the volumes window in iEchor Desktop.

```typescript
await window.ddClient.navigateToVolumes();
```

> **Warning**
>
> It will be removed in a future version. Use [viewVolumes](NavigationIntents.md#viewvolumes) instead.
{ .warning }

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.navigateToVolumes

___

### navigateToVolume

▸ **navigateToVolume**(`volume`): `void`

Navigate to a specific volume in iEchor Desktop.

```typescript
window.ddClient.navigateToVolume(volume);
```

> **Warning**
>
> It will be removed in a future version. Use [viewVolume](NavigationIntents.md#viewvolume) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `volume` | `string` | The name of the volume, e.g. `my-volume`. |

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.navigateToVolume

___

### navigateToDevEnvironments

▸ **navigateToDevEnvironments**(): `void`

Navigate to the Dev Environments window in iEchor Desktop.

```typescript
window.ddClient.navigateToDevEnvironments();
```

> **Warning**
> 
> It will be removed in a future version. Use [viewDevEnvironments](NavigationIntents.md#viewdevenvironments) instead.
{ .warning }

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.navigateToDevEnvironments

___

## Other Methods

### execHostCmd

▸ **execHostCmd**(`cmd`): `Promise`<[`ExecResultV0`](ExecResultV0.md)\>

You can run binaries defined in the host section in the extension metadata.

```typescript
window.ddClient.execHostCmd(`cliShippedOnHost xxx`).then((cmdResult: any) => {
 console.log(cmdResult);
});
```

> **Warning**
> 
> It will be removed in a future version. Use [exec](ExtensionCli.md#exec) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `cmd` | `string` | The command to be executed. |

#### Returns

`Promise`<[`ExecResultV0`](ExecResultV0.md)\>

#### Inherited from

iEchorDesktopClientV0.execHostCmd

___

### spawnHostCmd

▸ **spawnHostCmd**(`cmd`, `args`, `callback`): `void`

Invoke an extension binary on your host and get the output stream.

```typescript
window.ddClient.spawnHostCmd(
  `cliShippedOnHost`,
  [`arg1`, `arg2`],
  (data: any, err: any) => {
    console.log(data.stdout, data.stderr);
    // Once the command exits we get the status code
    if (data.code) {
      console.log(data.code);
    }
  }
);
```

> **Warning**
>
> It will be removed in a future version. Use [exec](ExtensionCli.md#exec) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `cmd` | `string` | The command to be executed. |
| `args` | `string`[] | The arguments of the command to execute. |
| `callback` | (`data`: `any`, `error`: `any`) => `void` | The callback function where to listen from the command output data and errors. |

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.spawnHostCmd

___

### execiEchorCmd

▸ **execiEchorCmd**(`cmd`, `...args`): `Promise`<[`ExecResultV0`](ExecResultV0.md)\>

You can also directly execute the iEchor binary.

```typescript
const output = await window.ddClient.execiEchorCmd("info");
```

> **Warning**
>
> It will be removed in a future version. Use [exec](iEchorCommand.md#exec) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `cmd` | `string` | The command to execute. |
| `...args` | `string`[] | The arguments of the command to execute. |

#### Returns

`Promise`<[`ExecResultV0`](ExecResultV0.md)\>

The result will contain both the standard output and the standard error of the executed command:
```json
{
  "stderr": "...",
  "stdout": "..."
}
```
For convenience, the command result object also has methods to easily parse it depending on the output format:

- `output.lines(): string[]` splits output lines.
- `output.parseJsonObject(): any` parses a well-formed JSON output.
- `output.parseJsonLines(): any[]` parses each output line as a JSON object.

If the output of the command is too long, or you need to get the output as a stream you can use the
 * spawniEchorCmd function:

```typescript
window.ddClient.spawniEchorCmd("logs", ["-f", "..."], (data, error) => {
  console.log(data.stdout);
});
```

#### Inherited from

iEchorDesktopClientV0.execiEchorCmd

___

### spawniEchorCmd

▸ **spawniEchorCmd**(`cmd`, `args`, `callback`): `void`

> **Warning**
>
> It will be removed in a future version. Use [exec](iEchorCommand.md#exec) instead.
{ .warning }

#### Parameters

| Name | Type |
| :------ | :------ |
| `cmd` | `string` |
| `args` | `string`[] |
| `callback` | (`data`: `any`, `error`: `any`) => `void` |

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.spawniEchorCmd

___

### openExternal

▸ **openExternal**(`url`): `void`

Opens an external URL with the system default browser.

```typescript
window.ddClient.openExternal("https://iechor.com");
```

**Warning**
>
> It will be removed in a future version. Use [openExternal](Host.md#openexternal) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `url` | `string` | The URL the browser opens (must have the protocol `http` or `https`). |

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.openExternal

___

## Toast Methods

### toastSuccess

▸ **toastSuccess**(`msg`): `void`

Display a toast message of type success.

```typescript
window.ddClient.toastSuccess("message");
```

>**Warning`**
>
> It will be removed in a future version. Use [success](Toast.md#success) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `msg` | `string` | The message to display in the toast. |

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.toastSuccess

___

### toastWarning

▸ **toastWarning**(`msg`): `void`

Display a toast message of type warning.

```typescript
window.ddClient.toastWarning("message");
```

> **Warning**
>
> It will be removed in a future version. Use [warning](Toast.md#warning) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `msg` | `string` | The message to display in the toast. |

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.toastWarning

___

### toastError

▸ **toastError**(`msg`): `void`

Display a toast message of type error.

```typescript
window.ddClient.toastError("message");
```

>**Warning**
>
> It will be removed in a future version. Use [error](Toast.md#error) instead.
{ .warning }

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `msg` | `string` | The message to display in the toast. |

#### Returns

`void`

#### Inherited from

iEchorDesktopClientV0.toastError
