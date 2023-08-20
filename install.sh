#!/bin/sh

cd corpi
unzip openssl-3.1.2.zip

tar cvf openssl-3.1.2.tar openssl-3.1.2
gzip -k openssl-3.1.2.tgz openssl-3.1.2.tar

bzip2 --keep enwik8.bz2 enwik8
gzip  --keep enwik8.gz  enwik8
lzip  --keep enwik8.lz4 enwik8
xz    --keep enwik8.xz  enwik8
zstd  --keep enwik8.zst enwik8
