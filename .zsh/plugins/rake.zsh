_rake() {
  local cache_name
  local -a rake_tasks
  local application_directory=$(pwd)
  cache_name="rake/${application_directory##*/}/rake_tasks"
  if [ -f Rakefile ]; then
    if ! _retrieve_cache ${cache_name}; then
      echo '\nGenerating cache for rake tasks...'
      rake_tasks=($(_call_program rake_tasks rake --silent --tasks | cut -d " " -f 2))
      _store_cache ${cache_name} rake_tasks
    fi
    compadd $rake_tasks
  fi
}

compdef _rake rake
