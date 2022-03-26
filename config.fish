if status is-interactive
  set fish_greeting
  kanagawa

  if test -z $TMUX
    bind \ca "tmux a 2> /dev/null || tmux; fish_prompt"
  end
end
