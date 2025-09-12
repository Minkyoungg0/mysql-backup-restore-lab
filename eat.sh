#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"

# 1) DB에서 아이콘 3종 읽기
read -r INORM IEAT IPAIN <<<"$($MYSQL -e "SELECT icon_normal, icon_eat, icon_pain FROM game_state WHERE id=1;")"

# 2) EAT 상태로 전환 + health=100
now="$(NOW_6)"
$MYSQL <<SQL
UPDATE game_state
SET mood='EAT', health=100, updated_at=NOW()
WHERE id=1;
SQL

$MYSQL <<SQL
INSERT INTO events(ev_type, ev_at, details)
VALUES ('EAT', '${now}', JSON_OBJECT('by','eat.sh','set_health',100));
SQL

# 3) 터미널에 '먹는 아이콘' 표시
clear
echo "${IEAT} 냠냠"

# 4) 표시 시간 유지 후 NORMAL 복귀
sleep 1.0
$MYSQL -e "UPDATE game_state SET mood='NORMAL', updated_at=NOW() WHERE id=1;"

# 5) NORMAL 아이콘 다시 표시 (건강 기준에 따라 pain이 우선일 수 있음)
# 단순히 normal 표시를 원한다면 INORM, 건강 조건 반영하려면 DB에서 health를 읽어 분기
health="$($MYSQL -e "SELECT health FROM game_state WHERE id=1;")"
if [ "$health" -lt 50 ]; then
  icon_after="$IPAIN"
else
  icon_after="$INORM"
fi
clear
echo "${icon_after}"
