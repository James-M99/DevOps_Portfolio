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
- **DNS + SSL** -> Domain registered via godaddy.com and secured with Let's Encrypt TLS
- **Custom Shell Scripts:**
-   - update.sh -> Pulls GitHub repo, backs up, redeploys, sets permissions
    - backup.sh -> Compresses and stores the current site as a timestamped backup
    - deploy.sh -> Handles fresh deployment from the GitHub repo
    - healthcheck.sh -> Checks HTTP response for site uptime
    - status.sh -> Displays system uptime, disk, and memory usage
    - tag-test.sh -> Debugging script I used to test GitHub tagging
- **Automation** -> Scripts are linked to '/usr/local/bin' for global CLI access
- **Security** -> HTTPS enabled, sensitive permissions set

## How to deploy
1. Clone this repository with:
   sudo git clone https://github.com/James-M99/DevOps_Portfolio.git
2. Run the update script with root privileges:
   1. sudo chmod +x ./scripts/update.sh
   2. sudo ./scripts/update.sh
3. All other scripts are symlinked to '/usr/local/bin' and can be used anywhere.
