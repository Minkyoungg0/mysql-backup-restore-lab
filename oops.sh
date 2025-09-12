#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"

now="$(NOW_6)"
$MYSQL <<'SQL'
UPDATE game_state
SET health=GREATEST(0, health-90),
    updated_at=NOW()
WHERE id=1;
SQL

hp=$($MYSQL -e "SELECT health FROM game_state WHERE id=1;")
if [ "${hp}" -le 0 ]; then
  $MYSQL -e "UPDATE game_state SET mood='PAIN', last_oops_at='${now}', updated_at=NOW() WHERE id=1;"
  hint="PAIN"
else
  hint="HURT"
fi

$MYSQL <<SQL
INSERT INTO events(ev_type, ev_at, details) VALUES ('OOPS', '${now}', JSON_OBJECT('delta_health',-90,'state','${hint}'));
SQL
