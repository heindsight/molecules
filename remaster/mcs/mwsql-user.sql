CREATE USER 'mwsql'@'localhost' IDENTIFIED BY  'mcsmanager';

GRANT ALL PRIVILEGES ON * . * TO  'mwsql'@'localhost' IDENTIFIED BY  'mcsmanager' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 
0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
