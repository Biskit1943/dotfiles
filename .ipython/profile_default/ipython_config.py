# Enable the Powerline prompt
#from powerline.bindings.ipython.since_5 import PowerlinePrompts
c = get_config()
#c.TerminalInteractiveShell.simple_prompt = False
#c.TerminalInteractiveShell.prompts_class = PowerlinePrompts

## Shortcut style to use at the prompt. 'vi' or 'emacs'.
c.TerminalInteractiveShell.editing_mode = 'vi'

## Set the editor used by IPython (default to $EDITOR/vi/notepad).
c.TerminalInteractiveShell.editor = 'nvim'

# c.TerminalInteractiveShell.highlighting_style = 'monokai'
