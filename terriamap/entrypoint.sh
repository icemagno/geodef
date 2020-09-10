#! /bin/sh

cd /TerriaMap

npm start --public --verbose ./wwwroot

./node_modules/pm2/bin/pm2 logs