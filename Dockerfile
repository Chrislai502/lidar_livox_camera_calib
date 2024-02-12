# This is an auto generated Dockerfile for ros:ros-base
# generated from docker_images/create_ros_image.Dockerfile.em
FROM ros:noetic-ros-core-focal

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python3-rosdep \
    python3-rosinstall \
    python3-vcstools \
    git \
    cmake \ 
    wget \ 
    libgoogle-glog-dev \
    libgflags-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libboost-all-dev \
    libpcl-dev \
    libopencv-dev \
    ros-noetic-rviz \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && rosdep update --rosdistro $ROS_DISTRO

# # install ros packages
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ros-noetic-ros-base=1.5.0-1* \
#     && rm -rf /var/lib/apt/lists/*

# Add github as known host for private repositories
RUN mkdir -p ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# Install Ceres Solver (form source)
RUN --mount=type=ssh git clone git@github.com:ceres-solver/ceres-solver.git --branch 1.14.0rc2 --single-branch /ceres-solver && \
    cd /ceres-solver && \
    mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE .. && \ 
    make -j$(nproc) && \
    make install 

# # Install a specific version of Eigen (from source)
RUN git clone https://gitlab.com/libeigen/eigen.git --branch 3.3.7 --single-branch /eigen && \
    cd eigen && \
    mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE .. && \
    make install

# Install OpenCV from source 
RUN git clone --branch 3.4.14 https://github.com/opencv/opencv.git /opencv && \
    cd /opencv && \
    mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          .. && \
    make -j$(nproc) && \
    make install

# # Note: PCL and OpenCV are installed via apt-get with libpcl-dev and libopencv-dev packages.
# # If specific versions are needed that differ from those packages, they should be built from source similar to OpenCV and Eigen.
# # Install OpenCV from source 
# RUN git clone --branch pcl-1.8.0 https://github.com/PointCloudLibrary/pcl.git /pcl && \
#     cd /pcl && \
#     mkdir build && cd build && \
#     cmake -DCMAKE_BUILD_TYPE=RELEASE .. && \
#     ls -la && \
#     if [ -f Makefile ]; then cat Makefile; fi && \
#     make -j$(nproc) && \
#     sudo make install
RUN apt-get update && apt-get install --no-install-recommends -y \
    ros-noetic-pcl-msgs \
    ros-noetic-pcl-ros    \
    ros-noetic-pcl-conversions \
    ros-noetic-cv-bridge \
    && rm -rf /var/lib/apt/lists/*

# Clean up 
RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opencv /ceres-solver /eigen /pcl

# Setup entrypoint or default command
CMD ["bash"]

