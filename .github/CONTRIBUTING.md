# WePLi iOS 프로젝트 기여 가이드라인

<div align="center">
  
  **WePLi 프로젝트에 참여해주셔서 감사합니다! 🥳**
  
  *모든 이슈와 Pull Request는 이 문서를 기반으로 진행되므로, 시작하기 전에 꼭 읽어주세요.*
  
</div>

---

## 🤝 행동 강령 (Code of Conduct)

모든 참여자는 서로를 존중하고 포용하는 태도를 유지해야 합니다. 건설적인 의견을 환영하며, 차별적인 언행이나 인신공격 등은 금지됩니다. 

> 📖 자세한 내용은 [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) 파일을 참고해주세요.

---

## 💡 이슈 생성 가이드

새로운 작업을 시작하기 전, **관련 이슈가 이미 있는지 검색으로 확인**해주세요. 

이슈를 생성할 때는 우리가 함께 만든 템플릿 중 가장 적절한 것을 선택하여 작성합니다:

### 이슈 템플릿 종류

| 템플릿 | 설명 | 필수 포함 사항 |
|--------|------|---------------|
| **Bug Report** 🐛 | 버그 신고 | • 재현 가능한 단계<br>• 실제 결과와 기대 결과<br>• 관련 로그나 스크린샷 |
| **Feature Request** ✨ | 기능 제안 | • 기능이 필요한 이유<br>• 해결하려는 문제<br>• 명확한 사용 시나리오 |
| **To-Do** ✅ | 작업 항목 | • 구체적인 작업 내용<br>• 완료 기준 |

---

## 🌳 브랜치 전략

우리는 **Git-flow 전략**을 따릅니다.

### 브랜치 설명

| 브랜치 | 용도 | 예시 |
|--------|------|------|
| `main` | 프로덕션 배포가 가능한 최종 브랜치 | - |
| `develop` | 다음 릴리즈를 위한 개발 통합 브랜치 | - |
| `feature/<주제>` | 새로운 기능 개발 | `feature/playlist-voting-ui` |
| `fix/<주제>` | 버그 수정 | `fix/login-crash` |

> ⚠️ **중요**: 모든 feature 브랜치는 `develop`에서 시작합니다.

---

## ✍️ 커밋 규칙

커밋 메시지는 작업 내용을 명확하게 전달할 수 있도록 **Prefix**를 사용합니다.

### 커밋 Prefix 가이드

| Prefix | 용도 | 예시 |
|--------|------|------|
| `[Feat]` | 새로운 기능 구현 | `[Feat]: 투표 기능 Reducer 구현 및 API 연동` |
| `[Fix]` | 버그 수정 및 문제 해결 | `[Fix]: 로그인 시 앱 크래시 문제 해결` |
| `[Design]` | UI 구현 및 뷰 관련 코드 수정 | `[Design]: 로그인 화면 UI 레이아웃 및 컴포넌트 추가` |
| `[Refactor]` | 코드 리팩토링 | `[Refactor]: 중복 코드 제거 및 함수 분리` |
| `[Docs]` | 문서 작업 (README, Wiki 등) | `[Docs]: API 사용법 문서 업데이트` |
| `[Test]` | 테스트 코드 추가 또는 수정 | `[Test]: 투표 기능 단위 테스트 추가` |
| `[Chore]` | 빌드, 환경설정, 패키지 구조 변경 등 | `[Chore]: SwiftLint 규칙 업데이트` |

---

## ✅ Pull Request(PR) 가이드

### PR 체크리스트

- [ ] PR은 반드시 **`develop` 브랜치**를 향해야 합니다
- [ ] `pull_request_template.md` 템플릿의 모든 항목을 작성했습니다
- [ ] UI 변경이 있을 경우, **스크린샷을 첨부**했습니다
- [ ] PR 제목은 커밋 규칙의 Prefix를 따릅니다
- [ ] CI 빌드를 통과했습니다
- [ ] 최소 1명 이상의 리뷰어 승인을 받았습니다

> 💡 **팁**: Draft PR을 적극 활용하여 작업 진행 상황을 공유하는 것을 권장합니다.

---

## 🎨 코드 스타일

### SwiftLint
- 프로젝트에 설정된 `.swiftlint.yml` 규칙을 **반드시 준수**해야 합니다
- 빌드 시 스크립트가 자동으로 실행됩니다

### 아키텍처: TCA (The Composable Architecture)

#### 핵심 원칙
- **State, Action, Reducer**를 사용하여 상태와 로직을 관리
- 의존성은 `@Dependency`를 사용하여 주입
- 모듈화 구조 준수

#### 모듈 구조

| 모듈 | 역할 |
|------|------|
| `WePLiKit` | 공통 UI 컴포넌트 |
| `WePLiCore` | 핵심 비즈니스 로직 |

---

## 🧪 테스트

- 새로운 기능을 추가할 때는 관련된 로직에 대한 **단위 테스트(Unit Test)** 작성을 권장합니다
- TCA의 `TestStore`를 활용하여 Reducer의 동작을 검증합니다

### 테스트 작성 예시

```
// TCA TestStore를 활용한 테스트 예제
func testVotingFeature() async {
    let store = TestStore(initialState: VotingFeature.State()) {
        VotingFeature()
    }
    
    await store.send(.voteButtonTapped) {
        $0.isVoting = true
    }
}
```

---

## 🚀 로컬 개발 빠른 시작

이 프로젝트는 **Tuist**를 사용하여 프로젝트를 관리합니다.

### 사전 준비
- ✅ Xcode가 설치되어 있어야 합니다
- ✅ Tuist를 [공식 가이드](https://docs.tuist.io/guides/quick-start/install)에 따라 설치해주세요

### 빠른 실행

프로젝트 루트에서 아래 명령어들을 순서대로 실행합니다:

```
# 1. 외부 라이브러리(SPM) 의존성을 설치합니다.
tuist install

# 2. Xcode 프로젝트 파일(.xcworkspace)을 생성합니다.
tuist generate

# 3. 생성된 WePLi.xcworkspace 파일을 엽니다.
open WePLi.xcworkspace
```

---

## 🔐 환경 변수와 시크릿

### ⚠️ 보안 규칙
- **절대** API 키나 시크릿 값을 코드에 커밋하지 않습니다
- `Configs` 폴더의 `.xcconfig` 파일을 통해 환경 변수를 관리합니다
- CI/CD 환경에서는 **GitHub Secrets**를 사용합니다

### 환경 변수 설정 예시

```
# Configs/Debug.xcconfig
API_BASE_URL = https://api-dev.wepli.com
API_KEY = ${SECRET_API_KEY}  # GitHub Secrets에서 주입
```

---

## 🤖 CI/CD

모든 PR은 `.github/workflows/ci.yml`에 정의된 **CI 워크플로우를 통과**해야 합니다.

### CI 체크 항목
- ✅ 코드 빌드 성공
- ✅ SwiftLint 규칙 통과
- ✅ 단위 테스트 통과
- ✅ UI 테스트 통과 (해당하는 경우)

> ❌ 빌드 실패나 린트 오류가 있는 코드는 머지할 수 없습니다.

---

## 📚 추가 리소스

- [TCA 공식 문서](https://pointfreeco.github.io/swift-composable-architecture/)
- [SwiftLint 규칙 가이드](https://realm.github.io/SwiftLint/rule-directory.html)
- [Tuist 문서](https://docs.tuist.io/)

---

<div align="center">
  
  **질문이 있으시면 언제든 이슈로 문의해주세요!** 💬
  
  *Happy Coding!* 🚀
  
</div>