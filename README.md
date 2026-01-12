# dotfiles

## Usage

### Install Nix

https://determinate.systems/posts/determinate-nix-installer/

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Set up

```sh
git clone https://github.com/ytakhs/dotfiles.git ~/dotfiles
cd ~/dotfiles
nix run .#switch
```

```sh
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
```

## Commands

```sh
# Apply configuration
nix run .#switch

# Update flake inputs
nix run .#flake-update
```

### Linux only

```sh
# Apply with backup
nix run .#switch-with-backup

# List generations
nix run .#generations

# Remove old generations
nix run .#expire -- "-7 days"
```
