fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios bootstrap

```sh
[bundle exec] fastlane ios bootstrap
```

처음 개발 환경 부트스트랩

### ios build_debug

```sh
[bundle exec] fastlane ios build_debug
```

Debug 빌드

### ios test

```sh
[bundle exec] fastlane ios test
```

단위 테스트 실행

### ios archive_release

```sh
[bundle exec] fastlane ios archive_release
```

App Store 제출용 아카이브

### ios beta_api_key

```sh
[bundle exec] fastlane ios beta_api_key
```

TestFlight 업로드 (API Key)

### ios beta_apple_id

```sh
[bundle exec] fastlane ios beta_apple_id
```

TestFlight 업로드 (Apple ID 세션)

### ios bump_build

```sh
[bundle exec] fastlane ios bump_build
```

빌드번호 자동 증가

### ios ci

```sh
[bundle exec] fastlane ios ci
```

CI 파이프라인

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
