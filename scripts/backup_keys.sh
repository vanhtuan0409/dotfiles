#!/usr/bin/env bash
tmpdir=$(mktemp -d)
pwd=$(pwd)
echo $tmpdir
mkdir -p $tmpdir/keys

echo "Backing up PGP key pairs"

keybase pgp export -s -o "$tmpdir/keys/vanhtuan0409.key.pgp"

echo "Backing up SSH key pairs"

cp $HOME/.ssh/id_rsa $tmpdir/keys
cp $HOME/.ssh/id_rsa.pub $tmpdir/keys
cp $HOME/.ssh/grokking_platform $tmpdir/keys
cp $HOME/.ssh/grokking_platform.pub $tmpdir/keys

echo "Creating gzipped encrypted file"

cd $tmpdir && tar cz * | gpg --symmetric -o $pwd/keys.tar.gz.enc

echo "Cleaning up files"

rm -rf $tmpdir


