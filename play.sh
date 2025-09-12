#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"

get_state() {
  read -r health mood inorm ieat ipain <<<"$($MYSQL -e "SELECT health,mood,icon_normal,icon_eat,icon_pain FROM game_state WHERE id=1;")"
  echo "${health}|${mood}|${inorm}|${ieat}|${ipain}"
}

draw() {
  IFS='|' read -r health mood inorm ieat ipain <<<"$(get_state)"
  if [[ "$mood" == "EAT" ]]; then
    icon="$ieat"
  elif (( health < 50 )); then
    icon="$ipain"
  else
    icon="$inorm"
  fi
  clear
  echo "${icon}"
}

decay_loop() {
  while :; do
    $MYSQL <<'SQL'
UPDATE game_state
SET health = GREATEST(0, health-5),
    mood   = IF(GREATEST(0, health-5)=0, 'PAIN', mood),
    updated_at = NOW()
WHERE id=1;
SQL
    sleep 5
  done
}

menu() {
  cat <<'EOM'
1) INIT        (새로 시작)
2) BACKUP      (백업)
3) OOPS        (사고 주입)
4) EAT         (먹이 주기)
EOM
}

run_menu() {
  menu
  read -rp "> " sel
  case "$sel" in
    1) "$(dirname "$0")/game_init.sh" ;;   # 새로 시작
    2) "$(dirname "$0")/backup.sh" ;;      # 백업
    3) "$(dirname "$0")/oops.sh" ;;        # 사고 주입
    4) "$(dirname "$0")/eat.sh" ;;         # 먹이 주기
    *) : ;;
  esac
}

decay_loop &
DECAY_PID=$!
trap 'kill "$DECAY_PID" 2>/dev/null || true; wait "$DECAY_PID" 2>/dev/null || true' EXIT INT TERM

# 시작 시 메뉴 → 화면
run_menu
draw

while true; do
  IFS= read -rsn1 key
  case "$key" in
    "q"|"Q") exit 0 ;;       # 종료 키는 유지
    "m"|"M") run_menu; draw ;;
    *) : ;;
  esac
done
