function gondor_kill
  argparse 'f/force' -- $argv 
  or return

  if set -q _flag_force
    echo "Force kill"
    jps | grep MillBackgroundWrapper | awk '{print $1}' | xargs kill -9
  else
    jps | grep MillBackgroundWrapper | awk '{print $1}' | xargs kill 
  end
end
