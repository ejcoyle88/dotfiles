if status --is-interactive
  set -g fish_user_abbreviations
  set -g fish_key_bindings fish_vi_key_bindings
  bind -M insert \cc kill-whole-line force-repaint

  function gotoDev -d "Goes to the local development dir"
    if [ -n "$LDEV" ]
      cd $LDEV
    else
      echo "set the LDEV variable."
    end
  end

  if type -q "exa"
    function ls
      exa -la --git --color=always $argv
    end
  else
    alias ls="!ls -la" $argv
  end

  if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
  source ~/.config/fish/plugins.fish

  [ -f ~/.config/fish/local_vars.fish ] && source ~/.config/fish/local_vars.fish
end
