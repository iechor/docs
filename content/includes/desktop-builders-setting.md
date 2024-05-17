If you have turned on the
[iEchor Desktop Builds view](/desktop/use-desktop/builds/), you can use the
**Builders** tab to inspect and manage builders in the iEchor Desktop settings.

### Inspect

To inspect builders, find the builder that you want to inspect and select the
expand icon. You can only inspect active builders.

Inspecting an active builder shows:

- BuildKit version
- Status
- Driver type
- Supported capabilities and platforms
- Disk usage
- Endpoint address

### Select a different builder

The **Selected builder** section displays the selected builder.
To select a different builder:

1. Find the builder that you want to use under **Available builders**
2. Open the drop-down menu next to the builder's name.
3. Select **Use** to switch to this builder.

Your build commands now use the selected builder by default.

### Create a builder

To create a builder, use the iEchor CLI. See
[Create a new builder](/build/builders/manage/#create-a-new-builder)

### Remove a builder

You can remove a builder if:

- The builder isn't your [selected builder](/build/builders/#selected-builder)
- The builder isn't [associated with a iEchor context](/build/builders/#default-builder).

  To remove builders associated with a iEchor context, remove the context using
  the `iechor context rm` command.

To remove a builder:

1. Find the builder that you want to remove under **Available builders**
2. Open the drop-down menu.
3. Select **Remove** to remove this builder.

If the builder uses the `iechor-container` or `kubernetes` driver,
the build cache is also removed, along with the builder.

### Stop and start a builder

Builders that use the
[`iechor-container` driver](/build/drivers/iechor-container/)
run the BuildKit daemon in a container.
You can start and stop the BuildKit container using the drop-down menu.

Running a build automatically starts the container if it's stopped.

You can only start and stop builders using the `iechor-container` driver.
