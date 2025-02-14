# Check if Docker Desktop is running
$dockerProcess = Get-Process "Docker Desktop" -ErrorAction SilentlyContinue
if (-not $dockerProcess) {
    Write-Error "Docker Desktop is not running. Please start Docker Desktop and try again."
    exit 1
}

# Check if first argument is not "-n"
if ($args[0] -ne "-n") {
    Write-Host "Building Docker image..."
    try {
        docker build -t helper:latest .
        if ($LASTEXITCODE -ne 0) { throw "Docker build failed" }
    }
    catch {
        Write-Error "Failed to build Docker image: $_"
        exit 1
    }
}

# Create storage directory if it doesn't exist
Write-Host "Ensuring storage directory exists..."
New-Item -ItemType Directory -Path "storage" -Force

# Run the docker container
Write-Host "Starting container..."
try {
    docker-compose -f docker-compose-win.yml run -t helper /bin/bash
    if ($LASTEXITCODE -ne 0) { throw "Docker compose failed" }
}
catch {
    Write-Error "Failed to start container: $_"
    exit 1
}
