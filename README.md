# docker-openrefine

> Original Dockerfile from https://github.com/vimagick/dockerfiles/tree/master/openrefine

## Build

```sh
docker build -t saagie/openrefine:tag .
```

## Push

```sh
docker push <your docker id> <version>
```


## Usage

### Basic usage
You can run openrefine on http://localhost:3333/ with: 
```sh
docker run --rm -p 3333:3333 --name openrefine saagie/openrefine:tag 
```

### Advanced usage
You can run openrefine on a url different than `/`, for example: http://localhost:3333/refine with:
```sh
docker run --rm -p 3333:3333 --name openrefine --env CONTEXT_PATH=/refine  saagie/openrefine:tag 
```

