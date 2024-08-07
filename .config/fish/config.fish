if status is-interactive
    # Commands to run in interactive sessions can go here
end

eval (ssh-agent -c)
ssh-add ~/.ssh/id_rsa
