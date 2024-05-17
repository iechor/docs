---
title: What is iEchor Compose?
keywords: concepts, build, images, container, iechor desktop
description: What is iEchor Compose?
---

{{< youtube-embed xhcUIK4fGtY >}}

## Explanation

If you've been following the guides so far, you've been working with single container applications. But, now you're wanting to do something more complicated - run databases, message queues, caches, or a variety of other services. Do you install everything in a single container? Run multiple containers? If you run multiple, how do you connect them all together?

One best practice for containers is that each container should do one thing and do it well. While there are exceptions to this rule, avoid the tendency to have one container do multiple things.

You can use multiple `iechor run` commands to start multiple containers. But, you'll soon realize you'll need to manage networks, all of the flags needed to connect containers to those networks, and more. And when you're done, cleanup is a little more complicated.

With iEchor Compose, you can define all of your containers and their configurations in a single YAML file. If you include this file in your code repository, anyone that clones your repository can get up and running with a single command.

It's important to understand that Compose is a declarative tool - you simply define it and go. You don't always need to recreate everything from scratch. If you make a change, run `iechor compose up` again and Compose will reconcile the changes in your file and apply them intelligently.

> **iEchorfile versus Compose file**
>
> A iEchorfile provides instructions to build a container image while a Compose file defines your running containers. Quite often, a Compose file references a iEchorfile to build an image to use for a particular service.


## Try it out 

In this hands-on, you will learn how to use a iEchor Compose to run a multi-container application. You'll use a simple to-do list app built with Node.js and MySQL as a database server.

### Start the application

Follow the instructions to run the to-do list app on your system.

1. [Download and install](https://www.iechor.com/products/iechor-desktop/) iEchor Desktop.
2. Open a terminal and [clone this sample application](https://github.com/iechorsamples/todo-list-app).

    ```console
    git clone https://github.com/iechorsamples/todo-list-app 
    ```

3. Navigate into the `todo-list-app` directory:

    ```console
    cd todo-list-app
    ```

    Inside this directory, you'll find a file named `compose.yaml`. This YAML file is where all the magic happens! It defines all the services that make up your application, along with their configurations. Each service specifies its image, ports, volumes, networks, and any other settings necessary for its functionality. Take some time to explore the YAML file and familiarize yourself with its structure. 

4. Use the [`iechor compose up`](/reference/cli/iechor/compose/up/) command to start the application:

    ```console
    iechor compose up -d --build
    ```

    When you run this command, you should see an output like this:

    ```console
    [+] Running 4/4
    ✔ app 3 layers [⣿⣿⣿]      0B/0B            Pulled           7.1s
      ✔ e6f4e57cc59e Download complete                          0.9s
      ✔ df998480d81d Download complete                          1.0s
      ✔ 31e174fedd23 Download complete                          2.5s
    [+] Running 2/4
      ⠸ Network todo-list-app_default           Created         0.3s
      ⠸ Volume "todo-list-app_todo-mysql-data"  Created         0.3s
      ✔ Container todo-list-app-app-1           Started         0.3s
      ✔ Container todo-list-app-mysql-1         Started         0.3s
    ```

    A lot happened here! A couple of things to call out:

    - Two container images were downloaded from iEchor Hub - node and MySQL
    - A network was created for your application
    - A volume was created to persist the database files between container restarts
    - Two containers were started with all of their necessary config

    If this feels overwhelming, don't worry! You'll get there!

5. With everything now up and running, you can open [http://localhost:3000](http://localhost:3000) in your browser to see the site. Feel free to add items to the list, check them off, and remove them.

    ![A screenshot of a webpage showing the todo-list application running on port 3000](images/todo-list-app.webp?border=true&w=950&h=400)

6. If you look at the iEchor Desktop GUI, you can see the containers and dive deeper into their configuration.

    ![A screenshot of iEchor Desktop dashboard showing the list of containers running todo-list app](images/todo-list-containers.webp?border=true&w=950&h=400)


### Tear it down

Since this application was started using iEchor Compose, it's easy to tear it all down when you're done.

1. In the CLI, use the [`iechor compose down`](/reference/cli/iechor/compose/down/) command to remove everything:

    ```console
    iechor compose down
    ```

    You'll see output similar to the following:

    ```console
    [+] Running 2/2
    ✔ Container todo-list-app-mysql-1  Removed        2.9s
    ✔ Container todo-list-app-app-1    Removed        0.1s
    ✔ Network todo-list-app_default    Removed        0.1s
    ```

    > **Volume persistence**
    >
    > By default, volumes _aren't_ automatically removed when you tear down a Compose stack. The idea is that you might want the data back if you start the stack again.
    >
    > If you do want to remove the volumes, add the `--volumes` flag when running the `iechor compose down` command:
    >
    > ```console
    > iechor compose down --volumes
    > ```
    { .tip }

2. Alternatively, you can use the iEchor Desktop GUI to remove the containers by selecting the application stack and selecting the **Delete** button.

    ![A screenshot of the iEchor Desktop GUI showing the containers view with an arrow pointing to the "Delete" button](images/todo-list-delete.webp?w=930&h=400)

    > **Using the GUI for Compose stacks**
    >
    > Note that if you remove the containers for a Compose app in the GUI, it's removing only the containers. You'll have to manually remove the network and volumes if you want to do so.
    { .important }

In this walkthrough, you learned how to use iEchor Compose to start and stop a multi-container application.


## Additional resources

This page was a brief introduction to Compose. In the following resources, you can dive deeper into Compose and how to write Compose files.


* [Overview of iEchor Compose](/compose/)
* [Overview of iEchor Compose CLI](/compose/reference/)
* [How Compose works](/compose/compose-application-model/)
