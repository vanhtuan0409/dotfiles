function claude --wraps claude -d 'claude with GH_TOKEN from gh auth'
  echo "=== running claude wrapper with injected GH_TOKEN"
  if not set -q GH_TOKEN
    set -l token (gh auth token 2>/dev/null)
    if test $status -eq 0; and test -n "$token"
      set -fx GH_TOKEN $token
    else
      echo "claude: gh auth token failed, starting without GH_TOKEN" >&2
    end
  end

  command claude $argv
end
