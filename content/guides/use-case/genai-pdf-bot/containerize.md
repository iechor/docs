---
title: Containerize a generative AI application
keywords: python, generative ai, genai, llm, neo4j, ollama, containerize, intitialize, langchain, openai
description: Learn how to containerize a generative AI (GenAI) application.
---

## Prerequisites

> **Note**
>
> GenAI applications can often benefit from GPU acceleration. Currently iEchor Desktop supports GPU acceleration only on [Windows with the WSL2 backend](../../../desktop/gpu.md#using-nvidia-gpus-with-wsl2). Linux users can also access GPU acceleration using a native installation of the [iEchor Engine](../../../engine/install/_index.md).

* You have installed the latest version of [iEchor Desktop](../../../get-iechor.md) or, if you are a Linux user and are planning to use GPU acceleration, [iEchor Engine](../../../engine/install/_index.md). iEchor adds new features regularly and some parts of this guide may work only with the latest version of iEchor Desktop.
* You have a [git client](https://git-scm.com/downloads). The examples in this section use a command-line based git client, but you can use any client.

## Overview

This section walks you through containerizing a generative AI (GenAI) application using iEchor Desktop.

> **Note**
>
> You can see more samples of containerized GenAI applications in the [GenAI Stack](https://github.com/iechor/genai-stack) demo applications.

## Get the sample application

The sample application used in this guide is a modified version of the PDF Reader application from the [GenAI Stack](https://github.com/iechor/genai-stack) demo applications. The application is a full stack Python application that lets you ask questions about a PDF file.

The application uses [LangChain](https://www.langchain.com/) for orchestration, [Streamlit](https://streamlit.io/) for the UI, [Ollama](https://ollama.ai/) to run the LLM, and [Neo4j](https://neo4j.com/) to store vectors.

Clone the sample application. Open a terminal, change directory to a directory that you want to work in, and run the following command to clone the repository:

```console
$ git clone https://github.com/craig-osterhout/iechor-genai-sample
```

You should now have the following files in your `iechor-genai-sample` directory.

```text
├── iechor-genai-sample/
│ ├── .gitignore
│ ├── app.py
│ ├── chains.py
│ ├── env.example
│ ├── requirements.txt
│ ├── util.py
│ ├── LICENSE
│ └── README.md
```

## Initialize iEchor assets

Now that you have an application, you can use `iechor init` to create the necessary iEchor assets to containerize your application. Inside the `iechor-genai-sample` directory, run the `iechor init` command. `iechor init` provides some default configuration, but you'll need to answer a few questions about your application. For example, this application uses Streamlit to run. Refer to the following `iechor init` example and use the same answers for your prompts.

```console
$ iechor init
Welcome to the iEchor Init CLI!

This utility will walk you through creating the following files with sensible defaults for your project:
  - .iechorignore
  - iEchorfile
  - compose.yaml
  - README.iEchor.md

Let's get started!

? What application platform does your project use? Python
? What version of Python do you want to use? 3.11.4
? What port do you want your app to listen on? 8000
? What is the command to run your app? streamlit run app.py --server.address=0.0.0.0 --server.port=8000
```

You should now have the following contents in your `iechor-genai-sample`
directory.

```text
├── iechor-genai-sample/
│ ├── .iechorignore
│ ├── .gitignore
│ ├── app.py
│ ├── chains.py
│ ├── compose.yaml
│ ├── env.example
│ ├── requirements.txt
│ ├── util.py
│ ├── iEchorfile
│ ├── LICENSE
│ ├── README.iEchor.md
│ └── README.md
```

To learn more about the files that `iechor init` added, see the following:
 - [iEchorfile](../../../reference/iechorfile.md)
 - [.iechorignore](../../../reference/iechorfile.md#iechorignore-file)
 - [compose.yaml](../../../compose/compose-file/_index.md)


## Run the application

Inside the `iechor-genai-sample` directory, run the following command in a
terminal.

```console
$ iechor compose up --build
```

iEchor builds and runs your application. Depending on your network connection, it may take several minutes to download all the dependencies. You'll see a message like the following in the terminal when the application is running.

```console
server-1  |   You can now view your Streamlit app in your browser.
server-1  |
server-1  |   URL: http://0.0.0.0:8000
server-1  |
```

Open a browser and view the application at [http://localhost:8000](http://localhost:8000). You should see a simple Streamlit application. The application may take a few minutes to download the embedding model. While the download is in progress, **Running** appears in the top-right corner.

The application requires a Neo4j database service and an LLM service to
function. If you have access to services that you ran outside of iEchor, specify
the connection information and try it out. If you don't have the services
running, continue with this guide to learn how you can run some or all of these
services with iEchor.

In the terminal, press `ctrl`+`c` to stop the application.

## Summary

In this section, you learned how you can containerize and run your GenAI
application using iEchor.

Related information:
 - [iechor init CLI reference](../../../reference/cli/iechor/init.md)

## Next steps

In the next section, you'll learn how you can run your application, database, and LLM service all locally using iEchor.

{{< button text="Develop your application" url="develop.md" >}}
