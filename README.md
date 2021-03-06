# Authelia Linux Packages

Debian supported so far.

## Usage

### Building the packages

Install the tools: [FPM](https://fpm.readthedocs.io/en/latest/installing.html), `curl`, `tar`

Set an environment variable for the Authelia version for which you wish to build packages. Then build it.

```
export AUTHELIA_VERSION=4.29.4
./build.sh
```

Additionally you can set the `DEB_REVISION` variable to 2 or more (it defaults to 1) to indicate a revision with changes to packaging but not to the binaries. Let this reset to 1 for each new Authelia version.

### Testing the package

Test the package in a Docker container. This assumes `amd64` architecture.

```
export DEB_VERSION=4.29.4-1
./test-deb.sh
```

The exit code should be 0.

### Pushing to the repo

This assumes you're uploading to a [Debian repository from Balto](https://www.getbalto.com/debian.html). 

Set a few environment variables, then push it.

```
export DEB_VERSION=3.2.0-1
export PUSH_TOKEN=your-balto-token
./push.sh
```

### Shortcut

As a shortcut for all the above, use `build-push.sh`:

```
export AUTHELIA_VERSION=3.2.1
./build-push.sh
```

## Copyright

Packaging code is offered under the MIT license, copyright 2021 Matthew Fox.

Copyright for Authelia binaries remains with the original owners.
