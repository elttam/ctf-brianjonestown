# Overview

**Title:** brianjonestown  
**Category:** Web  
**Flag:** libctf{better_than_the_original}  
**Difficulty:** easy

# Usage

The following will pull the latest 'elttam/ctf-brianjonestown' image from DockerHub, run a new container named 'libctfso-brianjonestown', and publish the vulnerable service on port 80:

```sh
docker run --rm \
  --publish 80:80 \
  --name libctfso-brianjonestown \
  elttam/ctf-brianjonestown:latest
```

# Build (Optional)

If you prefer to build the 'elttam/ctf-brianjonestown' image yourself you can do so first with:

```sh
docker build ${PWD} \
  --tag elttam/ctf-brianjonestown:latest
```
