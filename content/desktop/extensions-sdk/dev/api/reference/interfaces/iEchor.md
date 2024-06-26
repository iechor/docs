---
description: iEchor extension API reference
keywords: iEchor, extensions, sdk, API, reference
---

# Interface: iEchor

**`Since`**

0.2.0

## Properties

### cli

• `Readonly` **cli**: [`iEchorCommand`](iEchorCommand.md)

You can also directly execute the iEchor binary.

```typescript
const output = await ddClient.iechor.cli.exec("volume", [
  "ls",
  "--filter",
  "dangling=true"
]);
```

Output:

```json
{
  "stderr": "...",
  "stdout": "..."
}
```

For convenience, the command result object also has methods to easily parse it depending on output format. See [ExecResult](ExecResult.md) instead.

---

Streams the output as a result of the execution of a iEchor command.
It is useful when the output of the command is too long, or you need to get the output as a stream.

```typescript
await ddClient.iechor.cli.exec("logs", ["-f", "..."], {
  stream: {
    onOutput(data): void {
        // As we can receive both `stdout` and `stderr`, we wrap them in a JSON object
        JSON.stringify(
          {
            stdout: data.stdout,
            stderr: data.stderr,
          },
          null,
          "  "
        );
    },
    onError(error: any): void {
      console.error(error);
    },
    onClose(exitCode: number): void {
      console.log("onClose with exit code " + exitCode);
    },
  },
});
```

## Methods

### listContainers

▸ **listContainers**(`options?`): `Promise`<`unknown`\>

Get the list of running containers (same as `iechor ps`).

By default, this will not list stopped containers.
You can use the option `{"all": true}` to list all the running and stopped containers.

```typescript
const containers = await ddClient.iechor.listContainers();
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `options?` | `any` | (Optional). A JSON like `{ "all": true, "limit": 10, "size": true, "filters": JSON.stringify({ status: ["exited"] }), }` For more information about the different properties see [the iEchor API endpoint documentation](http://docs.iechor.com/engine/api/v1.41/#operation/ContainerList). |

#### Returns

`Promise`<`unknown`\>

---

### listImages

▸ **listImages**(`options?`): `Promise`<`unknown`\>

Get the list of local container images

```typescript
const images = await ddClient.iechor.listImages();
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `options?` | `any` | (Optional). A JSON like `{ "all": true, "filters": JSON.stringify({ dangling: ["true"] }), "digests": true * }` For more information about the different properties see [the iEchor API endpoint documentation](http://docs.iechor.com/engine/api/v1.41/#tag/Image). |

#### Returns

`Promise`<`unknown`\>
