
bash = require "calabash"

bash.do "compile and watch",
  "pkill -f doodle"
  "coffee -o src/ -cmw coffee/"
  "doodle index.html src/ delay:0 cirru/"