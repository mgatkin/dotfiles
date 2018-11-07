#!/bin/bash
VERSION=$(grep ^fuseds debian/changelog | awk '{print $2}' | cut -b2- | sed 's/.$//' | head -n 1)
sed 's/^char version\[\] = ".*\\n";/char version[] = "'${VERSION}'\\n";/' fuseds.cpp > fuseds-${VERSION}.cpp
cmp fuseds.cpp fuseds-${VERSION}.cpp > /dev/null
if [ $? -ne 0 ]; then
    cp fuseds-${VERSION}.cpp fuseds.cpp
    echo fuseds.cpp updated to version $VERSION
else
    echo fuseds.cpp already at version $VERSION
fi
rm fuseds-${VERSION}.cpp
