#!/bin/bash

pushd .
cd examples
mvn clean install
popd 

mkdir -p target/site/reference
mkdir -p target/site/pdf

cp examples/target/mvnref-book-examples-1.0-SNAPSHOT-project.zip target/site/mvnref-examples.zip

cp -r target/book-mvnref.chunked/* target/site/reference
cp target/book-mvnref.pdf target/site/pdf/mvnref-pdf.pdf
python template.py
cp target/site/reference/index.html target/site/reference/public-book.html
rsync -e ssh -av target/site/* deployer@www.sonatype.com:/var/www/domains/sonatype.com/www/shared/books/mvnref-book/
