# Create agent-file if not already created
if [ ! -f $HOME/.ssh/.ssh-agent-thing ]; then
        touch $HOME/.ssh/.ssh-agent-thing
fi

# Write the Output of ssh-agent to the File
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > $HOME/.ssh/.ssh-agent-thing
fi

# eval output
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<$HOME/.ssh/.ssh-agent-thing)"
fi
