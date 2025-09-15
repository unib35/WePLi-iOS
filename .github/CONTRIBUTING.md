WePLi iOS 프로젝트 기여 가이드라인
WePLi 프로젝트에 참여해주셔서 감사합니다! 🥳

모든 이슈와 Pull Request는 이 문서를 기반으로 진행되므로, 시작하기 전에 꼭 읽어주세요.

🤝 행동 강령 (Code of Conduct)
모든 참여자는 서로를 존중하고 포용하는 태도를 유지해야 합니다. 건설적인 의견을 환영하며, 차별적인 언행이나 인신공격 등은 금지됩니다. 자세한 내용은 CODE_OF_CONDUCT.md 파일을 참고해주세요.

💡 이슈 생성 가이드
새로운 작업을 시작하기 전, 관련 이슈가 이미 있는지 검색으로 확인해주세요. 이슈를 생성할 때는 우리가 함께 만든 템플릿(To-Do, Bug Report, Feature Request) 중 가장 적절한 것을 선택하여 작성합니다.

버그 리포트: 재현 가능한 단계, 실제 결과와 기대 결과를 명확히 작성하고, 관련 로그나 스크린샷을 첨부하면 좋습니다.

기능 제안: 이 기능이 왜 필요한지, 어떤 문제를 해결하는지 명확한 시나리오를 제시해주세요.

🌳 브랜치 전략
우리는 Git-flow 전략을 따릅니다.

main: 프로덕션 배포가 가능한, 가장 안정적인 최종 브랜치입니다.

develop: 다음 릴리즈를 위한 최신 개발 내용이 통합되는 브랜치입니다. 모든 feature 브랜치는 develop에서 시작합니다.

feature/<주제>: 새로운 기능을 개발하는 브랜치입니다. (예: feature/playlist-voting-ui)

fix/<주제>: 버그를 수정하는 브랜치입니다. (예: fix/login-crash)

✍️ 커밋 규칙
커밋 메시지는 작업 내용을 명확하게 전달할 수 있도록 Prefix를 사용합니다.

[Feat]: 새로운 기능 구현

[Fix]: 버그 수정 및 문제 해결

[Design]: UI 구현 및 뷰 관련 코드 수정

[Refactor]: 코드 리팩토링

[Docs]: 문서 작업 (README, Wiki 등)

[Test]: 테스트 코드 추가 또는 수정

[Chore]: 빌드, 환경설정, 패키지 구조 변경 등 기타 잡일성 작업

예시:
[Feat]: 투표 기능 Reducer 구현 및 API 연동
[Design]: 로그인 화면 UI 레이아웃 및 컴포넌트 추가

✅ Pull Request(PR) 가이드
PR은 반드시 develop 브랜치를 향해야 합니다.

pull_request_template.md 템플릿의 모든 항목을 꼼꼼하게 작성해주세요.

UI 변경이 있을 경우, 반드시 스크린샷을 첨부해야 합니다.

PR의 제목은 커밋 규칙의 Prefix를 따릅니다.

Draft PR을 적극 활용하여 작업 진행 상황을 공유하는 것을 권장합니다.

모든 PR은 CI 빌드를 통과하고, 최소 1명 이상의 리뷰어에게 승인받아야 머지할 수 있습니다.

🎨 코드 스타일
SwiftLint: 프로젝트에 설정된 .swiftlint.yml 규칙을 반드시 준수해야 합니다. 빌드 시 스크립트가 자동으로 실행됩니다.

아키텍처: TCA(The Composable Architecture)와 모듈화 구조를 따릅니다.

State, Action, Reducer를 사용하여 상태와 로직을 관리합니다.

의존성은 @Dependency를 사용하여 주입합니다.

공통 UI 컴포넌트는 WePLiKit 모듈에, 핵심 로직은 WePLiCore에 정의합니다.

🧪 테스트
새로운 기능을 추가할 때는 관련된 로직에 대한 단위 테스트(Unit Test)를 작성하는 것을 권장합니다.

TCA의 TestStore를 활용하여 Reducer의 동작을 검증합니다.

🚀 로컬 개발 빠른 시작
이 프로젝트는 Tuist를 사용하여 프로젝트를 관리합니다.

사전 준비: Xcode가 설치되어 있어야 합니다. Tuist는 tuist/tuist-action에 의해 CI 환경에서 자동으로 설치되지만, 로컬에서는 공식 가이드에 따라 설치해주세요.

빠른 실행: 아래 명령어들을 프로젝트 루트에서 순서대로 실행합니다.

# 1. 외부 라이브러리(SPM) 의존성을 설치합니다.
tuist install

# 2. Xcode 프로젝트 파일(.xcworkspace)을 생성합니다.
tuist generate

# 3. 생성된 WePLi.xcworkspace 파일을 엽니다.
open WePLi.xcworkspace

🔐 환경 변수와 시크릿
실제 API 키나 시크릿 값은 절대 코드에 커밋하지 않습니다.

Configs 폴더의 .xcconfig 파일을 통해 환경 변수를 관리합니다.

CI/CD 환경에서는 GitHub Secrets를 사용합니다.

🤖 CI/CD
모든 PR은 .github/workflows/ci.yml에 정의된 CI 워크플로우를 통과해야 합니다.

빌드 실패나 린트 오류가 있는 코드는 머지할 수 없습니다.