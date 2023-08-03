cd ~/Documents/Workspaces/Docker/Dockerfiles # Your project root

## If the Docker buildx instance is unusable, recreate it
docker buildx rm multiarch
docker buildx create --name multiarch --use

## Apache2 with PHP
docker buildx build --no-cache --progress=plain --push --platform linux/amd64,linux/arm64 --rm -t wujidadi/ap:3.8 -t wujidadi/ap:latest ap/3.8 2>&1 | tee $D/docker-build-ap.log
docker run -d -p 50000:80 -it --name Test wujidadi/ap:3.8
# docker exec -it Test zsh
docker exec -it Test vim --version
docker exec -it Test nano -V
docker exec -it Test apache2 -v
docker exec -it Test php -v
docker exec -it Test composer -V
docker exec -it Test node -v
docker exec -it Test npm -v
docker exec -it Test cat /opt/microsoft/msodbcsql18/etc/odbcinst.ini
docker stop Test; docker rm Test

## Nginx with PHP
docker buildx build --no-cache --progress=plain --push --platform linux/amd64,linux/arm64 --rm -t wujidadi/nginx-php:2.8 -t wujidadi/nginx-php:latest nginx-php/2.8 2>&1 | tee $D/docker-build-np.log
docker run -d -p 50000:80 -it --name Test wujidadi/nginx-php:2.8
# docker exec -it Test zsh
docker exec -it Test vim --version
docker exec -it Test nano -V
docker exec -it Test nginx -v
docker exec -it Test php -v
docker exec -it Test composer -V
docker exec -it Test node -v
docker exec -it Test npm -v
docker exec -it Test cat /opt/microsoft/msodbcsql18/etc/odbcinst.ini
docker stop Test; docker rm Test

## Ubuntu tuned
docker buildx build --no-cache --progress=plain --push --platform linux/amd64,linux/arm64 --rm -t wujidadi/ubuntu-tuned:2.8 -t wujidadi/ubuntu-tuned:latest ubuntu-tuned/2.8 2>&1 | tee $D/docker-build-ut.log
docker run -d -p 50000:80 -it --name Test wujidadi/ubuntu-tuned:2.8
# docker exec -it Test zsh
docker exec -it Test vim --version
docker exec -it Test nano -V
docker stop Test; docker rm Test
