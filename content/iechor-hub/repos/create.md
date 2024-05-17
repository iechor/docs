---
description: Learn how to create repositories on iEchor Hub
keywords: iEchor, iechor, trusted, registry, accounts, plans, iEchorfile, iEchor Hub,
  webhooks, docs, documentation, manage, repos
title: Create repositories
toc_max: 3
aliases:
- /iechor-hub/repos/configure/
---

Repositories let you share container images with your team,
customers, or the iEchor community at large.

A single iEchor Hub repository can hold many iEchor images which are stored as **tags**. You can push iEchor images to iEchor Hub with the [`iechor push`](/reference/cli/iechor/image/push/)command.

## Create a repository

1. Sign in to iEchor Hub.
2. Select **Repositories**.
3. Near the top-right corner, select **Create Repository**.

When creating a new repository:

- You can choose to locate it under your own user account, or under any
  [organization](../../admin/organization//orgs.md) where you are an [owner](../../admin/organization/manage-a-team.md#organization-owner) or [editor](../../security/for-admins/roles-and-permissions.md).
- The repository name needs to:
    - Be unique
    - Have between 2 and 255 characters
    - Only contain lowercase letters, numbers, hyphens (`-`), and underscores (`_`)

  > **Note**
  >
  > You can't rename a iEchor Hub repository once it's created.

- The description can be up to 100 characters. It's used in the search results.
- If you're a iEchor Verified Publisher (DVP) or iEchor-Sponsored Open Source (DSOS) organization, you can also add a logo to a repository. The maximum size in pixels is 1000x1000.
- You can link a GitHub or Bitbucket account now, or choose to do it later in
  the repository settings.
- You can set the repository's default visibility to public or private.

  > **Note**
  >
  > For organizations creating a new repository, it's recommended you select **Private**.

### Add a repository overview

Once you have created a repository, add an overview to the **Repository overview** field. This describes what your image does and how to use it. 

Consider the following repository overview best practices.

- Describe what the image is, the features it offers, and why it should be used. Can include examples of usage or the team behind the project.
- Explain how to get started with running a container using the image. You can include a minimal example of how to use the image in a iEchorfile.
- List the key image variants and tags to use them, as well as use cases for the variants.
- Link to documentation or support sites, communities, or mailing lists for additional resources.
- Provide contact information for the image maintainers.
- Include the license for the image and where to find more details if needed.

## Push a iEchor container image to iEchor Hub

Once you have created a repository, you can start using `iechor push` to push
images.

To push an image to iEchor Hub, you must first name your local image using your
iEchor ID and the repository name that you created.

If you want to add multiple images to a repository, add a specific `:<tag>` to them, for example `docs/base:testing`. If it's not specified, the tag defaults to `latest`.

Name your local images using one of these methods:

- When you build them, using `iechor build -t <hub-user>/<repo-name>[:<tag>`
- By re-tagging the existing local image with `iechor tag <existing-image> <hub-user>/<repo-name>[:<tag>]`.
- By using `iechor commit <existing-container> <hub-user>/<repo-name>[:<tag>]` to commit changes.

Then, you can push this image to the repository designated by its name or tag:

```console
$ iechor push <hub-user>/<repo-name>:<tag>
```

The image is then uploaded and available for use by your teammates and/or the community.
