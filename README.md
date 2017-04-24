Overview
--------
These are the dotfiles used for my personal setup, for both home and work,
across Linux (Ubuntu), macOS, and Cygwin on Windows. Some of the
customizations are specifically to accommodate differences between these
environments and to allow for machine-specific customization (e.g.
work-specific changes for proxy, etc.).

Screenshot
----------
TBD

Setup Checklist
---------------
* Install prerequisites: Cygwin, Vim, Python, mintty, Git, ...

* Manually configure proxies (if needed):
        
        export http_proxy = PROXY_URL
        export https_proxy = PROXY_URL

* Run setup script:

        wget -O - https://raw.githubusercontent.com/lucasf98/dotfiles/master/setup_dotfiles.sh | /bin/bash

* Install Vundle: 

        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

* Install Powerline Fonts:

        git clone https://github.com/powerline/fonts.git

* Other Installs:

        pip install --upgrade pip
        pip install cookiecutter
        pip install virtualenv

