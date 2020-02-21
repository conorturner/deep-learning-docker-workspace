# Deep Learning Docker Workspace (dldw)

- DLDW is a minimal python deep learning workspace with CUDA drivers pre-installed.
- FUSE and GCSFUSE are also installed as they are the simplest option for transporting tensorboard logs out of the container.
- CUDA 10.1 + Python 3.6

## Usage

### Running the container

The container supports various executions types to best suit different workflows:

**Run the container as an interactive interpreter:**
```bash
docker run -it conorturner/dldw:latest python3
```
**Run the container an ssh daemon on port 2222:**
```bash
docker run -d -p 2222:22 conorturner/dldw:latest
```
or to enable GPU access:
```bash
docker run --runtime nvidia -d -p 2222:22 conorturner/dldw:latest
```

### Connecting to the workspace

- This container is designer specifically to work with the pycharm remote SSH interpreter.
- To connect to the container directly use `ssh -p 2222 root@localhost`
- The **default password** is `pass`.
- If you would like to change the root password please build from source (see Development/Build)

## Development/Build

### How to build locally
- To build this container you **do not** need cuda drivers installed.
- There is a Makefile in the project root with useful (example) commands if you are new to docker.
- `make debug` can be used to start the container as a TTY with verbose logs to help solve issues.
- See Dockerfile for build args if you would like to rebuild this container with a different CUDA or Python version.

### Side notes
- If you use this container and make useful/minimal updates please submit them for review.
- If this container requires bug fixes please submit them as issues - I would like to support as many systems/versions as possible.
