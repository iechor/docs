---
title: Continuous Integration (CI)
description: Automatically test and validate your extension.
keywords: iEchor, Extensions, sdk, CI, test, regression
---

In order to help validate your extension and ensure it's functional, the Extension SDK provides tools to help you setup continuous integration for your extension.

> **Important**
>
> The [iEchor Desktop Action](https://github.com/iechor/desktop-action) and the [extension-test-helper library](https://www.npmjs.com/package/@iechor/extension-test-helper) are both [experimental](http://docs.iechor.com/release-lifecycle/#experimental).
{ .important }

## Setup CI environment with GitHub Actions

You need iEchor Desktop to be able to install and validate your extension.
You can start iEchor Desktop in GitHub Actions using the [iEchor Desktop Action](https://github.com/iechor/desktop-action), by adding the following to a workflow file:

```yaml
steps:
  - id: start_desktop
    uses: iechor/desktop-action/start@v0.1.0
```

> **Note**
>
> This action supports only Github Action macOS runners at the moment. You need to specify `runs-on: macOS-latest` for your end to end tests.

Once the step has executed, the next steps use iEchor Desktop and the iEchor CLI to install and test the extension.

## Validating your extension with Puppeteer

Once iEchor Desktop starts in CI, you can build, install, and validate your extension with Jest and Puppeteer.

First, build and install the extension from your test:

```ts
import { DesktopUI } from "@iechor/extension-test-helper";
import { exec as originalExec } from "child_process";
import * as util from "util";

export const exec = util.promisify(originalExec);

// keep a handle on the app to stop it at the end of tests
let dashboard: DesktopUI;

beforeAll(async () => {
  await exec(`iechor build -t my/extension:latest .`, {
    cwd: "my-extension-src-root",
  });

  await exec(`iechor extension install -f my/extension:latest`);
});
```

Then open the iEchor Dashboard and run some tests in your extension's UI:

```ts
describe("Test my extension", () => {
  test("should be functional", async () => {
    dashboard = await DesktopUI.start();

    const eFrame = await dashboard.navigateToExtension("my/extension");

    // use puppeteer APIs to manipulate the UI, click on buttons, expect visual display and validate your extension
    await eFrame.waitForSelector("#someElementId");
  });
});
```

Finally, close the iEchor Dashboard and uninstall your extension:

```ts
afterAll(async () => {
  dashboard?.stop();
  await exec(`iechor extension uninstall my/extension`);
});
```

## What's next

- Build an [advanced frontend](../build/frontend-extension-tutorial.md) extension.
- Learn more about extensions [architecture](../architecture/index.md).
- Learn how to [publish your extension](../extensions/index.md).