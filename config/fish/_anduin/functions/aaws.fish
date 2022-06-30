function aaws
  argparse 'p/profile' 'd/duration' 'f/force' 'h/help' -- $argv
  if set -q _flag_help
    echo "aaws [OPTIONS]"
    echo "OPTIONS:"
    echo "  -p/--profile    Using AWS profile"
    echo "  -d/--duration   Using STS token duration"
    echo "  -f/--force      Force generate MFA token"
    return 0
  end

  set -q _flag_profile || set _flag_profile default
  set -q _flag_duration || set _flag_duration 24h
  set -q _flag_force && set totp (aop item get "AWS Anduin" --fields type=otp --format json | jq -r .totp)

  echo Using profile $_flag_profile
  echo Using duration $_flag_duration
  echo Using TOTP $totp
  aws-vault exec $_flag_profile --duration=$_flag_duration --mfa-token=$totp -- env | grep -i aws | envsource
end
