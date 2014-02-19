
bash = require "calabash"

bash.do "compile and watch",
  "pkill -f doodle"
  "coffee -o src/ -bcw coffee/"
  'watchify src/test.js -o build/build.js -v'
  "doodle index.html log:yes delay:0 cirru/"