#!/usr/bin/env bash
set -e
echo "🔄 Actualizando Flake"
nix flake update --flake /etc/nixos
echo "🚀 Aplicando cambios"
sudo nixos-rebuild switch --flake /etc/nixos#nixos
echo "📦 Haciendo commit y push"
git add /etc/nixos
git commit -m "Update config $(date '+%Y-%m-%d %H:%M:%S')"
git push
