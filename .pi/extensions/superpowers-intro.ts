/**
 * Superpowers for pi - Session Start Handler
 * 
 * 이 확장은 세션 시작 시 Superpowers 사용법에 대한 안내를 제공합니다.
 * 사용 가능한 skill 목록과 함께 간단한 소개를 보여줍니다.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// 사용 가능한 스킬 목록
const SUPERPOWERS_SKILLS = [
  { name: "brainstorming", desc: "코드 작성 전 디자인 탐색" },
  { name: "writing-plans", desc: "구현 계획 작성" },
  { name: "test-driven-development", desc: "테스트 우선 개발" },
  { name: "executing-plans", desc: "계획 실행 (배치 모드)" },
  { name: "systematic-debugging", desc: "체계적 디버깅" },
  { name: "requesting-code-review", desc: "코드 리뷰 요청" },
  { name: "finishing-a-development-branch", desc: "브랜치 완료" },
  { name: "using-git-worktrees", desc: "Git worktree 활용" },
  { name: "subagent-driven-development", desc: "서브에이전트 개발" },
  { name: "dispatching-parallel-agents", desc: "병렬 에이전트 실행" },
];

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (_event, ctx) => {
    const skillsList = SUPERPOWERS_SKILLS.map(
      (s) => `  • **${s.name}**: ${s.desc}`
    ).join("\n");

    const introMessage = `✨ **Superpowers 활성화됨!**

이 프로젝트에는 Superpowers软件开发方法론이 적용되어 있습니다.

**사용 가능한 Skill:**
${skillsList}

**사용법:**
\`/skill:brainstorming\` - 작업 시작 전 디자인 탐색 (필수!)
\`/skill:test-driven-development\` - TDD 방식으로 구현
\`/skill:systematic-debugging\` - 버그 해결 시 사용

**핵심 원칙:**
1. 코드 작성 전 항상 디자인을 탐색하세요
2. 테스트를 먼저 작성하세요 (TDD)
3. 작은 단위로 작업하고, 계획에 따라 진행하세요`;

    // 첫 세션인 경우에만 안내 메시지 표시
    const entries = ctx.sessionManager.getEntries();
    if (entries.length <= 2) {
      ctx.ui.notify("Superpowers loaded!", "info");
    }
  });
}