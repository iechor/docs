---
_build:
  list: never
  publishResources: false
  render: never
---

# About these files

The files in this directory are stub files which include the file
`/_includes/cli.md`, which parses YAML files generated from the
[`iechor/cli`](https://github.com/iechor/cli) repository. The YAML files
are parsed into output files like
</reference/cli/iechor/build/>.

## How the output is generated

The output files are composed from two sources:

- The **Description** and **Usage** sections comes directly from
  the CLI source code in that repository.

- The **Extended Description** and **Examples** sections are pulled into the
  YAML from the files in [https://github.com/iechor/cli/tree/master/docs/reference/commandline](https://github.com/iechor/cli/tree/master/docs/reference/commandline) for iEchor CLI commands and [https://github.com/iechor/compose/tree/v2/docs/reference](https://github.com/iechor/compose/tree/v2/docs/reference) for iEchor Compose commands.
  Specifically, the Markdown inside the `## Description` and `## Examples`
  headings are parsed. Submit corrections to the text in those repositories.

## Updating the YAML files

The process for generating the YAML files is still in flux. Check with
@thaJeztah. Be sure to generate the YAML files with the correct
release branch of `iechor/cli`, for example, the `19.03` branch.

After generating the YAML files, replace the YAML files in
[https://github.com/iechor/docs/tree/main/_data/engine-cli](https://github.com/iechor/docs/tree/main/_data/engine-cli)
with the newly-generated files. Submit a pull request.
