#!/bin/bash

# --- Helper Functions ---

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check for NVIDIA GPU
has_nvidia_gpu() {
    lspci -k | grep -A 2 -E "(VGA|3D)" | grep -i nvidia > /dev/null
}

# --- Installation Functions ---

# Function to install yay AUR helper
install_yay() {
    if ! command_exists "yay"; then
        echo "Installing yay AUR helper..."
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ..
        rm -rf yay
    fi
}

# Function to install packages using pacman
install_pacman_packages() {
    local packages=(
        "hyprland"
        "hyprpaper"
        "hyprpicker"
        "hyprshot"
        "hypridle"
        "hyprlock"
        "kitty"
        "rofi"
        "waybar"
        "mako"
        "dolphin"
        "polkit-gnome"
        "network-manager-applet"
        "networkmanager"
        "xdg-desktop-portal-hyprland"
        "git"
        "neovim"
        "stow"
        "lazygit"
        "btop"
        "pipewire"
        "wireplumber"
        "pipewire-pulse"
        "pavucontrol"
        "wpctl"
        "brightnessctl"
        "ttf-jetbrains-mono"
        "noto-fonts"
        "noto-fonts-emoji"
        "ttf-font-awesome"
        "jq"
        "grim"
        "slurp"
        "sddm"
        "sddm-breeze" # Added for the default theme
    )

    echo "Installing required packages from official repositories..."
    sudo pacman -S --needed --noconfirm "${packages[@]}"
}

# Function to install packages from AUR using yay
install_aur_packages() {
    local packages=(
        "brave-bin"
    )

    echo "Installing required packages from AUR..."
    yay -S --needed --noconfirm "${packages[@]}"
}

# Function to install NVIDIA drivers and configure environment
install_nvidia_drivers() {
    if has_nvidia_gpu; then
        echo "NVIDIA GPU detected."
        read -p "Do you want to install NVIDIA drivers? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Installing NVIDIA drivers..."
            sudo pacman -S --needed --noconfirm nvidia nvidia-utils lib32-nvidia-utils
            setup_nvidia_environment
        fi
    fi
}

# --- Configuration Functions ---

# Function to setup general Wayland environment variables
setup_environment_variables() {
    echo "Setting up Wayland environment variables..."
    if ! grep -q "XDG_SESSION_TYPE" ~/.profile;
    then
        echo "Adding Wayland environment variables to ~/.profile"
        cat <<EOT >> ~/.profile

# Wayland environment variables
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export MOZ_ENABLE_WAYLAND=1
EOT
    else
        echo "Wayland environment variables already exist in ~/.profile"
    fi
}

# Function to setup NVIDIA-specific environment variables and kernel parameters
setup_nvidia_environment() {
    echo "Setting up NVIDIA environment variables..."
    if ! grep -q "LIBVA_DRIVER_NAME=nvidia" ~/.profile;
    then
        echo "Adding NVIDIA environment variables to ~/.profile"
        cat <<'EOT' >> ~/.profile

# NVIDIA Wayland environment variables
export LIBVA_DRIVER_NAME=nvidia
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1
EOT
    else
        echo "NVIDIA environment variables already exist in ~/.profile"
    fi

    echo "Configuring kernel parameters for NVIDIA..."
    if ! sudo grep -q "nvidia-drm.modeset=1" /etc/default/grub;
    then
        sudo sed -i.bak 's/GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 nvidia-drm.modeset=1"/' /etc/default/grub
        echo "GRUB configuration updated. Regenerating grub.cfg..."
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    else
        echo "NVIDIA kernel parameter already set in GRUB."
    fi
}

# Function to create hyprland.desktop file for display managers
create_hyprland_desktop_file() {
    echo "Creating hyprland.desktop file..."
    if [ ! -f /usr/share/wayland-sessions/hyprland.desktop ]; then
        sudo mkdir -p /usr/share/wayland-sessions
        sudo tee /usr/share/wayland-sessions/hyprland.desktop > /dev/null <<EOT
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOT
        echo "hyprland.desktop created."
    else
        echo "hyprland.desktop already exists."
    fi
}

# Function to configure SDDM for Wayland and set a default theme
configure_sddm() {
    echo "Configuring SDDM..."
    sudo mkdir -p /etc/sddm.conf.d
    if [ ! -f /etc/sddm.conf.d/wayland.conf ]; then
        sudo tee /etc/sddm.conf.d/wayland.conf > /dev/null <<EOT
[General]
DisplayServer=wayland
EOT
        echo "SDDM configured to use Wayland."
    else
        echo "SDDM Wayland configuration already exists."
    fi

    if [ ! -f /etc/sddm.conf.d/theme.conf ]; then
        sudo tee /etc/sddm.conf.d/theme.conf > /dev/null <<EOT
[Theme]
Current=breeze
EOT
        echo "SDDM theme set to breeze."
    else
        echo "SDDM theme configuration already exists."
    fi
}

# Function to enable critical system services
enable_system_services() {
    echo "Enabling system services..."
    sudo systemctl enable --now NetworkManager
    sudo systemctl enable sddm
}

# Function to enable user-level audio services
enable_user_services() {
    echo "Enabling user audio services..."
    systemctl --user enable --now pipewire pipewire-pulse wireplumber
}

# Function to setup fallback to start Hyprland automatically on TTY1
setup_tty_fallback() {
    echo "Setting up TTY1 fallback for Hyprland..."
    if ! grep -q "exec Hyprland" ~/.bash_profile;
    then
        echo "Adding TTY1 fallback to ~/.bash_profile"
        cat <<'EOT' >> ~/.bash_profile

if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec Hyprland
fi
EOT
    else
        echo "TTY1 fallback already configured in ~/.bash_profile"
    fi
}

# Function to create symbolic links for dotfiles
create_symlinks() {
    echo "Creating symbolic links for dotfiles..."
    stow -vSt ~ .
}

# Function to make scripts executable
make_scripts_executable() {
    echo "Making scripts executable..."
    chmod +x .local/bin/hello
    chmod +x .local/bin/xdgportal.sh
    chmod +x .config/rofi/applets/bin/*.sh
    chmod +x .config/rofi/launchers/type-1/launcher.sh
    chmod +x .config/rofi/powermenu/type-1/powermenu.sh
    chmod +x .config/hypr/scripts/rofi-wifi-menu/rofi-wifi-menu.sh
}

# --- Main Execution ---

main() {
    echo "Starting Hyprland Desktop Environment Setup..."

    # Package management
    install_yay
    install_pacman_packages
    install_aur_packages
    install_nvidia_drivers

    # System and session configuration
    setup_environment_variables
    create_hyprland_desktop_file
    configure_sddm
    setup_tty_fallback

    # Dotfiles and scripts
    create_symlinks
    make_scripts_executable

    # Enable services
    enable_system_services
    enable_user_services

    echo -e "\nInstallation complete!"
    echo "It is highly recommended to reboot your system for all changes to take effect."
}

main
