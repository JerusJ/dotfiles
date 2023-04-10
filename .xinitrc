# https://gist.github.com/mlabbe/966bbe9fe46fd4ee74037e2e8acb2969
# launch emacs as daemon after X session starts but
# before i3 "exec" commands run from its config
/usr/local/bin/emacs --daemon
exec i3
