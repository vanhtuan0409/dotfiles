function anduin_ecr_login
  set -l region "$argv[1]"
  if test -z "$region"
    echo "missing region"
    return 1
  end
  aws ecr get-login-password --region "$region" | docker login --username AWS --password-stdin "988983267146.dkr.ecr.$region.amazonaws.com"
end
