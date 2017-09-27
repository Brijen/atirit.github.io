dpkg-deb -b -Zlzma packagesrc/com.atirit.lotusextension
find $PWD -type f -print0 | xargs -0 mv -t $PWD/..
