#!/bin/bash

# These variables refer to the version of Swift you
# want to build, and must match what Apple has
# made available at https://github.com/apple/swift/releases
# (but note *not* to prepend "swift-" to it)
TAG=4.1.1-RELEASE
VER=4.1.1
# This is what decorates the package name
REL=RELEASE4.1.1


# We use /etc/os-release to determine the version of Fedora we're on
# which will be passed to the final rpm file
source /etc/os-release

sudo dnf install -y rpm-build ninja-build clang libicu-devel gcc-c++ cmake libuuid-devel libedit-devel swig pkgconfig libbsd-devel libxml2-devel libsqlite3x-devel python-devel autoconf automake libtool libcurl-devel libatomic libblocksruntime-static
sudo ln -s /usr/bin/ninja-build /usr/bin/ninja


RPMTOPDIR=~/rpmbuild
mkdir -p $RPMTOPDIR/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}


wget https://github.com/apple/swift/archive/swift-${TAG}.tar.gz -O swift.tar.gz
mv swift.tar.gz $RPMTOPDIR/SOURCES/swift.tar.gz
wget https://github.com/apple/swift-corelibs-foundation/archive/swift-${TAG}.tar.gz -O corelibs-foundation.tar.gz
mv corelibs-foundation.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-integration-tests/archive/swift-${TAG}.tar.gz -O swift-integration-tests.tar.gz
mv swift-integration-tests.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-corelibs-xctest/archive/swift-${TAG}.tar.gz -O corelibs-xctest.tar.gz
mv corelibs-xctest.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-clang/archive/swift-${TAG}.tar.gz -O clang.tar.gz
mv clang.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-package-manager/archive/swift-${TAG}.tar.gz -O package-manager.tar.gz
mv package-manager.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-lldb/archive/swift-${TAG}.tar.gz -O lldb.tar.gz
mv lldb.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-llvm/archive/swift-${TAG}.tar.gz -O llvm.tar.gz
mv llvm.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-llbuild/archive/swift-${TAG}.tar.gz -O llbuild.tar.gz
mv llbuild.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-cmark/archive/swift-${TAG}.tar.gz -O cmark.tar.gz
mv cmark.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/ninja-build/ninja/archive/v1.7.2.tar.gz -O ninja.tar.gz
mv ninja.tar.gz $RPMTOPDIR/SOURCES/
sed -e"s/%{fedora-ver}/$VERSION_ID/" -e "s/%{ver}/$VER/" -e "s/%{rel}/$REL/" -e "s/%{tag}/$TAG/" swift.spec > $RPMTOPDIR/SPECS/swift.spec
rpmbuild -ba $RPMTOPDIR/SPECS/swift.spec	
