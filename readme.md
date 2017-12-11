## Run nginx Proxy

    cd ./
    docker-compose up -d
    
Then auto-restarts so is always up and running

## Commands

Start docker compose (run it)

    cd [project directory]
    docker-compose -d up

Stop docker compose (stop it)

    docker-compose down

Run composer update

    docker-compose exec app composer update
    
    # or
    
    alias cu="docker-compose exec app composer update"
    cu
    
Use NPM

    docker-compose run node bash
    npm install && npm run dev
    
See logfiles

    docker-compose logs -f

## In your Laravel Project

Set this to get error logs from your docker container

    APP_LOG=errorlog