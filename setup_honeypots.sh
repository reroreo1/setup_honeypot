#!/bin/bash

# Update and upgrade the system
sudo apt-get update -y
#sudo apt-get upgrade -y

# Install Python3 and pip
sudo apt-get install python3 python3-pip -y

# Install the honeypots package using pip
sudo pip3 install honeypots

# Create config.json file
cat <<EOF > config.json
{
    "logs": "db_postgres,terminal",
    "logs_location": "",
    "syslog_address": "",
    "syslog_facility": 0,
    "postgres": "//cyber_admin:Admin123!@cybernews.postgres.database.azure.com:5432/honeypots",
    "sqlite_file": "",
    "db_options": ["drop"],
    "sniffer_filter": "",
    "sniffer_interface": "",
    "honeypots": {
        "ftp": {
            "port": 21,
            "username": "test",
            "password": "test"
        },
        "dhcp": {
            "port": 67
        },
        "elastic": {
            "port": 9200
        },
        "httpproxy": {
            "port": 8080
        },
        "https": {
            "port": 443
        },
        "http": {
            "port": 80
        },
        "imap": {
            "port": 143
        },
        "ipp": {
            "port": 631
        },
        "irc": {
            "port": 6667
        },
        "ldap": {
            "port": 389
        },
        "mssql": {
            "port": 1433
        },
        "memcache": {
            "port": 11211
        },
        "mysql": {
            "port": 3306
        },
        "ntp": {
            "port": 123
        },
        "oracle": {
            "port": 1521
        },
        "pjl": {
            "port": 9100
        },
        "pop3": {
            "port": 110
        },
        "postgres": {
            "port": 5432
        },
        "rdp": {
            "port": 3389
        },
        "redis": {
            "port": 6379
        },
        "sip": {
            "port": 5060
        },
        "smb": {
            "port": 445
        },
        "smtp": {
            "port": 25
        },
        "snmp": {
            "port": 161
        },
        "socks5": {
            "port": 1080
        },
        "ssh": {
            "port": 45451,
            "username": "root",
            "password": "root"
        },
        "telnet": {
            "port": 23,
            "username": "admin",
            "password": "admin"
        },
        "vnc": {
            "port": 5900
        }
    }
}
EOF

# Modify SSH configuration to allow both ports 22 and 3333
sudo sed -i '/^#Port 22/c\Port 22\nPort 3333' /etc/ssh/sshd_config

# Restart SSH service to apply changes
sudo systemctl restart sshd

# Run honeypots setup command with the config.json file
sudo -E python3 -m honeypots --setup all --config config.json

# Indicate that the setup is complete
echo "Honeypots setup complete! SSH configured for ports 22 and 3333."
