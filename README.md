# 🍙 TamaDB



[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Bash](https://img.shields.io/badge/GNU%20Bash-4EAA25?style=for-the-badge&logo=GNU%20Bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)](https://git-scm.com/)

### 오늘 먹인 **밥과 간식**을 기록하고, 밤마다 **타임캡슐**로 안전하게 보관하세요 :)

**캐릭터(고양이/강아지/펭귄)** 를 키우며 `먹이기` · `다치기` 같은 이벤트를 기록하고, **MySQL 전체 백업과 시점복구(PITR)** 로 **장애를 재현·복구**하는 프로젝트입니다.  
운영에서 흔히 겪는 “사람 실수로 인한 데이터 장애를 백업/복구로 회복”하는 흐름을 구성했습니다.

<img width="1024" alt="TamaDB Architecture" src="https://github.com/user-attachments/assets/63df5018-dc37-4c10-ad16-bb6c2142cc11" />

---


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

--- 

## 🎯 핵심 목표

*   **게이미피케이션 학습:** 캐릭터의 상태(체력, 기분) 변화가 데이터베이스에 이벤트로 기록되는 직관적인 게임형 인터페이스를 제공합니다.
*   **재해 시뮬레이션:** 데이터 무결성이 손상되고 복구가 필요한 현실적인 재해 복구 시나리오를 구현합니다.
*   **운영 실습:** 표준 MySQL 도구를 사용하여 전체 백업 생성 및 특정 시점 복구(PITR) 프로세스를 개발하고 자동화합니다.

---

## ✨ 주요 기능

*   **인터랙티브 펫 관리:** 간단한 셸 명령어를 통해 캐릭터를 선택하고 체력과 기분을 관리합니다.
*   **실시간 상태 변화:** 펫의 체력은 시간이 지남에 따라 자연스럽게 감소하며, 먹이 주기(`eat.sh`)나 사고(`oops.sh`) 같은 이벤트에 의해 영향을 받습니다.
*   **자동화된 백업:** `backup.sh` 스크립트는 `mysqldump`를 사용하여 전체 데이터베이스 덤프를 생성하고 복구에 필요한 메타데이터를 저장합니다.
*   **특정 시점 복구 (PITR):** `restore_pitr.sh` 스크립트는 최신 전체 백업을 적용하고 원하는 타임스탬프까지 바이너리 로그(`mysqlbinlog`)를 재생하여 데이터베이스를 특정 순간으로 복원합니다.

---

## ⚙️ 기술 스택 및 도구

| 구분 | 기술 |
| :--- | :--- |
| **IDE / OS** | VS Code · Ubuntu 24.04 |
| **가상화** | VirtualBox (Linux VM 구동용) |
| **DB / CLI** | MySQL 8.x |
| **셸 / 유틸리티** | Bash · cron |
| **협업** | Git · Slack |

---

## 📁 파일 구조

```
tama-game/
├── backups/        # 전체 백업(.sql) 및 메타데이터(.meta) 저장
├── reports/        # 검증 리포트 저장
├── backup.sh       # 전체 백업 및 메타데이터 생성
├── eat.sh          # '먹이주기' 액션: 체력을 100으로 회복
├── env.sh          # 공통 환경 변수 및 헬퍼 함수
├── game_init.sh    # 새 캐릭터 초기화
├── oops.sh         # '사고' 액션: 체력 감소
├── play.sh         # 메인 게임 런처 및 UI 루프
├── restore_pitr.sh # 최신 백업과 바이너리 로그로 DB 복원
├── verify.sh       # 상태/이벤트 요약 리포트 생성
└── ...
```

---

## 🚀 시작하기 및 데모

### 데모 영상
![Demonstration GIF](https://github.com/user-attachments/assets/13801d91-0de3-47c9-914f-56a7750378f7)

### 시나리오 워크플로우

1.  **캐릭터 초기화:** 캐릭터를 선택하여 새 게임을 시작합니다.
    ```bash
    ./game_init.sh
    ```
2.  **게임 플레이:** 메인 게임 루프를 실행하여 캐릭터의 상태를 확인합니다. 시간이 지남에 따라 체력이 감소합니다.
    ```bash
    ./play.sh  # 'm' 키로 메뉴 열기, 'q' 키로 종료
    ```
3.  **캐릭터에게 먹이주기:** 체력을 100으로 회복합니다.
    ```bash
    ./eat.sh
    ```
4.  **사고 시뮬레이션:** 여러 번의 사고를 발생시켜 체력을 낮추고 캐릭터의 기분을 'PAIN'으로 변경합니다.
    ```bash
    ./oops.sh && ./oops.sh && ./oops.sh
    ```
5.  **전체 백업 생성:** 수동으로 전체 백업을 실행합니다.
    ```bash
    ./backup.sh
    ls -l backups/ # 백업 파일이 생성되었는지 확인
    ```
6.  **PITR 수행:** 24시간 전의 상태로 데이터베이스를 복원합니다. 이는 심각한 오류로부터 복구하는 상황을 시뮬레이션합니다.
    ```bash
    ./restore_pitr.sh
    ```
7.  **상태 검증:** 리포트를 생성하고 확인하여 복원이 성공적으로 완료되었는지 검증합니다.
    ```bash
    ./verify.sh
    cat reports/verify_*.txt
    ```

---

## 🤖 자동화 예시 (cron)

`cron`을 사용하여 주기적인 백업 및 리포트 생성을 자동화할 수 있습니다.

```bash
# 현재 사용자의 crontab 편집
crontab -e

# 매일 새벽 2시에 백업을 실행하고, 매시간 검증 작업을 수행하도록 다음 라인을 추가합니다.
# 스크립트 경로는 절대 경로로 지정해야 합니다.
0 2 * * * /path/to/tama-game/backup.sh
0 * * * * /path/to/tama-game/verify.sh
```

---

## 🧩 데이터 모델

데이터베이스 스키마는 현재 상태와 이벤트 로그를 분리하여 관측 가능성(Observability)과 복구 용이성을 높였습니다.

*   **`game_state`**: 캐릭터의 현재 속성(체력, 기분, 아이콘)을 저장합니다. 이 테이블은 변경 가능하며, "현재" 상태를 반영합니다.
*   **`events`**: 발생한 모든 행동에 대한 불변의 순차적 로그입니다.
*   **`pitr_meta`**: 각 전체 백업에 대한 메타데이터를 포함하며, 덤프 파일 경로와 바이너리 로그 좌표(`GTID_EXECUTED`)를 저장합니다.

```sql
-- 참조용 단순화된 DDL

CREATE TABLE game_state (
  id INT PRIMARY KEY,
  icon_normal VARCHAR(255), icon_eat VARCHAR(255), icon_pain VARCHAR(255),
  health INT NOT NULL DEFAULT 100,
  mood VARCHAR(20) NOT NULL DEFAULT 'NORMAL',
  last_backup_at DATETIME(6),
  last_oops_at DATETIME(6),
  updated_at DATETIME(6)
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
  meta_text LONGTEXT, -- 덤프 헤더에서 GTID_EXECUTED 값을 저장
  created_at DATETIME(6) NOT NULL
);
```

---

## 🚀 향후 개선 계획

*   **인터랙티브 복구:** 사용자가 최근 이벤트 목록에서 특정 타임스탬프를 선택하여 PITR을 수행할 수 있도록 허용합니다.
*   **고급 자동화:** 백업 보존 정책을 구현하고, 백업 파일을 원격 스토리지 서비스(예: AWS S3)에 업로드합니다.

  
