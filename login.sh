if [ -n "$SSH_PRIVATE_KEY" ]
then
    mkdir -p ~/.ssh
    echo "${SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa
    chmod 400 ~/.ssh/id_rsa
    ssh-keyscan github.com >> ~/.ssh/known_hosts
    ssh -T git@github.com
    git config --global url."git@github.com:".insteadOf "https://github.com"
fi