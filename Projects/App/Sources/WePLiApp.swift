import SwiftUI

// MARK: - App Entry Point
@main
struct WePLiApp: App {
    var body: some Scene {
        WindowGroup {
            // 가장 기본적인 ContentView를 표시합니다.
            ContentView()
        }
    }
}

// MARK: - Content View
/// 앱이 실행될 때 가장 먼저 보여지는 기본 화면입니다.
struct ContentView: View {
    var body: some View {
        // 성공적으로 실행되었는지 확인할 수 있도록 간단한 텍스트를 표시합니다.
        VStack {
            Image(systemName: "music.note")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
            Text("Welcome to WePLi!")
                .font(.title)
        }
        .padding()
    }
}

