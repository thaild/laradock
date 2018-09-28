#!/usr/bin/env bash
GRANT SELECT ON `database`.`table` TO 'user-demo'@'%' IDENTIFIED BY 'PASSWD';
FLUSH PRIVILEGES;
