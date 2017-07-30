set -e

wget -O- get.pharo.org/vm60| bash

wget https://github.com/guillep/PharoBootstrap/releases/download/v1.1.1/bootstrapImage.zip

unzip bootstrapImage.zip

./pharo-ui Pharo.image st load.st --save --quit

