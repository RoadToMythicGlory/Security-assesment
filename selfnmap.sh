#!/bin/bash

# Define variables for common commands
APT_GET_UPDATE="sudo apt-get update"
APT_GET_UPGRADE="sudo apt-get upgrade -y"

# Define a function to update the operating system and applications
update_system() {
  echo "Updating the operating system and applications..."
  $APT_GET_UPDATE
  $APT_GET_UPGRADE
}

# Define a function to install and configure the firewall
install_firewall() {
  echo "Installing and configuring a firewall..."
  sudo apt-get install -y ufw
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw allow ssh
  sudo ufw enable
}

# Define a function to implement access controls
implement_access_controls() {
  echo "Implementing access controls..."
  sudo adduser username
  sudo usermod -aG sudo username
  sudo sed -i 's/.*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
  sudo sed -i 's/.*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
  sudo systemctl restart ssh
}

# Define a function to scan for open ports
scan_ports() {
  echo "Scanning for open ports..."
  if nmap -v -sT -O localhost > nmap_output.txt; then
    echo "Nmap scan completed successfully"
  else
    echo "Nmap scan failed"
  fi
}

# Define a function to search for exploits
search_exploits() {
  echo "Searching for exploits..."
  searchsploit -t nmap nmap_output.txt
}

# Define a function to enable logging and monitoring
enable_logging_monitoring() {
  echo "Enabling logging and monitoring..."
  sudo apt-get install -y logwatch
  sudo sed -i 's/.*Output =.*/Output = mail/' /etc/logwatch/conf/logwatch.conf
  sudo systemctl restart logwatch
  sudo apt-get install -y fail2ban
  sudo systemctl enable fail2ban
  sudo systemctl start fail2ban
  sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
  sudo sed -i 's/bantime  = 10m/bantime  = 1h/' /etc/fail2ban/jail.local
  sudo systemctl restart fail2ban
}

# Get the IP address using hostname -i command
myip=$(hostname -i)

# Display the IP address on the terminal
echo "My IP address is: $myip"

# Update the operating system and applications
update_system

# Install and configure a firewall
install_firewall

# Implement access controls
implement_access_controls

# Scan for open ports
scan_ports

# Search for exploits
search_exploits

# Enable logging and monitoring
enable_logging_monitoring
