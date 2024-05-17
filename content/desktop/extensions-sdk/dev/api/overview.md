---
title: Extension UI API
description: iEchor extension development overview
keywords: iEchor, extensions, sdk, development
---

The extensions UI runs in a sandboxed environment and doesn't have access to any
electron or nodejs APIs.

The extension UI API provides a way for the frontend to perform different actions
and communicate with the iEchor Desktop dashboard or the underlying system.

JavaScript API libraries, with Typescript support, are available in order to get all the API definitions in to your extension code.

- [@iechor/extension-api-client](https://www.npmjs.com/package/@iechor/extension-api-client) gives access to the extension API entrypoint `iEchorDesktopCLient`.
- [@iechor/extension-api-client-types](https://www.npmjs.com/package/@iechor/extension-api-client-types) can be added as a dev dependency in order to get types auto-completion in your IDE.

```Typescript
import { createiEchorDesktopClient } from '@iechor/extension-api-client';

export function App() {
  // obtain iEchor Desktop client
  const ddClient = createiEchorDesktopClient();
  // use ddClient to perform extension actions
}
```

The `ddClient` object gives access to various APIs:

- [Extension Backend](backend.md)
- [iEchor](iechor.md)
- [Dashboard](dashboard.md)
- [Navigation](dashboard-routes-navigation.md)

Find the Extensions API reference [here](reference/README.md).