# Bonus mysql db Basic Commands​

d = docker

- Docker pull mysql​
  - `d pull mysql`
- List all images​
  - `d images`
- Docker run with port 3406​

```bash
d run --rm --name mydb \
-e MYSQL_ROOT_PASSWORD=pw123 \
-p 3406:3306 -d mysql
```

- Enter MySQL container​
  - `d exec -it mydb bash`
- Enter MySQL cli
  - `mysql -u root -p`
- In MySQL

```bash
show databases;
use mysql;
show tables;
desc user;
select user from user;
# quit
\q
exit
```
