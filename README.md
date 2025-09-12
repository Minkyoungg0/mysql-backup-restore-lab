# 🍙 TamaDB

### 오늘 먹인 **밥과 간식**을 기록하고, 밤마다 **타임캡슐**로 안전하게 보관하세요 :)

**캐릭터(고양이/강아지/펭귄)** 를 키우며 `먹이기` · `다치기` 같은 이벤트를 기록하고, **MySQL 전체 백업과 시점복구(PITR)** 로 **장애를 재현·복구**하는 프로젝트입니다.  
운영에서 흔히 겪는 “사람 실수로 인한 데이터 장애를 백업/복구로 회복”하는 흐름을 구성했습니다.

<img width="1024" height="576" alt="1757575200418" src="https://github.com/user-attachments/assets/63df5018-dc37-4c10-ad16-bb6c2142cc11" />

## 👥 구성원
<table>
  <tr>
    <td align="center">
      <a href="https://github.com/Minkyoungg0">
        <img src="https://github.com/Minkyoungg0.png" width="100px;" alt="Minkyoungg0"/><br />
        <sub><b>문민경</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/songhajang">
        <img src="https://github.com/songhajang.png" width="100px;" alt="songhajang"/><br />
        <sub><b>장송하</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/Gill010147">
        <img src="https://github.com/Gill010147.png" width="100px;" alt="Gill010147"/><br />
        <sub><b>황병길</b></sub>
      </a>
    </td>
  </tr>
</table>

<br>

## 🎯 프로젝트 목표

- 게임처럼 캐릭터를 돌보며 시간이 흐를수록 **체력과 기분이 변하고, 그 과정이 데이터베이스에 사건 기록**으로 남습니다.
- 운영 관점에서는 주기적으로 **전체 백업**을 만들고, **문제가 생기면 최신 백업과 변경 기록을 이용해 원하는 시점**으로 되돌립니다.

<br>

## 📦 저장하는 데이터
- **현재 상태**: 캐릭터 아이콘(정상/먹기/아픔), 체력(0~100), 기분(예: NORMAL·EAT·PAIN), 마지막 백업 시각, 마지막 사고 시각, 갱신 시각.
- **사건 기록**: 어떤 일이 언제 일어났는지(예: 초기화, 먹이기, 사고, 백업, 복구)를 시간과 세부 내용과 함께 저장.
- **복구 메타**: 생성된 전체 백업 파일 경로와 덤프 헤더에서 추출한 기준 정보, 생성 시각.
- **산출물**: `backups/` 폴더의 전체 백업 파일과 메타 파일, `reports/` 폴더의 상태 점검 리포트.

<br>

## ⚙ 사용 기술 및 도구 (Tech Stack & Tools)
- **IDE / OS**: VS Code · Ubuntu 24.04 · diff 3.10
- **가상 환경**: VirtualBox (Linux VM 구동)
- **DB / CLI**: MySQL 8.x · mysql · mysqldump · mysqlbinlog
- **Shell / 유틸**: Bash · GNU coreutils · cron
- **버전 관리**: Git · GitHub
- **협업**: Notion · Slack

<br>

## ⚙️ 동작 개요
- **시작**: 캐릭터를 선택해 체력 100, 기분 정상 상태로 초기화한다.
- **진행**: 시간이 흐르면 체력이 조금씩 줄고, 먹이를 주면 회복되며, 사고가 나면 체력이 감소하고 임계값 이하에서는 아픈 상태로 바뀐다. 화면 아이콘은 이 변화를 바로 반영한다.
- **기록**: 모든 행동과 상태 변화가 데이터베이스에 사건으로 남아 이후 점검과 분석에 활용된다.
- **백업**: 필요할 때 전체 백업을 만들어 기준 시점의 상태를 보존하고, 복구에 필요한 부가 정보를 함께 저장한다.
- **복구**: 문제가 생기면 가장 최근의 전체 백업을 불러온 뒤, 변경 이력을 원하는 시점까지 차례대로 적용하여 과거 상태로 되돌린다.
- **점검**: 현재 상태와 사건 누계를 리포트로 확인해, 운영 흐름이 의도대로 작동했는지 빠르게 검증한다.

<br>

## 📁 파일 구조
```
tama-game/
├── backups/ # 전체 백업(.sql)과 메타(.meta) 저장
├── reports/ # 점검 리포트 저장(verify)
├── backup.sh # 전체 백업 + 메타 저장
├── eat.sh # 먹이기(EAT) → health=100, mood 일시 전환
├── env.sh # 공통 환경변수(MySQL 접속, 경로, 헬퍼함수)
├── game_init.sh # 캐릭터 선택 + 초기화(health=100, mood=NORMAL)
├── oops.sh # 데미지(OOPS) → health -10 (0 이하시 PAIN)
├── play.sh # 메인 런처(상태 감소 루프 + 메뉴/키 입력 UI)
├── restore_pitr.sh # 가장 최신 full dump + binlog로 시점복구(-1d)
├── verify.sh # 현재 상태/이벤트 집계 리포트 출력
└── (예시) full_YYYYmmdd_HHMMSS.sql # 샘플 백업 덤프
```

<br>

## 🎮 플레이 & 운영 시나리오
- **시작**: 캐릭터를 선택해 체력 100, 기분 정상으로 초기화하고 터미널에서 상태를 본다.  
  ```bash
  ./game_init.sh   # 캐릭터 아이콘 선택 → health=100, mood=NORMAL
  ./play.sh        # m: 메뉴, q: 종료
  ```
- **기록**: 모든 변화(초기화/먹이기/사고/백업/복구)는 사건으로 DB에 누적된다.
  ```
  -- 예: 최근 이벤트 10건
  SELECT ev_type, ev_at, details FROM events ORDER BY ev_at DESC LIMIT 10;
  ```
  
- **운영**: 전체 백업을 만들고, 문제가 생기면 최신 백업 + 변경 이력으로 원하는 시점까지 되돌린다.
  ```
  ./backup.sh         # full dump + meta
  ./restore_pitr.sh   # 최신 dump 복원 + 어제(-1d)까지 재적용
  ```
  
- **점검**: 현재 상태/사건 누계를 리포트로 확인한다.
  
  ```
  ./verify.sh
  cat reports/verify_*.txt
  ```

<br>

## 🧩 데이터 모델
- **현재 상태**: 캐릭터 아이콘(정상/먹기/아픔), 체력(0~100), 기분(예: 정상·먹는 중·아픔), 마지막 백업 시각, 마지막 사고 시각, 갱신 시각을 저장한다.
- **사건 기록**: 어떤 일이 언제 일어났는지와 세부 내용을 유형(초기화, 먹이기, 사고, 백업, 복구)별로 누적한다.
- **복구 메타**: 생성된 전체 백업 파일 경로와 덤프 헤더에서 추출한 기준 정보, 생성 시각을 보관한다.

```
-- 요약 DDL (필요 시 실제 덤프를 임포트 권장)
CREATE TABLE game_state (
  id INT PRIMARY KEY,
  icon_normal VARCHAR(255), icon_eat VARCHAR(255), icon_pain VARCHAR(255),
  health INT NOT NULL DEFAULT 100,
  mood VARCHAR(20) NOT NULL DEFAULT 'NORMAL',
  last_backup_at DATETIME(6), last_oops_at DATETIME(6), updated_at DATETIME(6)
);

CREATE TABLE events (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  ev_type VARCHAR(20) NOT NULL,
  ev_at DATETIME(6) NOT NULL,
  details JSON
);

CREATE TABLE pitr_meta (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  full_dump VARCHAR(512) NOT NULL,
  meta_text LONGTEXT,
  created_at DATETIME(6) NOT NULL
);
```

<br>

## 🧪 시연 플로우

![시연](https://github.com/user-attachments/assets/13801d91-0de3-47c9-914f-56a7750378f7)


1. 초기화
   ```
   ./game_init.sh
   ```
2. 플레이
   ```
   ./play.sh  # 화면에서 체력 감소/아이콘 변화 확인
   ```
3. 먹이기 → 회복
   ```
   ./eat.sh
   ``` 
4. 사고 여러 번 → 아픔 상태
   ```
   ./oops.sh && ./oops.sh && ./oops.sh
   ```
5. 전체 백업 생성
   ```
   ./backup.sh
   ls backups/
   ```
6. 복구
   ```
   ./restore_pitr.sh
   ```
7. 점검 리포트
   ```
   ./verify.sh
   cat reports/verify_*.txt
   ```

## 🗓️자동화 예시

## 📂 회고

### 👤 문민경
터미널에서 돌아가는 **게임 루프와 메뉴형 UI를 Bash로 안정적으로 구성**하는 법을 익혔습니다. `set -euo pipefail`과 `trap`으로 오류를 빠르게 드러내고, **백그라운드 감소 루프(체력 자동 감소)와 화면 갱신**을 충돌 없이 관리하는 게 핵심이었습니다. 앞으로는 입력 이벤트를 더 풍부하게 하고, 로그 기반으로 **플레이 리플레이**까지 구현해 보고 싶습니다.

### 👤 장송하
이번 프로젝트를 통해 **전체 백업과 시점 복구(PITR)의 실전 흐름**을 체득했습니다. `mysqldump`로 일관성 있는 덤프를 만들고, `mysqlbinlog`의 **지정 시각까지 재적용**해 장애를 되돌리는 과정에서 **바이너리 로그 보존 기간, 권한, 서버 설정**의 중요성을 몸으로 느꼈습니다. 다음 단계로는 사용자가 직접 시간을 고르는 **인터랙티브 복구 옵션**을 추가해 복구 경험을 더 직관적으로 만들 계획입니다.

### 👤 황병길
상태와 사건을 분리한 **간단한 스키마(game_state / events / pitr_meta)**가 **관측 가능성(Observability)**을 크게 높여 준다는 걸 확인했습니다. `verify.sh`로 **현재 상태와 이벤트 집계 리포트**를 자동 생성해 운영 점검 속도를 끌어올렸고, 주기 백업·리포트 **크론 자동화**까지 연결해 “게임=운영 훈련”이라는 목표를 달성했습니다. 향후에는 보존 정책과 **백업 회전(rotate)**, 원격 저장소 업로드를 더해 실전성까지 강화하겠습니다.


