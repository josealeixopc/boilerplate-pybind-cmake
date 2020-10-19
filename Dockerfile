# Arguments are scoped to a build-stage
# But we can specificy a global ARG which is set before the first build-stage
# ARG PROJECT_DIR="python-bindings"
# IF THERE IS ONLY ONE STAGE, THIS WILL NOT WORK!!! (That's why it's commented.)

# First stage is for building the Python bindings
FROM python:3.7 as builder

# Make sure we don' get prompts
ENV DEBIAN_FRONTEND noninteractive

ARG PROJECT_DIR="python-bindings"

# Update repositories
RUN apt-get update -y -qq && \
    apt-get upgrade -y -qq

# Install basic dependencies
RUN apt-get install -y -qq \
    cmake \
    curl \
    git \
    tar \
    unzip \
    wget

COPY . /${PROJECT_DIR}/
RUN mkdir /${PROJECT_DIR}/build
WORKDIR /${PROJECT_DIR}/build
RUN cmake .. && \
    cmake --build .

WORKDIR /${PROJECT_DIR}/
RUN python -m pip install .
ENTRYPOINT ["/bin/bash"]

# # Delete every file except .so libraries
# RUN find ./python -type f ! -name '*.so' -delete
# # Delete some eventual empty directories
# RUN find . -type d -empty -delete


# FROM python:3.7

# WORKDIR /app
# COPY --from=builder /${PROJECT_DIR}/build/python .
# ENTRYPOINT ["/bin/bash"]