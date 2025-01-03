# Table of Contents

1. [Launch Backdrop using Docker](#launch-backdrop-using-docker)
2. [About Docker](#about-docker)
3. [About Backdrop](#about-backdrop)

# Launch Backdrop using Docker

> [!TIP]
> You **do not need** to clone this repository in order to launch Backdrop using Docker.

This section explains how to launch Backdrop CMS as a Docker container application.

The process of "spinning up" Backdrop as a Docker container application involves:

 1)  Ensuring Docker is installed on the host machine
 2)  Creating a named directory to hold Docker configuration file(s)
 3)  Creating a new Docker startup file (usually called: a _Docker Compose_ file) referencing a Backdrop Docker Image
 4)  Launching Docker in such a way that it processes the new Docker startup file (using the command `docker compose`)

## Step 1: Ensure Docker is Installed on the Host Machine

[Click here to see Docker's installation instructions for Windows, Mac and Linux](https://www.docker.com/get-started)

The following example checks for the existence of Docker on a Linux host:

```
docker -v
Docker version 27.4.1, build b9d17ea
```

## Step 2: Create a Named Directory to Hold Docker Configuration File(s)

The following example creates a directory named `backdrop-eval` for the purpose of holding Docker configuration file(s) on a Linux host (the folder is created inside of the current directory which could be the home of the logged-in user or another directory within it).

```
mkdir backdrop-eval
cd backdrop-eval
```

## Step 3: Create a New Docker Startup (i.e. _Docker compose_) File Referencing a Backdrop Docker Image

Docker offers a way to launch docker images that need to work together as an application. Such files are called _Docker compose_ files and are usually used when more than one Docker image is needed by the application. In the case of Backdrop, it is not sufficient to run the Backdrop Docker image which contains an Apache PHP application. Additionally, a MySQL database server is also needed. Hence, to "spin up" the Backdrop application (which involves running these two images), a Docker compose file is conveniently used.

This is the `compose.yml` file, which contains all the settings needed to help Docker set up ad run the two containers, in a manner that allows them to interoperate as an application.

The following example `compose.yml` file (located in the named directory created in Step 2) will conveniently _orchestrate_ the launch of the Backdrop and the MySQL Docker images:

```
services:
  backdrop:
    image: backdrop:latest
    container_name: backdrop
    ports:
    - 8080:80
    environment:
      BACKDROP_DB_HOST: mysql
      BACKDROP_DB_USER: backdrop
      BACKDROP_DB_PASSWORD: backdrop

  mysql:
    image: mysql:latest
    container_name: mysql
    environment:
      MYSQL_USER: backdrop
      MYSQL_PASSWORD: backdrop
      MYSQL_DATABASE: backdrop
      MYSQL_ALLOW_EMPTY_PASSWORD: 'yes'
```

> [!NOTE]  
> The Docker compose file above is a bare minimum for testing Backdrop locally. In the case of running Backdrop on a server using Docker, which is often described as "production", the file will likely need to be modified. The modifications involved are beyond the scope of this README file.

## Step 4:  Launch docker in Such a Way That it Processes the New Docker Startup File

While in the `docker-eval` directory, enter the following command:

```
docker compose up
```

This command instructs Docker to process the `compose.yml` startup file located in the same directory.

The screen should immediately begin to fill with startup messages as docker processes the compose file and launches the service Docker images referenced within it. After a minute or so, the pace of new messages should settle down, with just status messages being displayed (which are preceded by `backdrop` or `mysql`, referring to the service from which the status message is being emitted).  At this point, the Backdrop installation screen should be accessible via a web browser.

## Next Steps/Troubleshooting

### How to Access Backdrop in a Local Docker Container

If the web browser is running on **the same machine** as Docker, the Backdrop installation screen should be accessible at http://localhost:8088

### How to Access Backdrop in a Remote Docker Container

If the web browser is running on **a different machine** than the one running docker, Backdrop should be accessible at http://{host-ip}:8088 (where `{host-ip}` is the IP address of the machine running Docker).

### Backdrop Installation - Database Credentials

Don't forget that the Backdrop install process requires the following database credentials to move onward:

```
User:      backdrop
Password:  backdrop
Database:  backdrop
```

### Validating Backdrop-Related Docker Containers

Validating that Docker indeed constructed a valid runtime environment for Backdrop may be accomplished with the following command:

```
docker ps
```

The resulting listing should include two Docker containers:

- One for the MySQL database server that Backdrop requires (mysql)
- One for Backdrop itself (backdrop)

### How to Access the Backdrop host

Accessing the Backdrop host can be accomplished by issuing the following command on the machine running Docker:

```
docker exec -it backdrop bash
```

This will result in creating a shell session _inside_ the container. To confirm this, try to browse the root of the filesystem and notice how it is different from your local root fileysytem:
```
ls /
```

### Trying Out Other Docker Images

The example `compose.yml` above specifically references the `backdrop` Docker image.

This is just in order to get people new to Docker quickly and easily started.  Once someone becomes more familiar with Docker and how it is used to "spin up" the Backdrop application, there is no reason why they wouldn't want to try other Backdrop Docker images on Docker Hub or specific versions of the same image (using the [available tags](https://hub.docker.com/_/backdrop/tags)).

To accomplish that, the only thing that needs be done is change the image specifier in the `backdrop` section of the `compose.yml` file.  The general format to identify a specific Docker image is:

```
services:
  backdrop:
    image: {repository}/{image}:{tag}
```

The image specifier is made up of the following parts:
| Part | Mandatory? | Default Value | Description |
|------|------------|---------------|-------------|
| `{repository}` | No | `docker.io` | is the URL at which a Docker image repository is serving a catalogue/collection of Docker images. When omitted, this defaults to [Docker Hub](https://hub.docker.com/). |
| `{image}` | Yes | - | is the name of the Docker image on the Docker repository. |
| `{tag}` | No | `latest` | is a variation of the image. When omitted, it defaults to "latest" (also called [the default image](#what-is-a-default-docker-image)). |

> [!NOTE]  
> Depending on which parts are stated and which ones are omitted, you can encounter one of a few image specifier forms such as `{repository}/{image}`, `{image}:{tag}`, `{image}`, or `{repository}/{tag}`.

To view all the tags associated with the [official Backdrop image](#what-is-a-backdrop-docker-official-image) on Docker Hub, you can [click here](https://hub.docker.com/_/backdrop/tags).

### Building and Using Your Modified Backdrop Docker Image

Instead of using an image specifier in the `image` field in `compose.yml`. It is possible to point to a local directory containining a [Dockerfile](#what-is-a-dockerfile), as follows:

```
services:
  backdrop:
    image:
      context: ./1/apache
```

In this case, the `docker compose` command would search the current folder (the folder in which the `compose.yml` file resides) for a subfolder named `1`, in which another subfolder `apache` exists, and look for a file called `Dockerfile` there (with a capitalized `D`). Inside of this file, are instructions on how to create a custom image using the [Dockerfile syntax](https://docs.docker.com/reference/dockerfile/).

Example Dockerfiles for building Backdrop Docker images are found in this repository in the following locations:
- [/1/apache/Dockerfile](./1/apache/Dockerfile): is a Dockerfile that can be used to build a Docker image that uses Apache as an underlying server.
- [/1/fpm/Dockerfile](./1/fpm/Dockerfile): is a Dockerfile that can be used to build a Docker image that uses Nginx as an underlying server.

> [!NOTE]  
> Similar versions using either Apache or Nginx also exist on Docker Hub (using the `apache` and `fpm` tags, specifically), so unless the current images on Docker Hub are broken or that you want to modify these images, there won't usually be a need for you to build your own images as explained here.

# About Docker

![logo](https://raw.githubusercontent.com/docker-library/docs/c350af05d3fac7b5c3f6327ac82fe4d990d8729c/docker/logo.png)

## What is Docker?

Docker started off as a way to create "portable" linux applications, ones that can run on any OS as long as it has a Linux kernel.

A good way to start to understand Docker is by learning about `chroot` and how it allowed us to fool the application we are running under Linux into thinking that the current folder holds the entirety of the root filesystem. Docker was born out of the desire to offer complete isolation for the running process from the current OS, not only in storage (as `chroot` accomplished), but also in device/process/user/network spaces. This involved leveraging other features of the Linux kernel similar to `chroot` to achive all of these types of isolation. Today, Docker offers a way to run processes along with their depedencies, all packaged together and while only requiring a Linux kernel.

_Functionally and practically speaking, Docker offers two main services:_ 

- Docker provides a way to **build and run** portable applications.  A Docker image is the portable application's executable and a Docker container is the portable application's running instance. These two concepts are simply referred to as _images_ and _containers_ in Docker.

- Docker provides a way to **orchestrate** the building and running of multiple images/containers in tandem.  This feature has been traditionally packaged as a separate tool called `docker-compose` but is now included with Docker itself, which is invoked using the subcommand `docker compose` and relies on the [Docker Compose file](https://github.com/compose-spec/compose-spec) syntax.

## What is a Dockerfile?

A Dockerfile is a human-redable build script for building Docker images. The image is built using the `docker build` or `docker buildx build` commands. There is no short name for a Dockerfile, they are simply referred to as a "Dockerfile".

## What is a Docker Image?

A Docker Image (or simply an "image") is the result of a Docker build process. It can be uploaded to Docker Hub or other registries and shared with others this way.

## What is a Backdrop Docker Official Image?

A Backdrop Docker Official Image is a Docker image that is understood to be issued and maintained by the people behind Backdrop iteself, rather than being developed by members of the community (since everyone can build and upload Docker images to Docker Hub).  These images have been prepared by the Backdrop CMS Project Team in order to spread awareness about Backdrop CMS and to help people quickly and easily deploy Backdrop CMS for evaluation purposes.

### What is a Default Docker Image?

The default Docker image is the one that is installed by default by Docker when an incomplete image specifier is supplied (i.e. omitting the "tag" part).  This capability was mostly developed for convenience, but it can also be thought of as a "catchall" or "fallback" strategy.  This is usually the image with the tag "latest". 

### What Other Docker Images are There?

Alternative to the default Docker image, Backdrop and other projects may offer tagged images for specific versions, or alternative configurations (for example, Backdrop offers two varieties of images depending on the underlying web server).

[Click here to see a complete list of available Backdrop Official Docker Image tags](https://hub.docker.com/_/backdrop/tags)

# About Backdrop
![logo](https://backdropcms.org/files/inline-images/Backdrop-Logo-Horizontal_0.png)

## What is Backdrop?

_**TL;DR:  Backdrop is an exciting and promising way forward for organizations seeking a means of leaving legacy Drupal behind in such a way that existing investments in Drupal-related time, energy, people and money are not wasted or abandoned.**_

Backdrop is a web application development framework frequenty deployed in the guise of a Content Management System (or "website") for use by:

- Primary, Secondary and Tertiary Educational Institutions
- National, Regional and Municipal Governments
- Small & Medium Sized Enterprises
- Non-Governmental Organizations
- Non-Profit Organizations

## Guiding Principles
Among the leading principles that guide the Backdrop ethos are compatibility, reliability, predictability and managed complexity.  Other principles include humility, teamwork and dependability.

## History
Backdrop started off as a "fork" of the immensely popular Drupal 7 Content Management System.  The genesis of that event was the release of Drupal 8, which introduced an explosion of uncertainty, complexity and cost into the wider Drupal community. Every subsequent Drupal release, until recently, has a similar impact, leaving stakeholders confused and unhappy about what they should do with their Drpual-based websites as they rapidly devolved from "legacy" to "unsupported" status in the eyes of Drupal.  

## Present Day Situation
Many production Drupal websites are currently deployed on an "unsupported" version of Drupal (5, 6, 7, 8, 9).  In fact, "unsupported" websites currently comprise the **majority** of present-day Drupal deployments, with Drupal 7 representing over a third of the total number.


## Compatibility
The Backdrop principle of compatibility resulted in the creation of a "Drupal compatibility layer" in Backdrop very early in its evolution.  This highly useful Backdrop feature has become a bit of a "secret weapon" because "unsuppoted" Drupal code needs only to be slighty altered to then be hosted in a fully supported version of Backdrop.  This is especially the case for "unsupported" Drupal 7 code, as that was the base product from which Backdrop was derived.  The selection of Drupal 7 as the basis for Backdrop was no accident.  When Backdrop was launched, Drupal 7 was the latest and  most popular version of Drupal, with the best-developed ecosystem of contributed modules and themes.  Today, over a decade later, the Drupal 7 ecosystem is simply massive, with over 16,000 contributed modules and themes.  This staggering amount of innovation has resulted from a distributed development model supported by thousands of dedicated and loyal developers, agencies and companies that relied on Drupal 7 on a daily basis.  The result of ths collective effort is a body of work comprised of over 150,000 distinct pieces of freely available intellectual property that range across every conceivable organizational model and business problem...and all of them are available to Backdrop.

## Cost of Adoption
Converting a Drupal website to Backdrop can take a fraction of the time and expense required to migrate to other CMS systems (Wordpress, Magento) or to move onto a cloud-based solution (WIX or Shopify).  Most notably, a Drupal to Backdrop conversion is often faster and cheaper than a Drupal to Drupal upgrade - mostly due to how complicated more recent versions of Drupal have become.  To date, hundreds of organizations have chosen Backdrop because they have concluded that Backdrop is the fastest, easiest and least expensive way for them to move forward.

## Track Record
Since 2013, Backdrop has remained true to its key principles.  Today, the Backdrop story is marked by a series of increasingly significant achievements.  Backdrop has always been continually improved, and keeps up to date with the latest developments in web technology and approaches, including DLT and AI.  Backdrop is upgraded in a predictable and methodical way, with planned updates occurring every six months.  Major releases of Backdrop have been (and will be) supported for an extremely long time.  New Backdrop functionality is arriving ever more frequently as more and more Drupal modules are converted.  Finally, Backdrop has a proven, dedicated, mature, experienced and highly professional project team.

# License

View [license information](https://www.drupal.org/licensing/faq) for the software contained in this image.

# Feedback

## Issue Queue(s)
- [Backdrop CMS Core Issue Queue](https://github.com/backdrop/backdrop-issues/issues)
- [Backdrop CMS Contrib at Github.com](https://github.com/backdrop-contrib) - Each contrib project has it's own issue queue.

## Documentation
- [Backdrop CMS Documentation](https://docs.backdropcms.org/)

## Contributing
- [Contribute to the Backdrop CMS Open Source Project](https://docs.backdropcms.org/documentation/contributors-guide)