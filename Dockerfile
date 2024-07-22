# Use the official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Create a non-root user and add to the sudo group
RUN useradd -ms /bin/bash nonrootuser \
    && echo 'nonrootuser:password' | chpasswd \
    && usermod -aG sudo nonrootuser

# Update the package list and install basic packages
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    git \
    sudo \
    gawk \
    wget \
    diffstat \
    unzip \
    texinfo \
    gcc \
    build-essential \
    chrpath \
    socat \
    cpio \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    python3-subunit \
    zstd \
    liblz4-tool \
    file \
    locales \
    libacl1 \
    nano \
    && apt-get clean

# Generate the en_US.UTF-8 locale
RUN locale-gen en_US.UTF-8

# Set locale environment variables
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Set the root password (if necessary for some reason)
RUN echo 'root:walid' | chpasswd

# Switch to the non-root user
USER nonrootuser

# Create and copy the startup script
USER root
COPY setup.sh /home/nonrootuser/setup.sh

# Ensure the script is executable
RUN chmod +x /home/nonrootuser/setup.sh

# Switch back to non-root user
USER nonrootuser

# Set the default command to run when starting the container
CMD ["/bin/bash", "-c", "/home/nonrootuser/setup.sh && exec /bin/bash"]
