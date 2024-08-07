## Whats Inside 
- Traefik as Reverse Proxy
- Step-CA for SSL Certificates
- Mailhog for Mail Catching

## Domains

- mailhog.test

## How to use

- Clone this repo 
- Stop all running containers (if applicable)
- Run `docker-compose up -d`
- Add Resolver-File

## Add Resolver-File 
In order to resolve our '.test' - domain locally, there is a new container added, 'dnsmasq-local', it binds on port 53 on our host-system.
Now we need to create a file 
`/etc/resolver/test`, the `test` part, is our domain. if you change .test in the environment of the dnsmasq-container, you need to add a second file. if the folder `/etc/resolver` does not exist, create it. 

Fill the File with following content:
```
nameserver 127.0.0.1
```

After that, mac OS uses the nameserver on 127.0.0.1 to resolve the `.test` domain.
## Changes for every project

- Remove `- '${APP_PORT:-80}:80'` from your `docker-compose.yml` in Line 14 under `ports`
- Extend the `docker-compose.yml` file with the following:
  - Place it in the laravel.test service (scoop-os-container), the position doesn't matter.
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
    - sail
    - staudacher-proxy
```

- Change the port of the service `mariadb` to an unoccupied port. For example `${FORWARD_DB_PORT:-3306}:3306` to `${FORWARD_DB_PORT:-3307}:3306`

| Customer              | MariaDB | Kibana | ElasticSearch |
|-----------------------|---------|:-------|:--------------|
| ELUX                  | 3306    | 5601   | 9200          |
| APAC                  | 3307    | 5602   | 9201          |
| Madeleine             | 3308    | 5603   | 9202          |
| Loberon               | 3309    | 5604   | 9203          |
| Thomas Sabo           | 3310    | 5605   | 9204          |
| Saboteur              | 3311    | 5606   | 9205          |
| scoopOS               | 3312    | 5607   | 9206          |
| PUMA                  | 3313    |        |               |
| ELUX CPT              | 3314    |        |               |
| ELUX Asset API Client | 3315    |        |               |
| Goldner (Madeleine)   | 3316    | 5611   |               |  

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

### 3. Ports are not available
```
Error response from daemon: Ports are not available: exposing port UDP 127.0.0.1:53 -> 0.0.0.0:0: command failed
```

Fix:
```
Edit ~/Library/Group\ Containers/group.com.docker/settings.json and add "kernelForUDP": false
Restart Docker Desktop
```
