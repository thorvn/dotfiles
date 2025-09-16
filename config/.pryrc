if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

if defined?(Reline)
  # Disable WINCH signal handling in multiplexers
  Signal.trap("WINCH", "IGNORE") if ENV['ZELLIJ'] || ENV['TMUX']
end
