# dotfiles

- This is a collection of dotfiles (configuration files) I use on my personal computers.
- Clone this repo to your home directory, then setup in one of the following ways:
  - **Method 1**: Manual
    - Symlink each file to the correct location using `ln -s <src> <destination>`
  - **Method 2**: Automatic _[ABANDONED]_
    - curl and execute `dotfiles/install.sh`. This will clone the repository
      to your local machine, then execute any scripts in `dotfiles/setup_scripts/*.sh`.
  - Method 3: Ansible \*[WIP]
    - I am currently working on an Ansible playbook to automate the setup of my dotfiles.
    - Requirements:
      - Install ansible-core: [Install](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pip)
      - Install ansible community plugins (to get homebrew): `ansible-galaxy collection install community.general`
