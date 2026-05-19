# Superpowers for pi

[Superpowers](https://github.com/obra/superpowers)를 **pi** 에이전트에서 사용할 수 있도록 포팅한 버전입니다.

## 설치

### Windows

```batch
.\setup.bat
```

### Linux / macOS

```bash
chmod +x setup.sh
./setup.sh
```

설치 후 pi를 **재시작**하면 Superpowers skill이 로드됩니다.

## 사용법

### Skill 명령어

대화에서 다음 명령어를 사용하세요:

| 명령어 | 설명 |
|--------|------|
| `/skill:brainstorming` | 코드 작성 전 디자인 탐색 (항상 먼저 실행!) |
| `/skill:writing-plans` | 구현 계획 작성 |
| `/skill:test-driven-development` | TDD 방식으로 구현 |
| `/skill:systematic-debugging` | 버그 해결 시 사용 |
| `/skill:executing-plans` | 계획 실행 (배치 모드) |
| `/skill:requesting-code-review` | 코드 리뷰 요청 |

### Skill 목록

| Skill | 설명 |
|-------|------|
| **brainstorming** | 아이디어를 디자인으로 변환 (코드 작성 전 필수!) |
| **using-superpowers** | Superpowers 시스템 소개 |
| **writing-plans** | 상세 구현 계획 작성 |
| **test-driven-development** | RED-GREEN-REFACTOR 사이클 |
| **systematic-debugging** | 4단계 근본 원인 분석 |
| **executing-plans** | 배치 실행 + 체크포인트 |
| **subagent-driven-development** | 서브에이전트 개발 (2단계 리뷰) |
| **dispatching-parallel-agents** | 병렬 에이전트 실행 |
| **finishing-a-development-branch** | 브랜치 완료 / PR |
| **using-git-worktrees** | 격리된 개발 브랜치 |
| **requesting-code-review** | 사전 리뷰 체크리스트 |
| **receiving-code-review** | 피드백 대응 |
| **verification-before-completion** | 수정 확인 |

## Superpowers 워크플로우

```
1. /skill:brainstorming    → 디자인 탐색 & 승인
2. /skill:writing-plans    → 구현 계획 작성
3. /skill:executing-plans  → TDD로 구현
4. /skill:finishing-a-development-branch → 병합/PR
```

## 커스터마이징

### 기존 pi 설정과 병합

이미 `~/.pi/settings.json`이 있는 경우, 스クリ립트가 자동으로 skills 경로를 추가합니다.

수동으로 추가하려면:

```json
{
  "skills": [
    "/path/to/pi-superpowers/skills",
    "/other/skills/path"
  ],
  "enableSkillCommands": true
}
```

### Extension 비활성화

인트로 메시지가 필요 없으면 삭제하세요:

```bash
rm ~/.pi/agent/extensions/superpowers-intro.ts
```

## 원본 Superpowers

이 프로젝트는 [obra/superpowers](https://github.com/obra/superpowers)에서 파생되었습니다.

원본은 Claude Code, Codex, Cursor 등 다양한 에이전트를 지원합니다.

## 라이선스

MIT License - [obra/superpowers](https://github.com/obra/superpowers) 참조