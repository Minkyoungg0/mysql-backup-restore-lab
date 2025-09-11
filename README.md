# 🍙 TamaDB

### 오늘 먹인 **밥과 간식**을 기록하고, 밤마다 **타임캡슐**로 안전하게 보관하세요 :)

매 끼니의 **밥**과 **간식**을 시간·양·칼로리·메모와 함께 남깁니다.  
기록은 매일 밤 **타임캡슐로 포장**되어 안전하게 보관되고, 실수나 이상이 생기면 **지정 시각**으로 깔끔하게 **되감아** 원래 상태를 되찾을 수 있습니다.

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

## 📝 프로젝트 목표
**손쉬운 급여 기록**: 밥/간식을 빠르게 남기고 누적 히스토리를 관리합니다.<br>
**자동 안심저장 & 체크포인트**: 매일 정해진 시간에 기록을 **타임캡슐**로 포장하고 기준점을 남깁니다.<br>
**시각 지정 복구(PITR)**: 사고 직전 **정확히 1초 전**으로 원클릭 되감기를 지원합니다.<br>
**무결성 검증**: 되감기 후 행수·합계·인덱스·FK를 점검해 **“진짜 복원”**을 확인합니다.

## 📦 저장하는 데이터(요약)
- `feed_log`: `fed_at`, `type(meal|snack)`, `amount_gram`, `kcal`, `note`
- `daily_goal`: 날짜별 칼로리 목표, 간식 한도
- `restore_points`: 타임캡슐 파일·체크섬·생성 시각(되감기 체크포인트)

## ⚙️ 동작 개요
1) 기록(밥/간식) 저장 → 히스토리 누적  
2) **매일 03:00 타임캡슐 포장**(압축 + 체크섬, `latest` 링크 갱신)  
3) 이상 징후 감지 시 **되감기 타깃 시각** 자동 산출(`target.txt`)  
4) `restore_pitr.sh --to "<타깃 시각>"`으로 **직전 상태로 되돌림** → `verify.sh`로 검증

## 📁 파일 구조

## ⚙ 사용 기술 및 도구 (Tech Stack & Tools)

## ⚙️ 시스템 아키텍처

## 📦 데이터 스키마(요약)

## ⚙️ 설치 & 초기화

## 🔄 자동화 설정(cron 예시)

## 🚀 실행 흐름(기본)

## ⏪ 되감기 트리거 시나리오 (요약)

> 핵심은 “파일을 모아놨다”가 아니라, **언제든 정확히 되돌릴 수 있음을 증명**하는 것입니다.
