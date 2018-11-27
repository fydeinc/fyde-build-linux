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

FROM ubuntu:16.04

MAINTAINER Ricardo Martins <ricardo@fyde.com>

ARG CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v3.13.0/cmake-3.13.0-Linux-x86_64.tar.gz
ARG ANDROID_NDK=https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&   \
    apt-get install -qy \
    build-essential     \
    clang               \
    curl                \
    git                 \
    python              \
    unzip               \
    wget                

# Install CMake
RUN wget ${CMAKE_URL} -O - \
    | tar -C /usr/local --strip-components=1 -xvzf -

# Install Ninja.
RUN git clone git://github.com/martine/ninja.git && \
      cd ninja && \
      git checkout release && \
      ./configure.py --bootstrap && \
      mv ninja /usr/local/bin && \
      ln -fs ninja /usr/local/bin/ninja-build && \
      cd .. && \
      rm -rf ninja && \
      chmod 0755 /usr/local/bin/ninja

# Android NDK.
RUN wget ${ANDROID_NDK} -O /opt/android.zip && cd /opt && unzip android.zip && rm -rf android.zip
RUN ln -s /opt/android-ndk-* /opt/android-ndk
