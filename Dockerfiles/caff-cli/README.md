Builds an docker image with the [caff](https://wiki.debian.org/caff)  ready to
run.

Running
-------

- put your .caff/keys/, .caffrc, .gnupg/ and .msmtprc` file in your working
  directory
- run the docker container with:

        docker run --rm -it -v $(pwd):/data waja/caff-cli --help 

Building
--------

    make build

Get a shell in a running container
----------------------------------

    make shell
