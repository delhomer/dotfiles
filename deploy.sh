#!/bin/bash

DOTFILE_REPO=${HOME}/dotfiles

echo "Linking bash files"
rm ${HOME}/.bash_aliases
ln -s ${DOTFILE_REPO}/bash/.aliases ${HOME}/.bash_aliases
rm ${HOME}/.bash_functions
ln -s ${DOTFILE_REPO}/bash/.functions ${HOME}/.bash_functions
rm ${HOME}/.bashrc
ln -s ${DOTFILE_REPO}/bash/.bashrc ${HOME}/.bashrc
echo "source new .bashrc file"
source ${HOME}/.bashrc

echo "Linking emacs files"
rm ${HOME}/.emacs
ln -s ${DOTFILE_REPO}/emacs/.emacs ${HOME}/.emacs

echo "Linking git files"
rm ${HOME}/.gitattributes
rm ${HOME}/.gitconfig
ln -s ${DOTFILE_REPO}/git/.gitattributes ${HOME}/.gitattributes
cp ${DOTFILE_REPO}/git/.gitconfig ${HOME}/.gitconfig

echo "Linking PGcli files"
rm ${HOME}/.config/pgcli/config
ln -s ${DOTFILE_REPO}/pgcli/config ${HOME}/.config/pgcli/config

echo "Linking ssh files"
rm ${HOME}/.ssh/rc
ln -s ${DOTFILE_REPO}/ssh/rc ${HOME}/.ssh/rc

echo "Linking GNUPG files"
rm ${HOME}/.gnupg/gpg-agent.conf
ln -s ${DOTFILE_REPO}/gnupg/gpg-agent.conf ${HOME}/.gnupg/gpg-agent.conf
