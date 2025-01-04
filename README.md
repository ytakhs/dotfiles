# dotfiles

## Usage

### Install Nix & Home Manager

https://determinate.systems/posts/determinate-nix-installer/

```sh
# Install the Determinate Nix installer
$ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Add the Home Manager channel
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

# Update the channels
$ nix-channel --update

# Install Home Manager
$ nix-shell '<home-manager>' -A install
```

### Set up

```sh
# if needed
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

```sh
$ make switch
# or
$ make switch-dyn
```

```sh
$ sudo sh -c "echo $(which zsh) >> /etc/shells"
$ sudo chsh -s $(which zsh)
```
