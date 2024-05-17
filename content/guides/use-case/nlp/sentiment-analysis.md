---
title: Build a sentiment analysis app
keywords: nlp, natural language processing, sentiment analysis, python, nltk
description: Learn how to build and run a sentiment analysis application using Python, NLTK, and iEchor.
---

## Overview

In this guide, you learn how to build and run a sentiment analysis application.
You'll build the application using Python with the Natural Language Toolkit
(NLTK), and then set up the environment and run the application using iEchor.

The application analyzes user input text for sentiment using NLTK's
SentimentIntensityAnalyzer and outputs whether the sentiment is positive,
negative, or neutral.

## Prerequisites

* You have installed the latest version of [iEchor Desktop](../../../get-iechor.md). iEchor adds new features regularly and some parts of this guide may work only with the latest version of iEchor Desktop.
* You have a [Git client](https://git-scm.com/downloads). The examples in this section use a command-line based Git client, but you can use any client.

## Get the sample application

1. Open a terminal, and clone the sample application's repository using the
   following command.

   ```console
   $ git clone https://github.com/harsh4870/iEchor-NLP.git
   ```

2. Verify that you cloned the repository.

   You should see the following files in your `iEchor-NLP` directory.

   ```text
   01_sentiment_analysis.py
   02_name_entity_recognition.py
   03_text_classification.py
   04_text_summarization.py
   05_language_translation.py
   entrypoint.sh
   requirements.txt
   iEchorfile
   README.md
   ```

## Explore the application code

The source code for the sentiment analysis application is in the `iEchor-NLP/01_sentiment_analysis.py` file. Open `01_sentiment_analysis.py` in a text or code editor to explore its contents in the following steps.

1. Import the required libraries.

   ```python
   import nltk
   from nltk.sentiment import SentimentIntensityAnalyzer
   import ssl
   ```
   
   - `nltk`: This is the Natural Language Toolkit library used for working with
     human language data in Python.
   - `SentimentIntensityAnalyzer`: This is a specific tool from NLTK used for
     determining the sentiment of a piece of text.
   - `ssl`: This module provides access to Transport Layer Security (encryption)
     functions used for secure web connections.

2. Handle SSL certificate verification.

   ```python
   try:
       _create_unverified_https_context = ssl._create_unverified_context
   except AttributeError:
       pass
   else:
       ssl._create_default_https_context = _create_unverified_https_context
   ```
   
   This block is a workaround for certain environments where downloading data through NLTK might fail due to SSL certificate verification issues. It's telling Python to ignore SSL certificate verification for HTTPS requests.

3. Download NLTK resources.

   ```python
   nltk.download('vader_lexicon')
   nltk.download('punkt')
   ```
   
   - `vader_lexicon`: This is a lexicon used by the `SentimentIntensityAnalyzer`
     for sentiment analysis.
   - `punkt`: This is used by NLTK for tokenizing sentences. It's necessary for
     the `SentimentIntensityAnalyzer` to function correctly.

4. Create a sentiment analysis function.

   ```python
   def perform_semantic_analysis(text):
       sid = SentimentIntensityAnalyzer()
       sentiment_score = sid.polarity_scores(text)

       if sentiment_score['compound'] >= 0.05:
           return "Positive"
       elif sentiment_score['compound'] <= -0.05:
           return "Negative"
       else:
           return "Neutral"
   ```

   - `SentimentIntensityAnalyzer()` creates an instance of the
     analyzer.
   - `polarity_scores(text)` generates a sentiment score for the input text.

   The function returns **Positive**, **Negative**, or **Neutral** based on the
   compound score.

5. Create the main loop.

   ```python
   if __name__ == "__main__":
       while True:
           input_text = input("Enter the text for semantic analysis (type 'exit' to end): ")

           if input_text.lower() == 'exit':
               print("Exiting...")
               break

           result = perform_semantic_analysis(input_text)
           print(f"Sentiment: {result}")
   ```

   This part of the script runs an infinite loop to accept user input for
   analysis. If the user types `exit`, the program terminates. Otherwise, it
   prints out the sentiment of the provided text.

6. Create `requirements.txt`.

   The sample application already contains the
   `requirements.txt` file to specify the necessary packages that the
   application imports. Open `requirements.txt` in a code or text editor to
   explore its contents.

   ```text
   # 01 sentiment_analysis
   nltk==3.6.5

   ...
   ```

   Only the `nltk` package is required for the sentiment analysis application.

## Explore the application environment

You'll use iEchor to run the application in a container. iEchor lets you
containerize the application, providing a consistent and isolated environment
for running it. This means the application will operate as intended within its
iEchor container, regardless of the underlying system differences.

To run the application in a container, a iEchorfile is required. A iEchorfile is
a text document that contains all the commands you would call on the command
line to assemble an image. An image is a read-only template with instructions
for creating a iEchor container.

The sample application already contains a `iEchorfile`. Open the `iEchorfile` in a code or text editor to explore its contents.

The following steps explain each part of the `iEchorfile`. For more details, see the [iEchorfile reference](/reference/iechorfile/).

1. Specify the base image.

   ```iechorfile
   FROM python:3.8-slim
   ```

   This command sets the foundation for the build. `python:3.8-slim` is a
   lightweight version of the Python 3.8 image, optimized for size and speed.
   Using this slim image reduces the overall size of your iEchor image, leading
   to quicker downloads and less surface area for security vulnerabilities. This
   is particularly useful for a Python-based application where you might not
   need the full standard Python image.

2. Set the working directory.

   ```iechorfile
   WORKDIR /app
   ```

   `WORKDIR` sets the current working directory within the iEchor image. By
   setting it to `/app`, you ensure that all subsequent commands in the
   iEchorfile (like `COPY` and `RUN`) are executed in this directory. This also
   helps in organizing your iEchor image, as all application-related files are
   contained in a specific directory.

3. Copy the requirements file into the image.

   ```iechorfile
   COPY requirements.txt /app
   ```

   The `COPY` command transfers the `requirements.txt` file from
   your local machine into the iEchor image. This file lists all Python
   dependencies required by the application. Copying it into the container
   lets the next command (`RUN pip install`) install these dependencies
   inside the image environment.

4. Install the Python dependencies in the image.

   ```iechorfile
   RUN pip install --no-cache-dir -r requirements.txt
   ```

   This line uses `pip`, Python's package installer, to install the packages
   listed in `requirements.txt`. The `--no-cache-dir` option disables
   the cache, which reduces the size of the iEchor image by not storing the
   unnecessary cache data.

5. Run additional commands.

   ```iechorfile
   RUN python -m spacy download en_core_web_sm
   ```

   This step is specific to NLP applications that require the spaCy library. It downloads the `en_core_web_sm` model, which is a small English language model for spaCy. While not needed for this app, it's included for compatibility with other NLP applications that might use this iEchorfile.

6. Copy the application code into the image.

   ```iechorfile
   COPY *.py /app
   COPY entrypoint.sh /app
   ```

   These commands copy your Python scripts and the `entrypoint.sh` script into
   the image's `/app` directory. This is crucial because the container needs
   these scripts to run the application. The `entrypoint.sh` script is
   particularly important as it dictates how the application starts inside the
   container.

7. Set permissions for the `entrypoint.sh` script.

   ```iechorfile
   RUN chmod +x /app/entrypoint.sh
   ```

   This command modifies the file permissions of `entrypoint.sh`, making it
   executable. This step is necessary to ensure that the iEchor container can
   run this script to start the application.

8. Set the entry point.

   ```iechorfile
   ENTRYPOINT ["/app/entrypoint.sh"]
   ```

    The `ENTRYPOINT` instruction configures the container to run `entrypoint.sh`
    as its default executable. This means that when the container starts, it
    automatically executes the script.
   
   You can explore the `entrypoint.sh` script by opening it in a code or text
   editor. As the sample contains several applications, the script lets you
   specify which application to run when the container starts.

## Run the application

To run the application using iEchor:

1. Build the image.

   In a terminal, run the following command inside the directory of where the `iEchorfile` is located.

   ```console
   $ iechor build -t basic-nlp .
   ```

   The following is a break down of the command:

   - `iechor build`: This is the primary command used to build a iEchor image
     from a iEchorfile and a context. The context is typically a set of files at
     a specified location, often the directory containing the iEchorfile.
   - `-t basic-nlp`: This is an option for tagging the image. The `-t` flag
     stands for tag. It assigns a name to the image, which in this case is
     `basic-nlp`. Tags are a convenient way to reference images later,
     especially when pushing them to a registry or running containers.
   - `.`: This is the last part of the command and specifies the build context.
     The period (`.`) denotes the current directory. iEchor will look for a
     iEchorfile in this directory. The build context (the current directory, in
     this case) is sent to the iEchor daemon to enable the build. It includes
     all the files and subdirectories in the specified directory.

   iEchor outputs several logs to your console as it builds the image. You'll
   see it download and install the dependencies. Depending on your network
   connection, this may take several minutes. iEchor does have a caching
   feature, so subsequent builds can be faster. The console will
   return to the prompt when it's complete.

   For more details, see the [iechor build CLI reference](/reference/cli/iechor/image/build/).

2. Run the image as a container.

   In a terminal, run the following command.

   ```console
   $ iechor run -it basic-nlp 01_sentiment_analysis.py
   ```

   The following is a break down of the command:

   - `iechor run`: This is the primary command used to run a new container from
     a iEchor image.
   - `-it`: This is a combination of two options:
      - `-i` or `--interactive`: This keeps the standard input (STDIN) open even
        if not attached. It lets the container remain running in the
        foreground and be interactive.
      - `-t` or `--tty`: This allocates a pseudo-TTY, essentially simulating a
        terminal, like a command prompt or a shell. It's what lets you
        interact with the application inside the container.
   - `basic-nlp`: This specifies the name of the iEchor image to use for
     creating the container. In this case, it's the image named `basic-nlp` that
     you created with the `iechor build` command.
   - `01_sentiment_analysis.py`: This is the script you want to run inside the
     iEchor container. It gets passed to the `entrypoint.sh` script, which runs
     it when the container starts.

   For more details, see the [iechor run CLI reference](/reference/cli/iechor/container/run/).


   > **Note**
   >
   > For Windows users, you may get an error when running the container. Verify
   > that the line endings in the `entrypoint.sh` are `LF` (`\n`) and not `CRLF` (`\r\n`),
   > then rebuild the image. For more details, see [Avoid unexpected syntax errors, use Unix style line endings for files in containers](/desktop/troubleshoot/topics/#avoid-unexpected-syntax-errors-use-unix-style-line-endings-for-files-in-containers).

   You will see the following in your console after the container starts.

   ```console
   Enter the text for semantic analysis (type 'exit' to end):
   ```

3. Test the application.

   Enter a comment to get the sentiment analysis.
   
   ```console
   Enter the text for semantic analysis (type 'exit' to end): I love containers!
   Sentiment: Positive
   Enter the text for semantic analysis (type 'exit' to end): I'm still learning about containers.
   Sentiment: Neutral
   ```

## Summary

In this guide, you learned how to build and run a sentiment analysis
application. You learned how to build the application using Python with NLTK,
and then set up the environment and run the application using iEchor.

Related information:

* [iEchor CLI reference](/reference/cli/iechor/)
* [iEchorfile reference](/reference/iechorfile/)
* [Natural Language Toolkit](https://www.nltk.org/)
* [Python documentation](https://docs.python.org/3/)

## Next steps

Explore more [natural language processing guides](./_index.md).
