#!/bin/bash

set -o errexit -o pipefail -o nounset

echo "Setting up ssh"

mkdir -p /root/.ssh

ssh-keyscan -v -t ed25519 aur.archlinux.org >> /root/.ssh/known_hosts

cp ssh_config /root/.ssh

echo -e "${SSH_PRIVATE_KEY//_/\\n}" > /root/.ssh/aur

chmod -vR 600 /root/.ssh/aur*

ssh-keygen -vy -f /root/.ssh/aur > /root/.ssh/aur.pub

sha512sum /root/.ssh/aur /root/.ssh/aur.pub

echo "Test ssh"
ssh -Tv aur@aur.archlinux.org

echo "Setting up git"
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"
