# Spotify Tools

Many tools require authorization. You will need to create a Spotify App with Client ID and Secret here:

https://developer.spotify.com/dashboard/applications

and then `export` the environment variables `SPOTIFY_ID` and `SPOTIFY_SECRET` in your shell and pass them to the docker container:

```
docker run --rm -ti -e SPOTIFY_ID -e SPOTIFY_SECRET nholuongut/spotify-tools <program> <args>
```

If you want to run things requiring user private data, such as listing private playlists, then you will need to get an interactively authorized token valid for an hour and pass that through to the docker container instead (`spotify_api_token.sh` in the [DevOps Bash tools](https://github.com/nholuongut/bash-tools) can generate that for you, but at that point you need a local copy - this is a limitation of the way the Spotify API is designed to require interactive user authorization in a web browser):

```
export SPOTIFY_ACCESS_TOKEN="$(SPOTIFY_PRIVATE=1 /path/to/spotify_api_token.sh)"

docker run --rm -ti -e SPOTIFY_ACCESS_TOKEN nholuongut/spotify-tools <program> <args>
```

List available programs like so
```
docker run --rm -ti nholuongut/spotify-tools
```


Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/nholuongut).
The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/nholuongut/Dockerfiles/).
