local _M = {}

function _M.is_shopee_path(cond)
  return function(utils)
    local ret = false
    if not SHOPEE_PATH then
      ret = false
    else
      ret = utils.root_matches(SHOPEE_PATH)
    end

    if cond then
      return ret
    end
    return not ret
  end
end

return _M
