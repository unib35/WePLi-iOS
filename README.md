# WePLi - 우리들의 플레이리스트 🎶

**함께 음악을 추천하고 투표하여 플레이리스트를 만들어가는 소셜 뮤직 앱**

## ✨ 주요 기능

-   **주제별 플레이리스트 투표**: '비 오는 날 듣고 싶은 노래'와 같은 주제에 어울리는 곡을 함께 추천하고 투표하여 최종 플레이리스트를 완성합니다.
-   **커뮤니티**: 내가 좋아하는 음악을 포스트에 첨부하여 다른 사용자들과 음악 취향을 공유하고 소통합니다.
-   **뮤직 포토카드**: 나만의 '인생 곡'으로 포토카드를 만들어 프로필을 꾸미고 공유합니다.

## 🛠️ 기술 스택 및 아키텍처

-   **UI**: SwiftUI
-   **Architecture**: TCA (The Composable Architecture)
-   **Project Management**: Tuist (Modular Architecture)
-   **Dependency Management**: Swift Package Manager
-   **CI/CD**: GitHub Actions
-   **Code Quality**: SwiftLint, SwiftFormat

## 🚀 시작하기

### 사전 준비

-   Xcode 15.4 이상
-   Tuist 4.x
-   Homebrew

### 로컬에서 실행하기

1.  **레포지토리 클론**:
    ```bash
    git clone [https://github.com/unib35/WePLi-iOS.git](https://github.com/unib35/WePLi-iOS.git)
    cd WePLi-iOS
    ```

2.  **환경 설정 파일 복사**:
    ```bash
    cp Configs/Sample.xcconfig Configs/Dev.xcconfig
    ```
    > `Configs/Dev.xcconfig` 파일을 열어 필요한 API 키를 입력해주세요.

3.  **의존성 설치 및 프로젝트 생성**:
    ```bash
    tuist install
    tuist generate
    ```

4.  **프로젝트 열기**:
    생성된 `WePLi.xcworkspace` 파일을 Xcode로 열고 `WePLi` 스킴을 실행합니다.

---

## 🤝 기여 방법

프로젝트에 기여하고 싶으시다면, 먼저 `.github/CONTRIBUTING.md` 문서를 참고해주세요. 모든 이슈와 Pull Request는 환영입니다!