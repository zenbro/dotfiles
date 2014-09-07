_cap() {
  local cache_name
  local -a cap_tasks
  local application_directory=$(pwd)
  cache_name="capistrano/${application_directory##*/}/cap_tasks"
  if [[ -f config/deploy.rb || -f Capfile ]]; then
    if ! _retrieve_cache ${cache_name}; then
      echo '\nGenerating cache for capistrano tasks...'
      cap_tasks=($(_call_program cap_tasks cap -v --tasks 2> /dev/null | grep '#' | cut -d " " -f 2))
      _store_cache ${cache_name} cap_tasks
    fi
    compadd $cap_tasks
  fi
}

compdef _cap cap
