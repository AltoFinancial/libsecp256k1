#!/bin/sh

set -e

PRIV_PATH=priv
TARGET="$PRIV_PATH"/libsecp256k1_nif.so

case "$1" in
  clean)
    rm -rf secp256k1
    ;;

  *)
    # skip download and compile when the compiled so is there
    test -f $TARGET && exit 0
    (test -d c_src/secp256k1 || git clone https://github.com/bitcoin/secp256k1)

    (cd c_src/secp256k1 && git reset --hard 5a91bd768faaa974e00301e662fd8f2aa75a122a &&  ./autogen.sh && ./configure --enable-module-recovery && make)
	#(cd secp256k1 &&  ./autogen.sh && ./configure --enable-module-recovery && make)
    ;;
esac
