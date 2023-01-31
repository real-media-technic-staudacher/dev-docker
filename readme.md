## Whats Inside 
- Traefik as Reverse Proxy
- Step-CA for SSL Certificates
- Mailhog for Mail Catching

## Domains

- mailhog.test

## How to use

- Clone this repo 
- Run `docker-compose up -d`

## Changes for every project

- Remove `- '${APP_PORT:-80}:80'` from your `docker-compose.yml` in Line 14 under `ports`
- Extend the `docker-compose.yml` file with the following:
  - Add it to the laravel.test service (scoop-os-container), the position doesn't matter.
  - __CUSTOMERNAME__ should be replaced with the domain prefix. Just check the `.env` for `APP_URL` and use the part
    before `-scoopos.test, e.g. "madeleine"

```yml
labels:
    - "traefik.enable=true"
    - "traefik.http.routers.__CUSTOMERNAME__.entrypoints=http"
    - "traefik.http.routers.__CUSTOMERNAME__.rule=Host(`__CUSTOMERNAME__-scoopos.test`)"
    - "traefik.http.middlewares.__CUSTOMERNAME__-https-redirect.redirectscheme.scheme=https"
    - "traefik.http.routers.__CUSTOMERNAME__.middlewares=__CUSTOMERNAME__-https-redirect"
    - "traefik.http.routers.__CUSTOMERNAME__-secure.entrypoints=https"
    - "traefik.http.routers.__CUSTOMERNAME__-secure.rule=Host(`__CUSTOMERNAME__-scoopos.test`)"
    - "traefik.http.routers.__CUSTOMERNAME__-secure.tls=true"
    - "traefik.http.routers.__CUSTOMERNAME__-secure.tls.certresolver=default"
    - "traefik.http.routers.__CUSTOMERNAME__-secure.service=__CUSTOMERNAME__"
    - "traefik.http.services.__CUSTOMERNAME__.loadbalancer.server.port=80"
    - "traefik.docker.network=staudacher-proxy"
```

- Extend the network on the given service (laravel.test). Just add `staudacher-proxy` after sail as a
  second entry.
```yml 
networks:
     staudacher-proxy:
          external: true
```

- Extend the `networks` (around L107) section of the `docker-compose.yml` with the following:

```yml
staudacher-proxy:
   external: true
```

- Change in your `.env` `APP_URL` from `http` to `https`

## Errors

### 1. Not logged in
```
Get "https://registry-1.docker.io/v2/library/traefik/manifests/sha256:34b641ad523cd22a83afc174a6b013686be7abc8684c6ebfa4618b8bcaa7e831": dialing registry-1.docker.io:443 static system has no HTTPS proxy: connecting to 34.194.164.123:443: dial tcp 34.194.164.123:443: i/o timeout
```
You need an accout on https://hub.docker.com/ and login to `docker desktop`.

### 2. Firewall problem
```
Error response from daemon: Head "https://registry-1.docker.io/v2/library/traefik/manifests/v2.9": dialing registry-1.docker.io:443 static system has no HTTPS proxy: connecting to 34.194.164.123:443: dial tcp 34.194.164.123:443: i/o timeout
```
Try changing your DNS to 8.8.8.8.