# mariadb-replication
A docker-compose project for mariadb.

# Working environment
master : mariadb-001   
slave : mariadb-002, mariadb-003   
network : mdbbridge   

# How to start!
1. move to compose folder
2. execute command
    ``` shell
    ./docker-compose up -d
    ```
3. move to script folder
4. execute command
    ``` shell
    ./replication_query.sh
    ```

# Reference
https://zenn.dev/nrikiji/articles/66f55c84229116   

https://www.walksocket.com/archives/852
