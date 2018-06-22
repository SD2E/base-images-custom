# Extended SD2E Base Images

This repository supports automatic build and maintenance of Docker images
derived from generic sd2e base images. This offers a path to distribute
images with complex extensions that might be widely usable but not quite to
the extend that those extensions should go into the common images. The proto-
type example is the Probabilistic Computing Stack reactor.

## Adding a new base image

Check out the `develop` branch of the repository, then check out a new branch.

```shell
$ git checkout develop'
$ git pull origin develop
$ git checkout -b <my_branch_name>
```

Copy `image-template` and extend it to your purposes. You must support the
`all`, `tests`, `deploy`, and `clean` targets in your `Makefile`. Once
your image is building and tests are passing, add its dirctory to the main
`Makefile` by extending `PROJECTS`.

Commit and push your branch to `origin`

```shell
git push origin <my_branch>
```

Check the status of the build at [TravisCI](https://travisci.org/sd2e/base-images-custom). If your build is succesful, open a pull request against `develop` and someone
will accept your changes and your image will be built automatically, then
pushed to DockerHub. Test it out, then create a PR to merge your change into
`master`. At that point, your new image will be automatically maintained.

## Maintaining your image

Use the same workflow as for creating a new maintained image. Check out
`develop` and branch. Issue a PR against `develop`. Test the image. Issue a
PR against `master`.

