# Check if first argument is not "-n"
if ($args[0] -ne "-n") {
    docker build -t helper:latest .
}

# Create storage directory if it doesn't exist
New-Item -ItemType Directory -Path "storage" -Force

# Run the docker container
docker-compose -f docker-compose-win.yml run -t helper /bin/bash
