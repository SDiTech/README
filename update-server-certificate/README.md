# Process for updating proxied certificates on cloud droplet

1. Go to Cloudflare dashboard select the website URL and turn on Development Mode.
2. Go to the domain registrar (Namecheap) and under DNS switch from Custom DNS to Namecheap Basic DNS, then go to the Advanced DNS section and add one single "A"-type record. Enter @ as the host and provide the IP Address of the remote machine.
3. Then login as the root user of your remote machine and disable the firewall:

```bash
systemctl stop ufw
```

4. Using certbot run the following command to test if there are any issues:

```bash
certbot certonly --standalone -v -d --dry-run domain.tld
```

If there are no issues then run the following command:

```bash
certbot certonly --standalone -v -d domain.tld

# or

certbot certonly --standalone -d example.com --staple-ocsp -m me@example.com --agree-tos  
```

5. Then reactivate the firewall:

```bash
systemctl start ufw
```

6. Move the certificate and key to their respective directory. Verify that the nginx default.conf reflects the correct certificate and key names.

7. After that, go back to Namecheap, reactivate custom DNS, and enter the Cloudflare DNS proxies. Go back to Cloudflare and deactivate developer mode.

8. Congratulate yourself and take pride in owning this document.