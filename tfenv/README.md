# TFenv

https://github.com/tfutils/tfenv

`tfenv` is a version manager for Terraform

Run any version of Terraform dynamically, downloads the version dynamically.

```
docker run --rm -ti nholuongut/tfenv <terraform_args>
```

Pass the environment variable `TERRAFORM_VERSION` to this docker container to run that version of terraform:

```
docker run --rm -ti -e TERRAFORM_VERSION=1.2.3 nholuongut/tfenv <terraform_args>
```

Designed to be a utility for a dynamic CI/CD pipeline to run different versions of Terraform for different environments.

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/nholuongut).
The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/nholuongut/Dockerfiles/).
