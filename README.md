# DevOps Portfolio – ICT171 Cloud Project

## Website Details
- **Name:** James Morrison
- **Student Number:** 33179074
- **Domain:** [https://www.ict171morrison.net/]
- **Server Type:** Apache on Ubuntu (EC2)
- **SSL:** Enabled using Let's Encrypt and Certbot
- **Repo:** [https://github.com/James-M99/DevOps_Portfolio.git]

This project showcases a personal DevOps portfolio website. It demonstrates the setup and deployment of a cloud-based web server using Infrastructure-as-a-Service (IaaS), which is hosted on **Amazon EC2**. The website showcases a personal DevOps portfolio with integrated custom scripts, version control, DNS configuration, SSL/TLS setup, and automation via Shell scripting

## Website Structure
The website is hosted at [https://www.ict171morrison.net/] and contains the following pages:
- index.html -> The home page with a small introduction of myself
- projects.html -> A description of my project and the scripts I produced for it
- contact.html -> A page dedicated to my contact information
- styles.css -> A custom styling page for formatting the website

## Repository Structure
DevOps_Portfolio/
├── html/
│ ├── index.html
│ ├── contact.html
│ ├── projects.html
│ └── styles.css
├── scripts/
│ ├── update.sh
│ ├── deploy.sh
│ ├── backup.sh
│ ├── healthcheck.sh
│ ├── status.sh
│ └── tag-test.sh
├── README.md
└── VERSION.txt
