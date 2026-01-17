function opgh -d 'Export GH_TOKEN from 1password'
  argparse 'h/help' 'w/write' -- $argv
  or return 1

  if set -q _flag_help
    echo "Usage: opgh [-w|--write]"
    echo ""
    echo "Export GH_TOKEN from 1password to the current shell session."
    echo "Defaults to read-only token."
    echo ""
    echo "Options:"
    echo "  -w, --write    Use write token (requires OP_GITHUB_PRIV_ID)"
    echo "  -h, --help     Show this help"
    echo ""
    echo "Environment variables:"
    echo "  OP_GITHUB_SAFE_ID    1password item ID for read-only token (default)"
    echo "  OP_GITHUB_PRIV_ID    1password item ID for write token"
    return 0
  end

  if set -q _flag_write
    if not set -q OP_GITHUB_PRIV_ID
      echo "opgh: OP_GITHUB_PRIV_ID is not set" >&2
      return 1
    end
    set item_id $OP_GITHUB_PRIV_ID
  else
    if not set -q OP_GITHUB_SAFE_ID
      echo "opgh: OP_GITHUB_SAFE_ID is not set" >&2
      return 1
    end
    set item_id $OP_GITHUB_SAFE_ID
  end

  set token (op item get $item_id --fields token --reveal 2>/dev/null)
  if test $status -ne 0; or test -z "$token"
    echo "opgh: failed to retrieve token from 1password" >&2
    return 1
  end

  set -gx GH_TOKEN $token
  echo "GH_TOKEN exported" (set -q _flag_write && echo "(read-write)" || echo "(read-only)")
end
