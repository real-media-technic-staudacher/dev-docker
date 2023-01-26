## Whats Inside 
 - Traefik as Reverse Proxy 
 - [ONGOING] Step-CA for SSL Certificates 
 - Mailhog for Mail Catching

## Domains 
 - mailhog.test 

## How to use 
    - Clone this repo 
    - Run `docker-compose up -d`

## Add Scoop-OS to Proxy 
   - Extend the `docker-compose.yml` file with the following, service should be the scoop-os-container:
   - __CUSTOMERNAME__ should be replaced with the domain prefix, e.g. "madeleine"
   ```yml
        labels:
          - "traefik.enable=true"
          - "traefik.http.routers.__CUSTOMERNAME__.entrypoints=http"
          - "traefik.http.routers.__CUSTOMERNAME__.rule=Host(`__CUSTOMERNAME__-scoopos.test`)"
          - "traefik.http.services.__CUSTOMERNAME__.loadbalancer.server.port=80"
          - "traefik.docker.network=staudacher-proxy"
   ```
   - Afterwards we need to extend the network on the given service, with sail add a second entry with "staudacher-proxy"
```yml 
        networks:
          - sail
          - staudacher-proxy
```
And we need to extend the "network" section of the docker-compose file with the following: 
```yml
     staudacher-proxy:
       external: true
   ```


