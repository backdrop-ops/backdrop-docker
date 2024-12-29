This README explains in plain language how to deploy Backdrop CMS inside a Docker container.  

Later sections of this document explore what Docker is and also what Backdrop is.

# Table of Contents

1. [Installation](#installation)
2. [About Docker](#about-docker)
3. [About Backdrop](#about-backdrop)

# Installation
The fastest and easiest way to "spin up" Backdrop in a Docker container is to:

 1)  Ensure Docker is installed
 2)  Create a directory to hold docker assets
 3)  Create a docker startup file that references a Backdrop Docker Image
 4)  Launch docker so that it knows to process the recently created docker startup file

## Step 1:  Ensure Docker is Installed
[Click here to see Docker's installation instructions for Windows, Mac and Linux](https://www.docker.com/get-started)

## Step 2:  Create a Directory to Hold Docker assets
Create a directory named `backdrop-eval` to hold any Backdrop-related Docker assets

```
md backdrop-eval

cd backdrop-eval
```

## Step 3:  Create a Docker Startup File that References a Backdrop Docker Image
In the `backdrop-eval` directory, create `compose.yml` file with the following contents:
```

services:

  backdrop:

    image: backdrop:latest

    container_name: backdrop

    ports:

      - 8088:80

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

## Step 4:  Launch docker in Such a Way That it Knows to Processes the Recently Created Docker Startup File
While in the `docker-eval` directory, enter the following command:

```
docker compose up
```

This command instructs docker to process the `compose.yml` file.  The screen should immediately begin to fill with startup messages as docker composes the Backdrop runtime environment.  After a minute or so, the pace of new messages should settle down, with just status messages being displayed.  At this point the Backdrop installation screen should be accessible via a web browser.

# How to Access Backdrop in a Local Docker Container
If the web browser is running on **the same machine** as docker, Backdrop should be accessible at:

```
http://localhost:8080
```

# How to Access Backdrop in a Remote Docker Container
If the web browser is running on **a different machine** than the one running docker, Backdrop should be accessible at:

```
http://{host-ip}:8080
```

_(where `{host-ip}` is the IP address of the machine running docker)_


# Backdrop Installation - Database Credentials
Don't forget that the Backdrop install requires the following database credentials to proceed:

```
User:      backdrop
Password:  backdrop
Database:  backdrop
```

# Validating Backdrop-Related Docker Containers
Validating that Docker indeed constructed a valid runtime environment for Backdrop may be accomplished with the following command:

```
docker ps
```

The resulting listing should include TWO (2) docker containers:

- One for the MySQL database server that Backdrop requires (mysql)
- One for Backdrop itself (backdrop)

```
[example docker ps output here...]
```

## How to Access the Backdrop host
Accessing the Backdrop host can be accomplished by issuing the following command on the machine running Docker:

```
docker exec -it backdrop bash
```

## Trying Out the ALTERNATE Docker Images
The example `compose.yml` specifically references the `backdrop:latest` docker image.

This is just in order to get people new to Docker started quickly and easily.  Once someone becomes more familiar with Docker and using it to "spin up" containers, there is no reason why they wouldn't want to be curious about the **ALTERNATE** docker images, and wondering if one of those images suited their requirements better.  

To accomplish that, the only thing that needs be done is change the image specifier in the `backdrop` section of the `compose.yml` file.  The general format to identify a specific Docker image is:

```
repository:image
```


[Click here to see a complete list of every available Backdrop Official Docker Image](https://hub.docker.com/_/backdrop/tags)

# About Docker

![logo](https://raw.githubusercontent.com/docker-library/docs/c350af05d3fac7b5c3f6327ac82fe4d990d8729c/docker/logo.png)

## What is Docker?
Docker is an application that can significantly reduce the time, effort and cost involved when deploying software.  It can dramatically reduce deployment time, often by an order of magnitude (hours to minutes, minutes to seconds).

Functionally speaking, Docker offers two main services:

- Docker provides a **build** environment that utilizes a Dockerfile to produce a Docker Image containing everything a target application might need to run.  The short name for a Docker Image is simply "image".

- Docker provides a **run** environment wherein a Docker Image may be loaded and launched, thereby making the target application within that image accessible.  The short name for the Docker Runtime Environment is "container".

## What is a Dockerfile?
A Dockerfile is a human-redable script containing all the commands Docker needs to alter a source Docker Image into a target Docker Image.  There is no short name for a Dockerfile, they are simply referred to as a "Dockerfile".

## What is a Docker Image?
A Docker Image ("image") is the result of a Docker build process.

## What is a Backdrop Docker Official Image?

A Backdrop Docker Official Image is a Docker image that exposes the functionality of a Backdrop CMS instance in a container.  These images have been prepared by the Backdrop CMS Project Team in order to spread awareness about Backdrop CMS and to help people quickly and easily deploy Backdrop CMS for evaluation purposes.

### What is a MAIN Docker Image?
The **MAIN** Docker image is the one that is installed by **DEFAULT** by Docker when an incomplete image specifier has been supplied.  This capability was mostly developed for convenience, but it can also be thought of as a "catchall" or "fallback" strategy.  It is also very useful when the latest version of an image is unknown as it will always install the preferred (and latest) version of an image unless instructed not to do so.

### What is an ALTERNATE Docker Image?
**ALTERNATE** Docker images are a different story.  These images must be fully specified if they are to be loaded and launched by Docker specifically _because_ they are not the prefered, latest image.  Instead, they represent an exploration of "what if" scenarios with respect to Backdrop.  Usually, this involves the incorporation of a different software sub-system, such as a different web server.  Sometimes they represent a different version of the language that Backdrop was implemented in.  Sometimes they represent a "snapshot" in the history of the development of Backdrop.  In any event, accessing these images requires that they be fully and completely specified to Docker.

[Click here to see a complete list of every available Backdrop Official Docker Image](https://hub.docker.com/_/backdrop/tags)

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

