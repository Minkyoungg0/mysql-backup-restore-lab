#!/usr/bin/env bash
: "${MYSQL_HOST:=127.0.0.1}"
: "${MYSQL_PORT:=3306}"
: "${MYSQL_USER:=root}"
: "${MYSQL_PWD:=1234}"
: "${MYSQL_DB:=tamaDB}"

MYSQL="mysql -h${MYSQL_HOST} -P${MYSQL_PORT} -u${MYSQL_USER} -p${MYSQL_PWD} -D ${MYSQL_DB} --protocol=TCP --comments --silent --raw --skip-column-names" # -D로 DB 지정[7]
BINLOG="mysqlbinlog" # binlog 재적용 도구[4]

NOW_6() { date +"%Y-%m-%d %H:%M:%S.%6N"; } # 마이크로초 시각[6]

BACKUP_DIR="./backups"
REPORT_DIR="./reports"
mkdir -p "${BACKUP_DIR}" "${REPORT_DIR}"
