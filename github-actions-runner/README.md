# GitHub Actions Runner

GitHub Actions self-hosted runner

Configures and starts the runner using the url and token provided at https://github.com/<user_or_organization>/<repo>/settings/actions/runners:

```
docker run -ti nholuongut/github-actions-runner --url <repo> --token <token> --unattended
```


Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/nholuongut).
The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/nholuongut/Dockerfiles/).
