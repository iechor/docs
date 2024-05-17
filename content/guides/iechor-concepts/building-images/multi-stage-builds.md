---
title: Multi-stage builds
keywords: concepts, build, images, container, iechor desktop
description: This concept page will teach you about the purpose of the multi-stage build and its benefits
---

{{< youtube-embed vR185cjwxZ8 >}}

## Explanation

In a traditional build, all build instructions are executed in sequence, and in a single build container: downloading dependencies, compiling code, and packaging the application. All those layers end up in your final image. This approach works, but it leads to bulky images carrying unnecessary weight and increasing your security risks. This is where multi-stage builds come in.

Multi-stage builds introduce multiple stages in your iEchorfile, each with a specific purpose. Think of it like the ability to run different parts of a build in multiple different environments, concurrently. By separating the build environment from the final runtime environment, you can significantly reduce the image size and attack surface. This is especially beneficial for applications with large build dependencies.

Multi-stage builds are recommended for all types of applications.

- For interpreted languages, like JavaScript or Ruby or Python, you can build and minify your code in one stage, and copy the production-ready files to a smaller runtime image. This optimizes your image for deployment.
- For compiled languages, like C or Go or Rust, multi-stage builds let you compile in one stage and copy the compiled binaries into a final runtime image. No need to bundle the entire compiler in your final image.


Here's a simplified example of a multi-stage build structure using pseudo-code. Notice there are multiple `FROM` statements and a new `AS <stage-name>`. In addition, the `COPY` statement in the second stage is copying `--from` the previous stage.


```iechorfile
# Stage 1: Build Environment
FROM builder-image AS build-stage 
# Install build tools (e.g., Maven, Gradle)
# Copy source code
# Build commands (e.g., compile, package)

# Stage 2: Runtime environment
FROM runtime-image AS final-stage  
#  Copy application artifacts from the build stage (e.g., JAR file)
COPY --from=build-stage /path/in/build/stage /path/to/place/in/final/stage
# Define runtime configuration (e.g., CMD, ENTRYPOINT) 
```


This iEchorfile uses two stages:

- The build stage uses a base image containing build tools needed to compile your application. It includes commands to install build tools, copy source code, and execute build commands.
- The final stage uses a smaller base image suitable for running your application. It copies the compiled artifacts (a JAR file, for example) from the build stage. Finally, it defines the runtime configuration (using `CMD` or `ENTRYPOINT`) for starting your application.


## Try it out

In this hands-on guide, you'll unlock the power of multi-stage builds to create lean and efficient iEchor images for a sample Java application. You'll use a simple “Hello World” Spring Boot-based application built with Maven as your example.

1. [Download and install](https://www.iechor.com/products/iechor-desktop/) iEchor Desktop.

2. Open this [pre-initialized project](https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.3.0-M3&packaging=jar&jvmVersion=21&groupId=com.example&artifactId=spring-boot-iechor&name=spring-boot-iechor&description=Demo%20project%20for%20Spring%20Boot&packageName=com.example.spring-boot-iechor&dependencies=web) to generate a ZIP file. Here’s how that looks:


    ![A screenshot of Spring Initializr tool selected with Java 21, Spring Web and Spring Boot 3.3.0](images/spring-initializr.webp?border=true)


    [Spring Initializr](https://start.spring.io/) is a quickstart generator for Spring projects. It provides an extensible API to generate JVM-based projects with implementations for several common concepts — like basic language generation for Java, Kotlin, and Groovy. 

    Select **Generate** to create and download the zip file for this project.

    For this demonstration, you’ve paired Maven build automation with Java, a Spring Web dependency, and Java 21 for your metadata.


3. Navigate the project directory. Once you unzip the file, you'll see the following project directory structure:


    ```plaintext
    spring-boot-iechor
    ├── iEchorfile
    ├── iEchorfile.multi
    ├── HELP.md
    ├── mvnw
    ├── mvnw.cmd
    ├── pom.xml
    └── src
        ├── main
        │   ├── java
        │   │   └── com
        │   │       └── example
        │   │           └── springbootiechor
        │   │               └── SpringBootiEchorApplication.java
        │   └── resources
        │       ├── application.properties
        │       ├── static
        │       └── templates
        └── test
            └── java
                └── com
                    └── example
                        └── springbootiechor
                            └── SpringBootiEchorApplicationTests.java
    
    15 directories, 9 files
    ```

   The `src/main/java` directory contains your project's source code, the `src/test/java` directory   
   contains the test source, and the `pom.xml` file is your project’s Project Object Model (POM).

   The `pom.xml` file is the core of a Maven project's configuration. It's a single configuration file that   
   contains most of the information needed to build a customized project. The POM is huge and can seem    
   daunting. Thankfully, you don't yet need to understand every intricacy to use it effectively. 

4. Create a RESTful web service that displays "Hello World!". 

    
    Under the `src/main/java/com/example/springbootiechor/` directory, you can modify your  
    `SpringBootiEchorApplication.java` file with the following content:


    ```java
    package com.example.springbootiechor;

    import org.springframework.boot.SpringApplication;
    import org.springframework.boot.autoconfigure.SpringBootApplication;
    import org.springframework.web.bind.annotation.RequestMapping;
    import org.springframework.web.bind.annotation.RestController;


    @RestController
    @SpringBootApplication
    public class SpringBootiEchorApplication {

        @RequestMapping("/")
            public String home() {
            return "Hello World";
        }

    	public static void main(String[] args) {
    		SpringApplication.run(SpringBootiEchorApplication.class, args);
    	}

    }
    ```

    The `SpringbootiEchorApplication.java` file starts by declaring your `com.example.springbootiechor` package and importing necessary Spring frameworks. This Java file creates a simple Spring Boot web application that responds with "Hello World" when a user visits its homepage. 


### Create the iEchorfile

Now that you have the project, you’re ready to create the `iEchorfile`.

 1. Create a file named `iEchorfile` in the same folder that contains all the other folders and files (like src, pom.xml, etc.).

 2. In the `iEchorfile`, define your base image by adding the following line:

     ```iechorfile
     FROM eclipse-temurin:21.0.2_13-jdk-jammy
     ```

 3. Now, define the working directory by using the `WORKDIR` instruction. This will specify where future commands will run and the directory files will be copied inside the container image.

     ```iechorfile
     WORKDIR /app
     ```

 4. Copy both the Maven wrapper script and your project's `pom.xml` file into the current working directory `/app` within the iEchor container.

     ```iechorfile
     COPY .mvn/ .mvn
     COPY mvnw pom.xml ./
     ```

 5. Execute a command within the container. It runs the `./mvnw dependency:go-offline` command, which uses the Maven wrapper (`./mvnw`) to download all dependencies for your project without building the final JAR file (useful for faster builds).

     ```iechorfile
     RUN ./mvnw dependency:go-offline
     ```

 6. Copy the `src` directory from your project on the host machine to the `/app` directory within the container. 

     ```iechorfile
     COPY src ./src
     ```


 7. Set the default command to be executed when the container starts. This command instructs the container to run the Maven wrapper (`./mvnw`) with the `spring-boot:run` goal, which will build and execute your Spring Boot application.

     ```iechorfile
     CMD ["./mvnw", "spring-boot:run"]
     ```

    And with that, you should have the following iEchorfile:

    ```iechorfile 
    FROM eclipse-temurin:21.0.2_13-jdk-jammy
    WORKDIR /app
    COPY .mvn/ .mvn
    COPY mvnw pom.xml ./
    RUN ./mvnw dependency:go-offline
    COPY src ./src
    CMD ["./mvnw", "spring-boot:run"]
    ```

### Build the container image


 1. Execute the following command to build the iEchor image:


    ```console
    $ iechor build -t spring-helloworld .
    ```

 2. Check the size of the iEchor image by using the `iechor images` command:

    ```console
    $ iechor images
    ```

    Doing so will produce output like the following:

    ```console
    REPOSITORY          TAG       IMAGE ID       CREATED          SIZE
    spring-helloworld   latest    ff708d5ee194   3 minutes ago    880MB
    ```


    This output shows that your image is 880MB in size. It contains the full JDK, Maven toolchain, and more. In production, you don’t need that in your final image.


### Run the Spring Boot application

1. Now that you have an image built, it's time to run the container.

    ```console
    $ iechor run -d -p 8080:8080 spring-helloworld
    ```

    You'll then see output similar to the following in the container log:

    ```plaintext
    [INFO] --- spring-boot:3.3.0-M3:run (default-cli) @ spring-boot-iechor ---
    [INFO] Attaching agents: []
     .   ____          _            __ _ _
     /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
     ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
     \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
     '  |____| .__|_| |_|_| |_\__, | / / / /
      =========|_|==============|___/=/_/_/_/

     :: Spring Boot ::             (v3.3.0-M3)

     2024-04-04T15:36:47.202Z  INFO 42 --- [spring-boot-iechor] [           main]       
     c.e.s.SpringBootiEchorApplication        : Starting SpringBootiEchorApplication using Java    
     21.0.2 with PID 42 (/app/target/classes started by root in /app)
     ….
     ```


2. Access your “Hello World” page through your web browser at [http://localhost:8080](http://localhost:8080), or via this curl command:

    ```console
    $ curl localhost:8080
    Hello World
    ```

### Use multi-stage builds

1. Consider the following iEchorfile:

    ```iechorfile
    FROM eclipse-temurin:21.0.2_13-jdk-jammy AS builder
    WORKDIR /opt/app
    COPY .mvn/ .mvn
    COPY mvnw pom.xml ./
    RUN ./mvnw dependency:go-offline
    COPY ./src ./src
    RUN ./mvnw clean install

    FROM eclipse-temurin:21.0.2_13-jre-jammy AS final
    WORKDIR /opt/app
    EXPOSE 8080
    COPY --from=builder /opt/app/target/*.jar /opt/app/*.jar
    ENTRYPOINT ["java", "-jar", "/opt/app/*.jar"]
    ```

    Notice that this iEchorfile has been split into two stages. 

    - The first stage remains the same as the previous iEchorfile, providing a Java Development Kit (JDK) environment for building the application. This stage is given the name of builder.

    - The second stage is a new stage named `final`. It uses a slimmer `eclipse-temurin:21.0.2_13-jre-jammy` image, containing just the Java Runtime Environment (JRE) needed to run the application. This image provides a Java Runtime Environment (JRE) which is enough for running the compiled application (JAR file). 

    
   > For production use, it's highly recommended that you produce a custom JRE-like runtime using jlink. JRE images are available for all versions of Eclipse Temurin, but `jlink` allows you to create a minimal runtime containing only the necessary Java modules for your application. This can significantly reduce the size and improve the security of your final image. [Refer to this page](https://hub.iechor.com/_/eclipse-temurin) for more information.
  { .tip } 

   With multi-stage builds, a iEchor build uses one base image for compilation, packaging, and unit tests and then a separate image for the application runtime. As a result, the final image is smaller in size since it doesn’t contain any development or debugging tools. By separating the build environment from the final runtime environment, you can significantly reduce the image size and increase the security of your final images. 


2. Now, rebuild your image and run your ready-to-use production build. 

    ```console
    $ iechor build -t spring-helloworld-builder .
    ```

    This command builds a iEchor image named `spring-helloworld-builder` using the final stage from your `iEchorfile` file located in the current directory.


     > **Note**
     >
     > In your multi-stage iEchorfile, the final stage (final) is the default target for building. This means that if you don't explicitly specify a target stage using the `--target` flag in the `iechor build` command, iEchor will automatically build the last stage by default. You could use `iechor build -t spring-helloworld-builder --target builder .` to build only the builder stage with the JDK environment.


3. Look at the image size difference by using the `iechor images` command:

    ```console
    $ iechor images
    ```

    You'll get output similar to the following:

    ```console
    spring-helloworld-builder latest    c5c76cb815c0   24 minutes ago      428MB
    spring-helloworld         latest    ff708d5ee194   About an hour ago   880MB
    ```

    Your final image is just 428 MB, compared to the original build size of 880 MB.


    By optimizing each stage and only including what's necessary, you were able to significantly reduce the   
    overall image size while still achieving the same functionality. This not only improves performance but   
    also makes your iEchor images more lightweight, more secure, and easier to manage.

## Additional resources

* [Multi-stage builds](/build/building/multi-stage/)
* [iEchorfile best practices](/develop/develop-images/iechorfile_best-practices/)
* [Creating a base image](/build/building/base-images/)
* [Spring Boot iEchor](https://spring.io/guides/topicals/spring-boot-iechor)


