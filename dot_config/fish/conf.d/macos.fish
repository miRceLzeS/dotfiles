if test (uname) = "Darwin"
  if type -q brew
    fish_add_path -m (brew --prefix)/bin
  end
end

