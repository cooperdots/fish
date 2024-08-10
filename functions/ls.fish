function ls --wraps='eza -l --git' --description 'alias ls eza -l --git'
  # eza -l --group-directories-first --git --git-ignore $argv;
  eza -l --group-directories-first --git $argv;
end

function la --wraps='eza -l --git' --description 'alias ls eza -l --git'
  eza -la --group-directories-first --git $argv;
end
