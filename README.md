# route53_dyndns
A bash script to use Route53 as a Dynamic IP service.

### Install
Copy isip and route53_dip.sh into your path or adjust line 7 of route53_dip.sh to include this repo in the scripts path.
Adjust lines 3 and 4 of route53_dip.sh for your host/domain name
Make sure the route53 gem is installed, there are other Route53 CLIs, this one is setup for the one that comes with the ruby gem.
 - gem install route53
Make sure route53 is configured for your domain
Create the record you want to be updated by the script, it won't create one for you, only update it. Might use an address like 127.0.0.1 to make sure the update works rather than the real current address

### Notes
You can run this from a crontab, I'd recomend you set the DNS records TTL to the same as the cron interval you set, maybe a few seconds earlier
