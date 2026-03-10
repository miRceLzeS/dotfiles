if command -q nvim
  function nv --wraps nvim
    command nvim $argv
  end
end

if command -q lsd
  function ls --wraps lsd
    command lsd $argv
  end

  function la --wraps "lsd -Al"
    command lsd -Al $argv
  end

  function ltr --wraps "lsd --tree"
    command lsd --tree $argv
  end
end

if command -q lazygit
  function lg --wraps lazygit
    command lazygit $argv
  end
end
