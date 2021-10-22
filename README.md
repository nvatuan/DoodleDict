# Easy Install with Docker-compose

** Linux **
1. Install docker and docker-compose:
  ```
  $ sudo apt-get update 
  $ sudo apt-get install docker 
  $ sudo apt-get install docker-compose
  ```
2. Create the docker group and add your user:
  ```
  $ sudo groupadd docker
  $ sudo usermod -aG docker $USER
  ```
3. Log out and log back in so that your group membership is re-evaluated:
  ```
  $ newgrp docker 
  ```
4. Verify that you can run docker commands without sudo:
  ```
  $ docker run hello-world
  ```
5. Download the `docker-compose.yml`
6. In Directory, which contain `docker-compose.yml` file, run:
  ```
  $ docker-compose up
  ```

<div align='center'>
<img src="https://github.com/nvatuan/PBL6/blob/docker/docker-compose-up-commands.png" width="90%" alt="Screenshot Step 6">
</div>


Or if you prefer to run them in detach mode:
  ```
  $ docker-compose up -d
  ```
  
