cd "/Users/atirit/Documents/Coding/atirit.github.io/repo/packagesrc"

base_dir=$PWD
for DIR in "$base_dir"/*/
do
  echo $DIR
  cd "$DIR/DEBIAN"

  NAMELN=$(grep Name ./control)
  NAMESP="$(echo $NAMELN | sed 's/^[^:]*://g')"
  echo "Name of current package:$NAMESP"

  VERLN=`grep Version ./control`
  VERSP="$(echo $VERLN | sed 's/^[^:]*://g')"
  OLDVER=$(echo $VERSP | sed 's/^[^" "]*" "//g')
  echo "Current version of$NAMESP: $OLDVER"
  read -p "What's the new version of$NAMESP? " NEWVER
  case $NEWVER in
    [""]* ) NEWVER=$OLDVER
  esac
  echo "New version of$NAMESP: $NEWVER"
  sed '/Version/s/.*/Version: '"$NEWVER"'/' ./control > ./control.bak
  rm ./control
  mv ./control.bak ./control
  cd ../..
done

cd ..
./remove.sh
./packages.sh

dpkg-scanpackages -m . /dev/null >Packages
bzip2 Packages

echo "Success!"
