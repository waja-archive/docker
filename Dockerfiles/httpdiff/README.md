Builds an docker image with the [httpdiff](https://github.com/jgrahamc/httpdiff)  ready to run.

Running
-------

- put your `.travis.yml` file in your working directory
- run the docker container with:

        docker run --rm -it waja/httpdiff-cli --help 

Building
--------

    make build

Get a shell in a running container
----------------------------------

    make shell
