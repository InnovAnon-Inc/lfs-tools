FROM innovanon/lfs-chroot as builder-06
#USER root
ARG TEST=
COPY --from=innovanon/book /home/lfs/lfs-sysd-commands/chapter07/* \
                              /opt/bin/
COPY ./optbin.sh /etc/profile
COPY ./curl /usr/local/bin/
WORKDIR /sources
#SHELL ["/bin/bash", "--login", "+h", "-c"]

#USER root
#059-changingowner
#060-kernfs
#061-chroot
RUN tor --verify-config         \
 && chmod -v +x /opt/bin/*      \
 \
 && $SHELL -eux 062-creatingdirs \
 \
 && command -v 063-createfiles   \
 && sed -i 's@exec /bin/bash --login +h@@' \
      $(command -v 063-createfiles) \
 && $SHELL -ux  063-createfiles
USER root
RUN ls -ltra \
 \
 && tar xf gcc-10.2.0.tar.xz     \
 && cd     gcc-10.2.0            \
 && $SHELL -eux 064-gcc-libstdc++-pass2 \
 && cd     ..                    \
 && rm -rf gcc-10.2.0            \
 \
 && dl     gettext-0.21.tar.xz   \
 && tar xf gettext-0.21.tar.xz   \
 && cd     gettext-0.21          \
 && $SHELL -eux 065-gettext      \
 && cd     ..                    \
 && rm -f  gettext-0.21          \
 \
 && dl     bison-3.7.4.tar.xz    \
 && tar xf bison-3.7.4.tar.xz    \
 && cd     bison-3.7.4           \
 && $SHELL -eux 066-bison        \
 && cd     ..                    \
 && rm -rf bison-3.7.4           \
 \
 && dl     perl-5.32.0.tar.xz    \
 && tar xf perl-5.32.0.tar.xz    \
 && cd     perl-5.32.0           \
 && $SHELL -eux 067-perl         \
 && cd     ..                    \
 && rm -rf perl-5.32.0           \
 \
 && dl     Python-3.9.1.tar.xz   \
 && tar xf Python-3.9.1.tar.xz   \
 && cd     Python-3.9.1          \
 && $SHELL -eux 068-Python       \
 && cd     ..                    \
 && rm -rf Python-3.9.1          \
 \
 && dl     texinfo-6.7.tar.xz    \
 && tar xf texinfo-6.7.tar.xz    \
 && cd     texinfo-6.7           \
 && $SHELL -eux 069-texinfo      \
 && cd     ..                    \
 && rm -rf texinfo-6.7           \
 \
 && dl     util-linux-2.36.1.tar.xz \
 && tar xf util-linux-2.36.1.tar.xz \
 && cd     util-linux-2.36.1        \
 && $SHELL -eux 070-util-linux      \
 && cd     ..                       \
 && rm -rf util-linux-2.36.1        \
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
