#!/bin/bash
set -e
echo "===================================="
echo " Debian Nix Setup Script"
echo "===================================="

# Step 1 - Install dependencies
echo "[1/9] Installing apt dependencies..."
sudo apt update
sudo apt install -y xz-utils alacritty git curl

# Step 2 - Install Nix
echo "[2/9] Installing Nix..."
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Step 3 - Reload Nix environment
echo "[3/9] Loading Nix environment..."
source ~/.bashrc
source ~/.nix-profile/etc/profile.d/nix.sh

# Step 4 - Enable experimental features
echo "[4/9] Enabling Nix flakes and commands..."
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Step 5 - Install Home Manager
echo "[5/9] Installing Home Manager..."
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# Step 6 - Install Zed
echo "[6/9] Installing Zed editor..."
curl -f https://zed.dev/install.sh | sh

# Step 7 - Clone config repo
echo "[7/9] Cloning Nix configs..."
if [ -d ~/Nix-Configs ]; then
  echo "Repo already exists, pulling latest..."
  cd ~/Nix-Configs
  git pull
else
  git clone https://github.com/chaniji/Nix-Configs.git ~/Nix-Configs
fi

# Step 8 - Copy configs
echo "[8/9] Copying configs..."
mkdir -p ~/.config/home-manager
mkdir -p ~/.config/alacritty
cp -r ~/Nix-Configs/home-manager/* ~/.config/home-manager/
#cp -r ~/Nix-Configs/alacritty/* ~/.config/alacritty/

# Step 9 - Purge apt git + apply home-manager
echo "[9/9] Purging apt git and applying Home Manager..."
sudo apt purge git -y
source ~/.nix-profile/etc/profile.d/nix.sh
home-manager switch

echo "===================================="
echo " Setup Complete!"
echo "===================================="
echo " Run: source ~/.bashrc"
echo "===================================="
