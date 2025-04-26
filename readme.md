# CK Technology Headscale Setup
---
<p align="center">
  <img src="https://img.shields.io/badge/Headscale-Control_Server-2aa198"/> &nbsp;&nbsp;
  <img src="https://img.shields.io/badge/DERP-Relay_Map-blue"/> &nbsp;&nbsp;
  <img src="https://img.shields.io/badge/WireGuard-VPN-88171a?logo=wireguard&logoColor=white"/> &nbsp;&nbsp;
  <img src="https://img.shields.io/badge/NGINX-Reverse_Proxy-009639?logo=nginx&logoColor=white"/> &nbsp;&nbsp;
  <img src="https://img.shields.io/badge/Optimized-⚡🚀🔒-00bcd4"/>
</p>

---

> 🛠️ **About this repository:**  
> Self-hosted control server configuration for Tailscale-compatible networks using Headscale, WireGuard fallback VPNs, custom DERP relays, and NGINX reverse proxy management.

---
## 📁 Included Files

| File                 | Description                                                 |
|----------------------|-------------------------------------------------------------|
| `config.yaml`        | Primary Headscale configuration (excluding secrets)         |
| `headplane.yaml`     | Headplane (Web UI) configuration for managing Headscale     |
| `derp-map.yaml`      | Custom DERP map for enabling CKTechX relay                  |
| `key.txt` (excluded) | Contains API key(s) for Headscale. Never commit or share.   |
| `hs-config.yaml`     | Optional alt copy of Headscale config for backup/comparison |

---

## 🛠️ Components Overview

### 🔹 Headscale (`config.yaml`)
- OIDC login via Microsoft Entra (Azure)
- API key auth enabled
- DERP map enabled and embedded from `derp-map.yaml`
- Listening on:
  - `:8080` (Headscale API)
  - `:9090` (Debug/metrics)

### 🔹 Headplane (`headplane.yaml`)
- Connects to local Headscale instance
- Uses `https://hs.cktechx.com` with SSO + API support
- Auth backed by same Azure OIDC client
- Restricted to domain: `cktechx.com`

### 🔹 DERP Relay (`derp-map.yaml`)
- Custom fallback relay `relay.cktechx.com` @ `198.96.95.69`
- Region: `relay`
- Auto-updates every 24h
- Clients will only use this if UDP fails or NAT traversal is blocked

---

## 🔐 Secrets

Sensitive items like:
- OIDC `client_id`, `client_secret`
- `headscale_api_key`
- `derper_private_key`

Are stored **outside of versioned files** in:
- `~/headscale/key.txt` (example placeholder)
- `/var/lib/headscale/*.key` (mounted into container)
- Azure Entra application (for OIDC)

---

## 🧪 Testing Tips

### DERP Fallback Test
From a test client:
```bash
tailscale netcheck
