Linking VSCode Configuration
============================

TODO: Move from .vscode/* in Git to Linux native path (only link on Mac and Windows)

Linux
-----
ln -s ~/.vscode/settings.json $HOME/.config/Code/User/settings.json
ln -s ~/.vscode/keybindings.json $HOME/.config/Code/User/settings.json
ln -s ~/.vscode/snippets $HOME/.config/Code/User/settings.json

macOS
-----
ln -s ~/.vscode/settings.json $HOME/Library/Application Support/Code/User/settings.json
ln -s ~/.vscode/keybindings.json $HOME/Library/Application Support/Code/User/keybindings.json
ln -s ~/.vscode/snippets $HOME/Library/Application Support/Code/User/snippets

Cygwin
------
mklink C:\Users\XXX\AppData\Roaming\Code\User\settings.json C:\cygwin64\home\XXX\.vscode\settings.json
mklink C:\Users\XXX\AppData\Roaming\Code\User\keybindings.json C:\cygwin64\home\XXX\.vscode\keybindings.json
mklink /D C:\Users\XXX\AppData\Roaming\Code\User\snippets C:\cygwin64\home\XXX\.vscode\snippets
