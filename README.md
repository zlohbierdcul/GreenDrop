# Greendrop
A Lieferando-like delivery app for cannabis products.
## Fontend
### Folder structure

Please use [this guide](https://codewithandrea.com/articles/flutter-project-structure/) on how to structure the codebase. We will use the Feature-first method here.

### Database Setup and initialization

This project uses Docker and Docker Compose to set up a PostgreSQL database along with an application. Below are the instructions to initialize the container, handle changes, and configure the environment variables securely.

#### Prerequisites
- [Docker](https://docs.docker.com/engine/)
- [Docker Compose](https://docs.docker.com/engine/)

Alternatively:
 - [Docker Desktop](https://docs.docker.com/desktop/)

 If you don't have them installed, follow the Docker installation guide and Docker Compose installation guide to set up Docker and Docker Compose on your system.


#### Getting Started

##### 1. Create the .env file
The .env file contains sensitive information like the user password and database connection parameters. You should create it in the project root directory.

Create the .env file with the following content:

```ini
POSTGRES_USER=youruser
POSTGRES_PASSWORD=yourpassword
POSTGRES_DB=greendrop_db
```
POSTGRES_USER: The username for the PostgreSQL database.
POSTGRES_PASSWORD: The password for the PostgreSQL user.e created on startup.
POSTGRES_DB: The name of the database to be created on startup

#### 2. Run the Docker Container
After setting up the .env file, you can use Docker Compose to build and start the container.

```bash
docker-compose up -d
```

This will:

- Build the necessary Docker images (if not already built).
- Start the containers in the background (-d flag stands for "detached").

Once the containers are running, your database and application will be available as defined in the docker-compose.yml file.

As defined in the docker-compose.yml it will initialisze the database with the tables specified in 01_init.sql and populate the tables with the default data specified in 02_seed_data.sql


#### 3. Accessing the database

##### Access the PostgreSQL container (greendrop_db)

```bash
docker exec -it greendrop_db psql -U exampleuser -d exampledb
```

- `exampleuser`: The username for the PostgreSQL database (as defined in .env).
- `exampledb`: The name of the database to connect to (as defined in .env).

This will give you an interactive PostgreSQL prompt (psql), where you can run SQL queries directly within the container.

e.g.
```sql
SELECT *
FROM users
```
#### 4. Implementing changes to the database

If you make changes to your Docker setup, such as modifying the docker-compose.yml file, rebuilding images, or changing the .env file, you can follow these steps:

##### Stop and remove the containers:

```bash
docker-compose down
```

This will stop and remove the containers, but it will not delete volumes (which include your data).

##### Rebuild the containers (optional):

If you've made changes to the Docker images, you can rebuild them:

```bash
docker-compose build
```

##### Restart the containers with the changes:

```bash
docker-compose up -d
```

This will restart the containers with the latest configurations.

##### View Logs

To view logs of the running services, use the following command:

```bash 
docker-compose logs -f
```
This will tail the logs for all services, or you can specify a specific service like db or app:

```bash
docker-compose logs -f db
```
##### Stop the Containers

To stop the containers without removing them, use:

```bash
docker-compose stop
```
This will stop the containers but leave them in place, so you can start them again later with docker-compose start.
##### Removing Containers, Networks, and Volumes

If you want to completely remove the containers, networks, and volumes, including all data:

```bash
docker-compose down -v
```

This will delete everything, including volumes. Be cautious as this will delete your database data as well.