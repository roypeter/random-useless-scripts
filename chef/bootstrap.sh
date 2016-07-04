#!/usr/bin/env bash

HOSTNAME='foo'
FQDN="${HOSTNAME}.foo.com"
IP='1.1.1.1'

chef_environment='stage'
chef_run_list='role[app]'

chef_download_url='https://packages.chef.io/stable/ubuntu/12.04/chef_12.0.3-1_amd64.deb'

validation_key_name='validation.pem'
ssl_certificate_name='CERTIFICATE.pem'

# Set hostname
hostname ${HOSTNAME}
echo ${HOSTNAME} > /etc/hostname

# Set FQDN
echo ${IP} ${FQDN} ${HOSTNAME} >> /etc/hosts


# Install chef
wget --no-check-certificate $chef_download_url
dpkg -i `echo $chef_download_url | sed 's/.*\///'`

# Directories and Files 
mkdir -p /etc/chef/ohai/hints /etc/chef/trusted_certs
touch /etc/chef/client.rb /etc/chef/$validation_key_name \
/etc/chef/trusted_certs/$ssl_certificate_name \
/etc/chef/ohai/hints/ec2.json

# client.rb file
cat > /etc/chef/client.rb << EOF
chef_server_url 'https://chef.foo.io/organizations/foo'
validation_client_name "${validation_key_name%.*}"
validation_key "/etc/chef/$validation_key_name"
EOF

# Validation key
cat > /etc/chef/$validation_key_name << EOF
-----BEGIN RSA PRIVATE KEY-----
helo world
-----END RSA PRIVATE KEY-----
EOF

# SSL CERTIFICATE
cat > /etc/chef/trusted_certs/$ssl_certificate_name << EOF
-----BEGIN CERTIFICATE-----
hello world
-----END CERTIFICATE-----
EOF

# Run chef. Update environment and runlist if successful
chef-client -E ${chef_environment} -r ${chef_run_list}
