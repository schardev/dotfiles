function __set_package_manager_aliases_hook() {
  if git rev-parse --show-toplevel &> /dev/null; then
    local git_root="$(git rev-parse --show-toplevel)/"
  fi

  # set default to pnpm
  local pkg_manager="pnpm"
  alias px="pnpm dlx"

  if [[ -f "${git_root}package-lock.json" ]]; then
    pkg_manager="npm"
    alias px="npx"
  elif [[ -f "${git_root}yarn.lock" ]]; then
    pkg_manager="yarn"
    alias px="yarn dlx"
  fi

  alias pa="${pkg_manager} add"
  alias pe="${pkg_manager} exec"
  alias pi="${pkg_manager} install"
  alias pp="${pkg_manager}"
}

# run on startup
__set_package_manager_aliases_hook

# ZSH hook function. Executed whenever the current working directory is changed.
chpwd_functions+=(__set_package_manager_aliases_hook)
