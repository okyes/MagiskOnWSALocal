# best practice to not use latest tag, drawback is that we need to ensure particular tag compatibility
# and not forget to update tag when migrating to new container major release
FROM ubuntu:jammy

# best practice to use absolute pathes https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#workdir
COPY . /root/MagiskOnWSALocal

# in case you decide to remove executable bit in VCS
RUN chmod +x /root/MagiskOnWSALocal/scripts/install_deps.sh

# minimize the number of layers https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get
RUN /root/MagiskOnWSALocal/scripts/install_deps.sh \
    && rm -rf /var/lib/apt/lists/*

RUN chmod +x /root/MagiskOnWSALocal/scripts/run.sh

WORKDIR /root/MagiskOnWSALocal
VOLUME ["/root/MagiskOnWSALocal/output"]
CMD ["/root/MagiskOnWSALocal/scripts/run.sh"]
