# WePLi iOS 프로젝트 명세서

## 1. 프로젝트 개요 (Project Overview)

- **프로젝트 명**: WePLi (우리들의 플레이리스트)
- **한 줄 요약**: 사용자들이 투표를 통해 특정 주제의 플레이리스트를 함께 만들고, 자신의 음악 취향을 공유하는 소셜 뮤직 앱.
- **핵심 가치**: **참여, 발견, 공유.** 혼자 듣던 음악을 '함께' 즐기는 경험을 제공하여 새로운 음악을 발견하고 취향이 맞는 사람들과 연결되는 것을 목표로 한다.

---

## 2. 핵심 기능 상세 (Key Features)

- **주제별 플레이리스트 투표 (Themed Playlist Voting)**: 관리자가 제시하는 주제(예: '비 오는 날 듣고 싶은 노래')에 대해 사용자들이 곡을 추천하고 투표하여 최종 플레이리스트를 완성하는 핵심 협업 기능.
- **커뮤니티 피드 (Community Feed)**: 사용자가 좋아하는 음악을 자신의 이야기와 함께 공유하고 '좋아요'와 '댓글'로 소통하는 공간.
- **뮤직 포토카드 및 마이페이지 (Music Photocard & My Page)**: 사용자의 음악적 정체성을 표현하는 프로필. 좋아하는 곡으로 '뮤직 포토카드'를 만들어 공유하는 기능.

---

## 3. 기술 아키텍처 (Technical Architecture)

이 프로젝트는 **SwiftUI**를 기반으로 하며, **The Composable Architecture (TCA)**를 핵심 아키텍처로 채택했다. 프로젝트 관리는 **Tuist**를 통해 모듈화(Modular Architecture) 접근 방식을 유지한다.

- **아키텍처 선택 이유**:
    - **TCA**: 단방향 데이터 흐름을 강제하여 예측 가능하고 테스트하기 쉬운 코드를 작성할 수 있다. 특히 Tuist 모듈 구조와 결합하여 각 기능(`Feature`)을 독립적인 상태 머신으로 관리하기에 최적이다.
    - **Tuist**: 기능별 모듈 분리를 통해 빌드 속도를 높이고, 코드의 책임과 의존성을 명확하게 관리한다.

- **모듈 구조 및 역할**:
    - `Projects/App`
        - **WePLi (App)**: 최종 앱 타겟. TCA의 `Store`를 초기화하고 모든 `Features` 모듈을 통합하는 앱의 진입점.
    - `Projects/Features` (각 모듈은 독립적인 TCA Feature로 구성)
        - **WePLiAuth**: 로그인, 회원가입 로직을 담은 Reducer와 관련 View.
        - **WePLiVoting**: 투표 로직, 상태 관리를 위한 Reducer와 SwiftUI View.
        - **WePLiCommunity**: 피드 데이터 관리, 게시글 상호작용을 처리하는 Reducer와 View.
        - **WePLiMyPage**: 사용자 프로필, 포토카드 생성 로직을 담은 Reducer와 View.
        - **WePLiSearch**: 노래 검색 API 연동 및 결과 표시를 위한 Reducer와 View.
    - `Projects/Core`
        - **WePLiCore**: 네트워킹 클라이언트, 데이터 모델(DTOs, Entities) 등 TCA의 `DependencyKey`를 통해 각 Feature에 주입될 핵심 로직.
        - **WePLiKit**: 디자인 시스템. 재사용 가능한 SwiftUI 뷰(예: `PrimaryButton`, `AlbumArtView`)와 ViewModifier.
        - **WePLiResource**: `Assets.xcassets`, 폰트, `Localizable.strings` 등 리소스.

---

## 4. 기술 스택 (Technology Stack)

- **언어**: **Swift**
- **UI 프레임워크**: **SwiftUI**
- **아키텍처 패턴**: **The Composable Architecture (TCA)**
- **프로젝트 관리**: **Tuist**
- **의존성 관리**: **Swift Package Manager (SPM)**
- **주요 외부 라이브러리**:
    - **`swift-composable-architecture`**: 상태 관리 및 아키텍처의 핵심.
    - **`Kingfisher`**: SwiftUI의 `KFImage`를 사용한 비동기 이미지 로딩 및 캐싱.
    - **`Moya`**: TCA의 Effect와 통합하여 타입-세이프한 네트워킹 구현.
    - **`GoogleSignIn-iOS`**: 구글 소셜 로그인 기능 구현.
    - **`lottie-ios`**: SwiftUI에서 사용 가능한 Lottie 애니메이션.

---

## 5. 개발 가이드라인 (Development Guidelines)

- **TCA 원칙 준수**: 모든 상태 변경은 `Action`을 통해 `Reducer` 내에서만 이루어져야 한다. Side Effect(네트워크 요청 등)는 반드시 `Effect`를 통해 관리한다.
- **의존성 주입**: 네트워킹 클라이언트, UserDefaults 등 외부 의존성은 `@Dependency` 프로퍼티 래퍼를 사용하여 주입한다. Live, Preview, Test 용도로 의존성을 쉽게 교체할 수 있도록 설계한다.
- **브랜치 전략**: Git-flow (feature -> develop -> release -> main).
- **커밋 메시지**: `[Feat] 투표 기능 Reducer 구현`, `[Fix] 커뮤니티 View 레이아웃 수정`과 같이 Conventional Commits 형식을 따른다.

---

## 6. AI 어시스턴트 활용 가이드 (How to use AI Assistant)

이 프로젝트에 대해 질문할 때, 아래 원칙을 따라주세요.

1.  **TCA 기반 답변**: 모든 코드 예제와 아키텍처 제안은 **SwiftUI**와 **TCA**를 기반으로 작성해주세요. `State`, `Action`, `Reducer`, `Store`, `ViewStore`, `Dependency` 등의 TCA 개념을 적극적으로 활용해주세요.
2.  **모듈 구조 인지**: "투표하기 버튼의 로직을 알려줘"라고 질문하면, "WePLiVoting 모듈의 `VotingView`에서 `store.send(.voteButtonTapped)` 액션을 보내고, `VotingReducer`에서 관련 로직을 처리합니다."와 같이 구체적인 모듈과 파일 내 역할을 명시해주세요.
3.  **의존성 주입 고려**: 네트워크 요청이나 데이터베이스 접근 로직을 제안할 때는 `@Dependency`를 사용해 의존성을 주입하고 Effect 내에서 호출하는 방식을 보여주세요.
4.  **디자인 시스템 활용**: UI 컴포넌트 생성 시, `WePLiKit`에 정의된 커스텀 뷰를 활용하는 코드를 제안해주세요.