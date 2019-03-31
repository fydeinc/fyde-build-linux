#############################################################################
# Copyright 2018 Fyde, Inc.                                                 #
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

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&           \
    apt-get upgrade -qy &&      \
    apt-get install -qy         \
    curl                        \
    gnupg

# LLVM.
RUN curl -sS https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main" > /etc/apt/sources.list.d/llvm7.list
RUN echo "deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main" >> /etc/apt/sources.list.d/llvm7.list
RUN echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" > /etc/apt/sources.list.d/llvm8.list
RUN echo "deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" >> /etc/apt/sources.list.d/llvm.list

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update &&           \
    apt-get upgrade -qy &&      \
    apt-get install -qy         \
    autoconf                    \
    build-essential             \
    clang                       \
    clang-7                     \
    clang-8                     \
    curl                        \
    g++-multilib                \
    gcc-multilib                \
    git                         \
    libtool                     \
    nodejs                      \
    python3                     \
    python3-pip                 \
    unzip                       \
    yarn

# Install CMake
RUN curl -sSL https://github.com/Kitware/CMake/releases/download/v3.14.1/cmake-3.14.1-Linux-x86_64.tar.gz \
    | tar -C /usr/local --strip-components=1 -xvzf -

# Install Conan
RUN pip3 install conan==1.11.2
