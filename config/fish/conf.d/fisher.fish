set --query fisher_path || exit

set -ga fish_function_path $fisher_path/functions
set -ga fish_complete_path $fisher_path/completions

for file in $fisher_path/conf.d/*.fish
  source $file
end

# Manually init due to custom `fisher_path`
__kubectl.init
