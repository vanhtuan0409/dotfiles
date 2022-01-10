function swarmup
  set dirname (basename $PWD)
  set -q argv[1]; or set argv[1] (basename $PWD)
  cat docker-compose.yml | composecrc | docker stack deploy --prune -c "-" $argv[1]
end
