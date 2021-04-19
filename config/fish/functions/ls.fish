function ls --wraps='!ls -la'
    exa -l -a -F --icons -h $argv
end
