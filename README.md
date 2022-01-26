# mysql-replication_prometheus-grafana
A docker-compose project for mysql replication and monitoring solution which has prometheus and grafana.

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
