Builds an docker image with the [Travis run](https://github.com/travis-ci/travis-build)  ready to run.

Running
-------

- put your `.travis.yml` file in your working directory
- run the docker container with:

        docker run --rm -it -v $(pwd):/data waja/travis-cli --help 

Building
--------

    make build

Get a shell in a running container
----------------------------------

    make shell
