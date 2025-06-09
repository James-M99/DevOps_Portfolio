# DevOps Portfolio – ICT171 Cloud Project

## Website Details
- **Name:** James Morrison
- **Student Number:** 33179074
- **Domain:** [https://www.ict171morrison.net/]
- **Server Type:** Apache on Ubuntu (EC2)
- **SSL:** Enabled using Let's Encrypt and Certbot
- **Repo:** [https://github.com/James-M99/DevOps_Portfolio.git]
- **Video Explainer:** [insert video explainer HERE]

This project showcases a personal DevOps portfolio website. It demonstrates the setup and deployment of a cloud-based web server using Infrastructure-as-a-Service (IaaS), which is hosted on **Amazon EC2**. The website showcases a personal DevOps portfolio with integrated custom scripts, DNS configuration, SSL/TLS setup, and automation via Shell scripting

## Website Structure
The website is hosted at [https://www.ict171morrison.net/] and contains the following pages:
- index.html -> The home page with a small introduction of myself
- projects.html -> A description of my project and the scripts I produced for it
- contact.html -> A page dedicated to my contact information
- styles.css -> A custom styling page for formatting the website

## Repository Structure
DevOps_Portfolio/
- ├── html/
- │ ├── index.html
- │ ├── contact.html
- │ ├── projects.html
- │ └── styles.css
- ├── scripts/
- │ ├── update.sh
- │ ├── deploy.sh
- │ ├── backup.sh
- │ ├── healthcheck.sh
- │ ├── status.sh
- │ └── tag-test.sh
- ├── README.md
- └── VERSION.txt

## Key Features
- **Website Hosting** -> Deployed to an EC2 Ubuntu instance using Apache
- **DNS + SSL** -> Domain registered via *godaddy.com* and secured with *Let's Encrypt TLS*
- **Custom Shell Scripts:**
-   - update.sh -> Pulls GitHub repo, backs up, redeploys, sets permissions
    - backup.sh -> Compresses and stores the current site as a timestamped backup
    - deploy.sh -> Handles fresh deployment from the GitHub repo
    - healthcheck.sh -> Checks HTTP response for site uptime
    - status.sh -> Displays system uptime, disk, and memory usage
    - tag-test.sh -> Debugging script I used to test GitHub tagging
- **Automation** -> Scripts are linked to '/usr/local/bin' for global CLI access
- **Security** -> HTTPS enabled, sensitive permissions set
- **VPN Integration** -> A fully functional *WireGuard VPN* running on the same instance as the website.

## How to deploy
1. Clone this repository with:
   sudo git clone https://github.com/James-M99/DevOps_Portfolio.git
2. Run the update script with root privileges:
   1. cd DevOps_Portfolio
   1. sudo chmod +x ./scripts/update.sh
   2. sudo ./scripts/update.sh
4. All other scripts are symlinked to '/usr/local/bin' and can be used anywhere.

## VPN Integration
The VPN allows secure, encrypted access to the internal network environment via a custom client configuration using *WireGuard* (https://www.wireguard.com/)

### Setup Summary
- VPN Type: WireGuard (lightweight, fast, secure)
- Server IP: 10.0.0.1/24
- Port: 51820/UDP
- Cloud Provider: AWS EC2 (Ubuntu)
- Firewall: UFW Configured, AWS security group allows UDP 51820

### Server Configuration
Configuration file: /etc/wireguard/wg0.conf
<pre>
    <code>
        [Interface]
        PrivateKey = server-private-key
        Address = 10.0.0.1/24
        ListenPort = 51820

        [Peer]
        PublicKey = <client-public-key>
        AllowedIPs = 10.0.0.2/32
    </code>
</pre>

### Client Configuration (Example)
<pre>
    <code>
        [Interface]
        PrivateKey = client-private-key
        Address = 10.0.0.2/32
        DNS = 1.1.1.1


        [Peer]
        PublicKey = server-public-key
        Endpoint = 52.64.27.54:51820
        AllowedIPs = 0.0.0.0/0, ::/0
        PersistentKeepalive = 25
    </code>
</pre>

You can also generate a qr code for this config using:
qrencode -t ansiutf8 < client.conf

### Status Verification
To check the VPN status:
<pre>
    <code>
        sudo systemctl status wg-quick@wg0
        sudo wg
    </code>
</pre>

Where a successful output shows:
- Latest handshake timestamp
- Transfer statistics
- Peer IPs and keys

### Security Notes
- Keys are stored:
- - /etc/wireguard/server_private.key
  - /etc/wireguard/server_public.key
- Firewall (UFW and AWS Security Group) allows port 51820/UDP
- Only trusted clients should be added as peers
