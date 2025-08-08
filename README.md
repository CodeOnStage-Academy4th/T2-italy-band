# 🗿 ltaylband (이탈리아 밴드)

> 집중력 향상을 위한 포모도로 스타일 iOS 앱 - 귀여운 돌 캐릭터와 함께 집중하세요!

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)]()
[![SwiftUI](https://img.shields.io/badge/SwiftUI-iOS%2017+-blue.svg)]()
[![Xcode](https://img.shields.io/badge/Xcode-15.0+-blue.svg)]()

---

## 🗂 목차
- [소개](#-소개)
- [주요 기능](#-주요-기능)
- [기술 스택](#-기술-스택)
- [폴더 구조](#-폴더-구조)
- [설치 및 실행](#-설치-및-실행)
- [화면 구성](#-화면-구성)
- [데이터 모델](#-데이터-모델)
- [팀 소개](#-팀-소개)
- [라이선스](#-라이선스)

---

## 📱 소개

ltaylband(이탈리아 밴드)는 집중력 향상을 도와주는 iOS 앱입니다. 
사용자가 집중한 시간에 따라 성장하는 귀여운 돌 캐릭터들과 함께 포모도로 기법을 활용해 
효과적인 집중 시간 관리를 할 수 있습니다.

## 🌟 주요 기능

- ✅ **타이머 기반 집중 모드**: 포모도로 스타일의 집중 타이머
- ✅ **돌 캐릭터 시스템**: 6가지 테마의 귀여운 돌 캐릭터
- ✅ **등급 시스템**: 집중 시간에 따른 5단계 등급 (조약돌 → 화강암 → 자수정 → 에메랄드 → 다이아몬드)
- ✅ **캐릭터 커스터마이징**: 다양한 스킨 선택 (초또로, 죄수돌, 돌인블랙, 군도리, 꿀빠리, 싼트아돌)
- ✅ **애니메이션 효과**: 집중 중 돌이 움직이는 애니메이션
- ✅ **시간 추적**: 누적 집중 시간 관리 및 등급 자동 승급

## 🛠 기술 스택

### 프레임워크 & 언어
- **Swift 5.9+**
- **SwiftUI** - 선언형 UI 프레임워크
- **SwiftData** - 데이터 영속성 관리
- **Combine** - 비동기 프로그래밍

### 아키텍처
- **MV 패턴**
- **Router 기반 네비게이션**
- **ObservableObject** 상태 관리

### 개발 도구
- **Xcode 15.0+**
- **iOS 17+ 타겟**

## 🧱 폴더 구조

```
📦 ltaylband
┣ 📂 Model/
┃ ┣ 📄 Rock.swift          # 돌 데이터 모델
┃ ┣ 📄 Grade.swift         # 등급 열거형
┃ ┗ 📄 RockDataManager.swift # 데이터 관리 클래스
┣ 📂 View/
┃ ┣ 📂 Main/
┃ ┃ ┣ 📂 Home/
┃ ┃ ┃ ┗ 📄 HomeView.swift   # 메인 홈 화면
┃ ┃ ┗ 📂 Rock/
┃ ┃   ┗ 📄 RockView.swift   # 돌 관련 뷰
┃ ┣ 📂 Lock/
┃ ┃ ┣ 📄 LockView.swift     # 집중 타이머 화면
┃ ┃ ┗ 📄 EndConfirmView.swift # 종료 확인 화면
┃ ┣ 📂 Grade/
┃ ┃ ┗ 📄 RockGradeView.swift # 등급 화면
┃ ┗ 📂 Custom/
┃   ┣ 📄 RockCoustomView.swift # 돌 커스텀 화면
┃   ┗ 📄 SelRock.swift      # 돌 선택 컴포넌트
┣ 📂 Router/
┃ ┣ 📄 AppRouter.swift      # 앱 라우터
┃ ┣ 📄 RootView.swift       # 루트 뷰
┃ ┗ 📄 RouteView.swift      # 라우트 뷰
┣ 📂 Set/
┃ ┣ 📄 ColorSet.swift       # 컬러 시스템
┃ ┗ 📄 FontSet.swift        # 폰트 시스템
┗ 📂 Assets.xcassets/       # 이미지 및 컬러 리소스
```

## ⚙️ 설치 및 실행

### 요구사항
- macOS Sonoma 14.0+
- Xcode 15.0+
- iOS 17.0+ (시뮬레이터 또는 실제 기기)

### 실행 방법
1. 저장소 클론
```bash
git clone https://github.com/CodeOnStage-Academy4th/italy-band.git
cd italy-band
```

2. Xcode에서 프로젝트 열기
```bash
open Projects/ltaylband/ltaylband.xcodeproj
```

3. 시뮬레이터 설정 및 실행
- iPhone 15 (iOS 17+) 선택
- `Cmd + R`로 앱 실행

## 📱 화면 구성

### 메인 화면 (HomeView)
- 현재 돌 캐릭터 표시
- 누적 집중 시간 표시 (HH:MM:SS 형식)
- 현재 등급 아이콘
- "집중하기" 버튼

### 집중 화면 (LockView)
- 실시간 타이머 (57pt 대형 폰트)
- 애니메이션되는 돌 캐릭터 (0.3초마다 프레임 변경)
- 일시정지 버튼
- 종료 확인 다이얼로그

### 커스터마이징 화면 (RockCoustomView)
- 6가지 돌 스킨 선택
- 각 스킨별 고유한 테마와 설명

### 등급 화면 (RockGradeView)
- 5단계 등급 시스템 표시
- 등급별 배경 이미지 및 아이콘

## 🗃 데이터 모델

### Rock Model
```swift
@Model
final class Rock: Identifiable {
    var id: UUID           # 고유 식별자
    var spentTime: Int     # 누적 집중 시간 (초)
    var grade: Grade       # 현재 등급
    var skin: String       # 선택된 스킨
}
```

### Grade System
```swift
enum Grade: String, CaseIterable {
    case joyakdol = "조약돌"      # 0-99초
    case hawgangam = "화강암"     # 100-199초
    case jasujeong = "자수정"     # 200-299초
    case emerald = "에메랄드"     # 300-399초
    case diamond = "다이아몬드"   # 400초+
}
```

### 캐릭터 스킨
1. **초또로** - 이탈리아 출신의 깔끔하고 담백한 매력덩어리 돌
2. **죄수돌** - 산만함을 훔쳐가는 죄수돌!
3. **돌인블랙** - 외계 생명체로부터 세상을 지키는 비밀요원 돌
4. **군도리** - 안전함을 보장하고 충성을 다하는 군돌
5. **꿀빠리** - 나는 더이상 돌이 아니다. 행복을 위해 벌이된 돌
6. **싼트아돌** - 집중력을 선물하러 온 산타돌

## 🧑‍💻 팀 소개

| 이름 | 역할 | GitHub |
|------|------|--------|
| 김재윤 | iOS Developer | [@yourhandle](https://github.com/yourhandle) |

## 🔖 Git 컨벤션

### 브랜치 전략
- `main`: 배포 가능한 안정 버전
- `dev`: 통합 개발 브랜치  
- `feature/*`: 기능 개발 브랜치
- `refector/*`: 리팩토링 브랜치
- `design/*`: 디자인 작업 브랜치

### 커밋 메시지 컨벤션
[Gitmoji](https://gitmoji.dev) 사용

**예시:**
- ✨ feat: 메인뷰에서 돌 커지는거 해결 완료
- 🎨 design: 메인뷰 하이파이 반영
- ♻️ refactor: 데이터 모델 구조 정리

## 🎨 디자인 시스템

### 컬러 팔레트
- `ColorSet.black80`, `ColorSet.rock100`, `ColorSet.rock200` 등 정의
- 등급별 테마 컬러 및 배경 이미지

### 폰트
- **EF_jejudoldam**: 커스텀 한글 폰트 (OTF/TTF)
- 다양한 사이즈 지원 (._22, ._26, ._57 등)

## 📝 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.
