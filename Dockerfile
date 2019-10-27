#############################################################################
# Copyright 2019 Fyde, Inc.                                                 #
#############################################################################
#                                                                           #
# Licensed under the Apache License, Version 2.0 (the "License");           #
# you may not use this file except in compliance with the License.          #
# You may obtain a copy of the License at                                   #
#                                                                           #
#    http://www.apache.org/licenses/LICENSE-2.0                             #
#                                                                           #
# Unless required by applicable law or agreed to in writing, software       #
# distributed under the License is distributed on an "AS IS" BASIS,         #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  #
# See the License for the specific language governing permissions and       #
# limitations under the License.                                            #
#############################################################################

FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&           \
    apt-get upgrade -qy &&      \
    apt-get install -qy         \
    curl                        \
    gnupg

# LLVM.
RUN curl -sS https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main" > /etc/apt/sources.list.d/llvm8.list
RUN echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main" >> /etc/apt/sources.list.d/llvm8.list

RUN apt-get update &&           \
    apt-get upgrade -qy &&      \
    apt-get install -qy         \
    autoconf                    \
    build-essential             \
    clang-8                     \
    curl                        \
    libc++-8-dev                \
    libc++abi-8-dev             \
    g++                         \
    gcc                         \
    git                         \
    libtool                     \
    python3                     \
    python3-pip                 \
    quilt                       \
    unzip

RUN ln -fs /usr/bin/clang-8 /usr/bin/clang

RUN ln -fs python3 /usr/bin/python

# Install CMake
RUN curl -sSL https://github.com/Kitware/CMake/releases/download/v3.15.4/cmake-3.15.4-Linux-x86_64.tar.gz \
    | tar -C /usr/local --strip-components=1 -xzf -

# Install Conan
RUN pip3 install conan
