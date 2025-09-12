#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"

ts=$(date +"%Y%m%d_%H%M%S")
dump="${BACKUP_DIR}/full_${ts}.sql"
meta="${BACKUP_DIR}/full_${ts}.meta"

# 1) 논리 풀백업: --source-data 사용하지 않음(8.4 호환성 위해) [시간 기반 PITR로 운용]
mysqldump -h${MYSQL_HOST} -P${MYSQL_PORT} -u${MYSQL_USER} -p${MYSQL_PWD} \
  --single-transaction --routines --triggers --events \
  --databases ${MYSQL_DB} > "${dump}"

# 2) 메타 저장: MySQL 8.4에서는 SHOW MASTER STATUS 제거 → SHOW BINARY LOG STATUS 사용
#    실패해도 덤프 자체는 유효해야 하므로 || true
{
  echo "# META captured at $(NOW_6)"
  echo "# MySQL version:"
  $MYSQL -e "SELECT VERSION();" || true

  echo "# Binary log status (8.4+):"
  $MYSQL -e "SHOW BINARY LOG STATUS\G" || true

  echo "# Binary logs list:"
  $MYSQL -e "SHOW BINARY LOGS;" || true
} > "${meta}"

# 3) 이벤트/메타 기록
now="$(NOW_6)"
$MYSQL <<SQL
UPDATE game_state SET last_backup_at='${now}', updated_at=NOW() WHERE id=1;
INSERT INTO events(ev_type, ev_at, details)
VALUES ('BACKUP', '${now}', JSON_OBJECT('dump','${dump}','meta','${meta}'));
INSERT INTO pitr_meta(full_dump, meta_text, created_at)
VALUES ('${dump}', LOAD_FILE('${meta}'), '${now}');
SQL
