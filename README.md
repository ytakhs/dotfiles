dotfiles
===

## Usage

### Install Nix

https://determinate.systems/posts/determinate-nix-installer/

```sh
$ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
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
