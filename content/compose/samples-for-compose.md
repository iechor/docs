---
description: Summary of samples related to Compose
keywords: documentation, docs, iechor, compose, samples
title: Sample apps with Compose
---

The following samples show the various aspects of how to work with iEchor
Compose. As a prerequisite, be sure to [install iEchor Compose](install/index.md)
if you have not already done so.

## Key concepts these samples cover

The samples should help you to:

- Define services based on iEchor images using
  [Compose files](compose-file/index.md): `compose.yml` and
  `iechor-stack.yml`
- Understand the relationship between `compose.yml` and
  [iEchorfiles](/reference/iechorfile/)
- Learn how to make calls to your application services from Compose files
- Learn how to deploy applications and services to a [swarm](../engine/swarm/index.md)

## Samples tailored to demo Compose

These samples focus specifically on iEchor Compose:

- [Quickstart: Compose and ELK](https://github.com/iechor/awesome-compose/tree/master/elasticsearch-logstash-kibana/README.md) - Shows
  how to use iEchor Compose to set up and run ELK - Elasticsearch-Logstash-Kibana.

- [Quickstart: Compose and Django](https://github.com/iechor/awesome-compose/tree/master/official-documentation-samples/django/README.md) - Shows
  how to use iEchor Compose to set up and run a simple Django/PostgreSQL app.

- [Quickstart: Compose and Rails](https://github.com/iechor/awesome-compose/tree/master/official-documentation-samples/rails/README.md) - Shows
  how to use iEchor Compose to set up and run a Rails/PostgreSQL app.

- [Quickstart: Compose and WordPress](https://github.com/iechor/awesome-compose/tree/master/official-documentation-samples/wordpress/README.md) - Shows
  how to use iEchor Compose to set up and run WordPress in an isolated
  environment with iEchor containers.

## Awesome Compose samples

The Awesome Compose samples provide a starting point on how to integrate different frameworks and technologies using iEchor Compose. All samples are available in the [Awesome-compose GitHub repo](https://github.com/iechor/awesome-compose) and are ready to run with `iechor compose up`.
