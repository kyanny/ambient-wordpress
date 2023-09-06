#!/usr/bin/zsh
FEATURE_DIR=$(dirname $0)

export DEBIAN_FRONTEND=noninteractive
apt-get update \
  && apt-get -y install --no-install-recommends build-essential \
  make \
  python3-pip \
  tree \
  jq

pip3 install --upgrade pip
pip3 install git-remote-codecommit aws-mfa aws-export-credentials pytest-testinfra pipenv


RUN curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -so /usr/local/bin/gibo && chmod +x /usr/local/bin/gibo && gibo update

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${_REMOTE_USER_HOME}/.zprezto"

VSC_HOME=/home/vscode
if [ -e $VSC_HOME/.zshrc ]; then
  unlink $VSC_HOME/.zshrc
fi
if [ -e $VSC_HOME/.zlogin ]; then
  unlink $VSC_HOME/.zlogin
fi
if [ -e $VSC_HOME/.zlogout ]; then
  unlink $VSC_HOME/.zlogout
fi
if [ -e $VSC_HOME/.zpreztorc ]; then
  unlink $VSC_HOME/.zpreztorc
fi
if [ -e $VSC_HOME/.zprofile ]; then
  unlink $VSC_HOME/.zprofile
fi
if [ -e $VSC_HOME/.zshenv ]; then
  unlink $VSC_HOME/.zshenv
fi

setopt EXTENDED_GLOB
for rcfile in "$VSC_HOME"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "$VSC_HOME/.${rcfile:t}"
done

sudo chown -R vscode:vscode $_REMOTE_USER_HOME/.zprezto
install -m 755 -o vscode -g vscode $FEATURE_DIR/zprezto/runcoms/* $_REMOTE_USER_HOME/.zprezto/runcoms
install -m 755 -o vscode -g vscode -d /tmp/vscode-code-zsh

git clone https://github.com/pyenv/pyenv.git $_REMOTE_USER_HOME/.pyenv
cd $_REMOTE_USER_HOME/.pyenv && git checkout v2.0.3 && chown -R vscode:vscode $_REMOTE_USER_HOME/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $_REMOTE_USER_HOME/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $_REMOTE_USER_HOME/.zshrc
echo 'eval "$(pyenv init --path)"' >> $_REMOTE_USER_HOME/.zshrc
echo "autoload -Uz compinit && compinit" >> $_REMOTE_USER_HOME/.zshrc
echo "autoload -U bashcompinit && bashcompinit" >> $_REMOTE_USER_HOME/.zshrc
echo "complete -C '/usr/local/bin/aws_completer' aws" >> $_REMOTE_USER_HOME/.zshrc