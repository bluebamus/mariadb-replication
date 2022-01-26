-- For Replication

CREATE USER 'repl'@'%' IDENTIFIED BY 'repl';

GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';

-- For Orchestrator

/*
CREATE USER 'orc_client_user'@'%' IDENTIFIED BY 'orc_client_password';

GRANT SUPER, PROCESS, REPLICATION SLAVE, RELOAD ON *.* TO 'orc_client_user'@'%';

GRANT SELECT ON mysql.slave_master_info TO 'orc_client_user'@'%';
*/

-- For ProxySQL
/*
CREATE DATABASE testdb DEFAULT CHARACTER SET=utf8;

CREATE USER appuser@'%' IDENTIFIED BY 'apppass';

GRANT SELECT, INSERT, UPDATE, DELETE ON testdb.* TO appuser@'%';

CREATE USER monitor@'%' IDENTIFIED BY 'monitor';

GRANT REPLICATION CLIENT ON *.* TO monitor@'%';
*/

-- For Prometheus
/*
CREATE USER 'exporter'@'localhost' IDENTIFIED BY 'exporter123' WITH MAX_USER_CONNECTIONS 3;

GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'localhost';
*/