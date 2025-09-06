#!/usr/bin/env bash
set -eo pipefail

# SwiftLint가 없으면 스킵(로컬/CI 잡음 방지)
if ! command -v swiftlint >/dev/null 2>&1; then
  echo "[SwiftLint] not installed, skipping"
  # 출력 파일을 만들어서 Xcode가 작업 완료로 인식하게 함
  mkdir -p "$DERIVED_FILE_DIR" 2>/dev/null || true
  touch "$DERIVED_FILE_DIR/SwiftLint.done"
  exit 0
fi

# 조용히(lint 결과만) 실행
swiftlint --quiet

# 출력 파일 터치(의존성 분석용)
mkdir -p "$DERIVED_FILE_DIR" 2>/dev/null || true
touch "$DERIVED_FILE_DIR/SwiftLint.done"