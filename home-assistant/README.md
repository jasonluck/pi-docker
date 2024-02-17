## Reverse Proxy configuration
In order to allow home-assistant to work behind a reverse proxy, we need to add the following lines to the `config/configuration.yaml` file:
```yaml
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 172.0.0.0/8  # Allow anything in our Docker CIDR block
```
