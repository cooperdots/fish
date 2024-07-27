function ls --wraps='exa -l --git' --description 'alias ls exa -l --git'
  # exa -l --group-directories-first --git --git-ignore $argv;
  exa -l --group-directories-first --git $argv;
end

function la --wraps='exa -l --git' --description 'alias ls exa -l --git'
  exa -la --group-directories-first --git $argv;
end
