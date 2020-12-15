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

# Install 3rd party dependencies (in this case, OpenCV)
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/master.zip && \
    unzip opencv.zip && \
    mkdir -p build && cd build && \
    cmake  ../opencv-master && \
    cmake --build . && \
    make install

COPY . /${PROJECT_DIR}/
RUN mkdir /${PROJECT_DIR}/build

# pip install runs setup.py which builds the project using the root CMakeLists.txt
WORKDIR /${PROJECT_DIR}/
RUN python -m pip install .
ENTRYPOINT ["/bin/bash"]