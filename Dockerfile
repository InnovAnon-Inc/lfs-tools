FROM innovanon/lfs-chroot as builder-06
#USER root
ARG TEST=
COPY --from=innovanon/book /home/lfs/lfs-sysd-commands/chapter07/* \
                              /opt/bin/
COPY ./optbin.sh /etc/profile
WORKDIR /sources
#SHELL ["/bin/bash", "--login", "+h", "-c"]

#USER root
#059-changingowner
#060-kernfs
#061-chroot
RUN tor --verify-config         \
 && chmod -v +x /opt/bin/*      \
RUN echo $PATH | grep opt       \
 && command -v 062-creatingdirs \
 \
 && $SHELL -eux 062-creatingdirs \
 && sed -i 's@exec /bin/bash --login +h@@' $(command -v 063-createfiles) \
 && $SHELL -ux  063-createfiles  \
 \
 && tar xf gcc-10.2.0.tar.xz     \
 && cd     gcc-10.2.0            \
 && $SHELL -eux 064-gcc-libstdc++-pass2 \
 && cd     ..                    \
 && rm -rf gcc-10.2.0            \
 \
 && tar xf gettext-*.tar.gz      \
 && cd     gettext-*             \
 && $SHELL -eux 065-gettext      \
 && cd     ..                    \
 && rm -f  gettext-*             \
 \
 && tar xf bison-*.tar.gz        \
 && cd     bison-*               \
 && $SHELL -eux 066-bison        \
 && cd     ..                    \
 && rm -rf bison-*               \
 \
 && tar xf perl-*.tar.gz         \
 && cd     perl-*                \
 && $SHELL -eux 067-perl         \
 && cd     ..                    \
 && rm -rf perl-*                \
 \
 && tar xf Python-*.tar.gz       \
 && cd     Python-*              \
 && $SHELL -eux 068-Python       \
 && cd     ..                    \
 && rm -rf Python-*              \
 \
 && tar xf texinfo-*.tar.gz      \
 && cd     texinfo-*             \
 && $SHELL -eux 069-texinfo      \
 && cd     ..                    \
 && rm -rf texinfo-*             \
 \
 && tar xf util-linux-*.tar.gz   \
 && cd     util-linux-*          \
 && $SHELL -eux 070-util-linux   \
 && cd     ..                    \
 && rm -rf util-linux-*          \
 \
 && $SHELL -eux 071-stripping    \
 && exec true || exec false

# TODO

#FROM builder-06 as squash-tmp
#USER root
#RUN  squash.sh
#FROM scratch as squash
#ADD --from=squash-tmp /tmp/final.tar /

FROM builder-06
