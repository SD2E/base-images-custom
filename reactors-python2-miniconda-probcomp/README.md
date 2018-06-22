# Reactors / Python2 x Miniconda / Probcomp Stack

This is a base image to support building Python2.7.x Reactors where Conda is
a first-class method alongside pip for resolving dependencies.

## How it works

A selection of packages to support MIT's Probabilistic Computing Environment
is installed atop a Python2 Reactors image using conda 4.4.10. Conda Forge is
activated in the image. Then, the ONBUILD support from the originating
Reactors image is replicated.

The repository is automatically rebuilt and a new image pushed to Docker Hub
when updates occur to the upstream `base-images` source repository.

