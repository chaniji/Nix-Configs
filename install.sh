#!/bin/bash
set -e
echo "===================================="
echo " Debian Nix Setup Script"
echo "===================================="

# Step 1 - Install dependencies
echo "[1/12] Installing apt dependencies..."
sudo apt update
sudo apt install -y xz-utils alacritty git curl fontconfig zstd

# Step 2 - Install Nix
echo "[2/12] Installing Nix..."
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Step 3 - Reload Nix environment
echo "[3/12] Loading Nix environment..."
source ~/.bashrc
source ~/.nix-profile/etc/profile.d/nix.sh

# Step 4 - Enable experimental features
echo "[4/12] Enabling Nix flakes and commands..."
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Step 5 - Install Home Manager
echo "[5/12] Installing Home Manager..."
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# Step 6 - Install Zed
echo "[6/12] Installing Zed editor..."
curl -f https://zed.dev/install.sh | sh

# Step 7 - Install Nerd Fonts
echo "[7/12] Installing Nerd Fonts..."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"
fc-cache -fv

# Step 8 - Install Ollama
echo "[8/12] Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# Step 9 - Install LazyVim
echo "[9/12] Installing LazyVim..."
if [ -d ~/.config/nvim ]; then
  mv ~/.config/nvim ~/.config/nvim.bak
fi
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Step 10 - Clone config repo
echo "[10/12] Cloning Nix configs..."
if [ -d ~/Nix-Configs ]; then
  echo "Repo already exists, pulling latest..."
  cd ~/Nix-Configs
  git pull
else
  git clone https://github.com/chaniji/Nix-Configs.git ~/Nix-Configs
fi

# Step 11 - Copy configs
echo "[11/12] Copying configs..."
mkdir -p ~/.config/home-manager
mkdir -p ~/.config/alacritty
cp -r ~/Nix-Configs/home-manager/* ~/.config/home-manager/
#cp -r ~/Nix-Configs/alacritty/* ~/.config/alacritty/

# Step 12 - Purge apt git + apply home-manager
echo "[12/12] Purging apt git and applying Home Manager..."
sudo apt purge git -y
source ~/.nix-profile/etc/profile.d/nix.sh
home-manager switch

echo "===================================="
echo " Setup Complete!"
echo "===================================="
echo " Run: source ~/.bashrc"
echo "===================================="
