# PBL6

*On linux ubuntu
1. Install docker and docker-compose:
  $ sudo apt-get update 
  $ sudo apt-get install docker 
  $ sudo apt-get install docker-compose
2. Create the docker group and add your user:
  $ sudo groupadd docker
  $ sudo usermod -aG docker $USER
3. Log out and log back in so that your group membership is re-evaluated:
  $ newgrp docker 
4. Verify that you can run docker commands without sudo:
	$ docker run hello-world
5. Download 'docker-compose.yml'
6. In Directory, which contain 'docker-compose.yml' file:
  $ docker-compose up
