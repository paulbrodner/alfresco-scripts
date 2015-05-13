#
# Adding coloring on bash_profile
#
module Install
  include DevOn

  coloring = %q{
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'}

  Command.run_shell("touch ~/.bash_profile")
  Command.run_shell("echo '#{coloring}' >> ~/.bash_profile")
  Command.run_shell("source ~/.bash_profile")

  provision_on $config
end

