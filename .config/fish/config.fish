if status is-interactive
    # Commands to run in interactive sessions can go here
end

if not pgrep -u (whoami) ssh-agent > /dev/null
  eval (ssh-agent -c)
  ssh-add ~/.ssh/id_rsa
end
