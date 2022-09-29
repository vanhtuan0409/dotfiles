function asp -a cmd -d 'AWS switch profile'
  if set -q argv[1]
    set -gx AWS_PROFILE "$argv[1]"
    echo $AWS_PROFILE
  else
    echo $AWS_PROFILE
  end
end
