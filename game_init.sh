#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"

echo "=== 캐릭터 선택 ===" # 단순 출력(UI)[1]
echo "1) 고양이  normal: =^.^=      eat: (=^.^=)🍚     pain: (=T.T=)"
echo "2) 강아지  normal: (U･ᴥ･U)   eat: (U･ᴥ･U)🍚    pain: (U>_<U)"
echo "3) 펭귄    normal: (•ᴗ•)و     eat: (•ᴗ•)و🍚      pain: (•╥﹏╥•)"
read -rp "선택> " csel

case "$csel" in
  1) INORM="=^.^=";      IEAT="(=^.^=)🍚";   IPAIN="(=T.T=)";;
  2) INORM="(U･ᴥ･U)";    IEAT="(U･ᴥ･U)🍚";  IPAIN="(U>_<U)";;
  3) INORM="(•ᴗ•)و";     IEAT="(•ᴗ•)و🍚";    IPAIN="(•╥﹏╥•)";;
  *) INORM="=^.^=";       IEAT="(=^.^=)🍚";   IPAIN="(=T.T=)";;
esac

$MYSQL <<SQL
INSERT INTO game_state (id, icon_normal, icon_eat, icon_pain, health, mood, last_backup_at, last_oops_at)
VALUES (1, '${INORM}', '${IEAT}', '${IPAIN}', 100, 'NORMAL', NULL, NULL)
ON DUPLICATE KEY UPDATE
  icon_normal='${INORM}', icon_eat='${IEAT}', icon_pain='${IPAIN}',
  health=100, mood='NORMAL', last_backup_at=NULL, last_oops_at=NULL,
  updated_at=NOW();
SQL
now="$(NOW_6)"
$MYSQL <<SQL
INSERT INTO events(ev_type, ev_at, details) VALUES ('RESTORE', '${now}', JSON_OBJECT('reason','init','character','${INORM}'));
SQL

echo "[INIT] 캐릭터 선택 완료 → ${INORM}"
