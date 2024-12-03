#!/bin/sh

echo "Setting up primary server 1"
k3sup install --host 192.168.66.21 \
  --user vulfadmin \
  --ssh-key ~/.ssh/id_ed25519_github \
  --cluster \
  --local-path $HOME/.kube/config \
  --merge \
  --context homelab \
  --k3s-channel stable \
  --k3s-extra-args "--disable servicelb --disable traefik"

echo "Fetching the server's node-token into memory"

export NODE_TOKEN=$(k3sup node-token --host 192.168.66.21 --ssh-key ~/.ssh/id_ed25519_github --user vulfadmin)

echo "Setting up additional server: 2"
k3sup join \
  --host 192.168.66.22 \
  --ssh-key ~/.ssh/id_ed25519_github \
  --server-host 192.168.66.21 \
  --server \
  --node-token "$NODE_TOKEN" \
  --user vulfadmin \
  --k3s-channel stable \
  --k3s-extra-args "--disable servicelb --disable traefik"

echo "Setting up additional server: 3"
k3sup join \
  --host 192.168.66.23 \
  --ssh-key ~/.ssh/id_ed25519_github \
  --server-host 192.168.66.21 \
  --server \
  --node-token "$NODE_TOKEN" \
  --user vulfadmin \
  --k3s-channel stable \
  --k3s-extra-args "--disable servicelb --disable traefik"

echo "Setting up worker: 1"
k3sup join \
  --host 192.168.66.24 \
  --ssh-key ~/.ssh/id_ed25519_github \
  --server-host 192.168.66.21 \
  --node-token "$NODE_TOKEN" \
  --k3s-channel stable \
  --user vulfadmin

echo "Setting up worker: 2"
k3sup join \
  --host 192.168.66.25 \
  --ssh-key ~/.ssh/id_ed25519_github \
  --server-host 192.168.66.21 \
  --node-token "$NODE_TOKEN" \
  --k3s-channel stable \
  --user vulfadmin

echo "Setting up worker: 3"
k3sup join \
  --host 192.168.66.26 \
  --ssh-key ~/.ssh/id_ed25519_github \
  --server-host 192.168.66.21 \
  --node-token "$NODE_TOKEN" \
  --k3s-channel stable \
  --user vulfadmin
