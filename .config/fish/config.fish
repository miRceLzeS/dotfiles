if status is-interactive
    # Commands to run in interactive sessions can go here
end

if not pgrep -u (id -u) ssh-agent > /dev/null
	eval (ssh-agent -c)
	ssh-add ~/.ssh/id_rsa > /dev/null 2>&1
end
set -Ux EDITOR nvim
