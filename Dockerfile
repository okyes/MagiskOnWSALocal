# best practice to not use latest tag, drawback is that we need to ensure particular tag compatibility
# and not forget to update tag when migrating to new container major release
FROM ubuntu:jammy AS updated

# best practice to use absolute pathes https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#workdir
COPY . /root/MagiskOnWSALocal

# in case you decide to remove executable bit in VCS
RUN chmod +x /root/MagiskOnWSALocal/scripts/install_deps.sh

WORKDIR /root/MagiskOnWSALocal

# minimize the number of layers https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get
RUN apt-get update \
    && apt-get install -y sudo \
    && /root/MagiskOnWSALocal/scripts/install_deps.sh \
    && rm -rf /var/lib/apt/lists/*

RUN chmod +x /root/MagiskOnWSALocal/scripts/build.sh

VOLUME ["/root/MagiskOnWSALocal/output"]
CMD ["sh", "-c", "exec /root/MagiskOnWSALocal/scripts/build.sh --release-type $WSA_RELEASE_TYPE"]

FROM updated as retail
ENV WSA_RELEASE_TYPE=retail

RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver stable || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch arm64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand OpenGApps --magisk-ver beta || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver canary || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver debug || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol kernelsu --gapps-brand MindTheGapps || true

FROM updated as rp
ENV WSA_RELEASE_TYPE=RP

RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver stable || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch arm64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand OpenGApps --magisk-ver beta || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver canary || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver debug || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol kernelsu --gapps-brand MindTheGapps || true

FROM updated as wis
ENV WSA_RELEASE_TYPE=WIS

RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver stable || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch arm64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand OpenGApps --magisk-ver beta || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver canary || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver debug || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol kernelsu --gapps-brand MindTheGapps || true

FROM updated as wif
ENV WSA_RELEASE_TYPE=WIF

RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver stable || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch arm64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand OpenGApps --magisk-ver beta || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver canary || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol magisk --gapps-brand MindTheGapps --magisk-ver debug || true
RUN /root/MagiskOnWSALocal/scripts/build.sh --arch x64 --release-type $WSA_RELEASE_TYPE --root-sol kernelsu --gapps-brand MindTheGapps || true
