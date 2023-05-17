# MC2-Team2-BurningBuddy

<div align="center">
 <img alt="BurningBuddy" src="https://github.com/DeveloperAcademy-POSTECH/MC2-Team2-BurningBuddy/assets/97583162/2b51780e-0e2b-4538-ba58-f5f936bfd610">

 ### _**🐰🔥 Burning Buddy 🔥🐰**_
 _**회오나(회원님 오늘은 나오실거죠?)팀의 소중한 사람들을 위한 앱 ❤️**_ 
 </div>
 
 
### 🐰 About Burning Buddy
> 📅 프로젝트 기간: 2023.04.10 - 2023.05.19


운동을 하기로 마음먹은 헬린이인 당신! 항상 운동을 시작한지 3일만에 포기를 선언하는 그대를 위한 어플입니다. 
혼자가 아닌, 함께하는 운동을 통해 당신의 캐릭터를 성장시키세요! 파트너와 당신이 모두 목표한 하루치 운동을 수행한다면
당신과 파트너의 캐릭터는 쑥쑥 성장하며 진화합니다!
100일 동안 습관이 만들어진다는 66일의 운동 과정을 파트너와 함께 성공한다면 캐릭터의 최종 진화 단계까지 볼 수 있습니다.
<br>
<br>
 
 ### 🧑‍💻 Authors
> 회원님 오늘 나오실거죠~? (A.K.A 회오나)

|[<img src="https://github.com/kpk0616.png" width="100px">](https://github.com/kpk0616)|[<img src="https://github.com/jay1261.png" width="100px">](https://github.com/jay1261)|[<img src="https://github.com/bokoo14.png" width="100px">](https://github.com/bokoo14)|[<img src="https://github.com/DhKimy.png" width="100px">](https://github.com/DhKimy)|[<img src="https://github.com/yeeun223.png" width="100px">](https://github.com/yeeun223)|[<img src="https://github.com/Hanyeonggyun.png" width="100px">](https://github.com/Hanyeonggyun)|  
|:----:|:----:|:----:|:----:|:----:|:----:|
|[West](https://github.com/kpk0616)|[Jay](https://github.com/jay1261)|[Luna](https://github.com/bokoo14)|[Bazzi](https://github.com/DhKimy)|[Yena](https://github.com/yeeun223)|[Muho](https://github.com/Hanyeonggyun)|  
<br>

 ### 📱 Screenshots
|Onboarding|Initial Setting|Setting|
|:-:|:-:|:-:|
|![1](https://github.com/DeveloperAcademy-POSTECH/MC2-Team2-BurningBuddy/assets/70744494/9ed3be2b-5694-4c48-8f70-315d099cd84a)|![닉네임:캐릭터이름:칼로리설정](https://github.com/DeveloperAcademy-POSTECH/MC2-Team2-BurningBuddy/assets/70744494/1733bc6e-8282-4bdd-8760-966c649b9ce5)|![세팅](https://github.com/DeveloperAcademy-POSTECH/MC2-Team2-BurningBuddy/assets/70744494/c513a6d9-3a87-4823-ab0a-a41178ecafca)|
|Character Roadmap|NI Interaction|Workout Done|
|![인포](https://github.com/DeveloperAcademy-POSTECH/MC2-Team2-BurningBuddy/assets/70744494/e0a9fbfe-6c9f-4054-8c7e-f4bda4d3454c)|![운동중](https://github.com/DeveloperAcademy-POSTECH/MC2-Team2-BurningBuddy/assets/70744494/42b87679-ebf2-4a2e-8a64-789882c0a8a2)|![운동완료](https://github.com/DeveloperAcademy-POSTECH/MC2-Team2-BurningBuddy/assets/70744494/a5dc3860-81a5-4988-85fb-85bd2cdb46ac)|
<br>

---
### 🛠 Development Environment
<img width="80" src="https://img.shields.io/badge/IOS-16%2B-silver"> <img width="95" src="https://img.shields.io/badge/Xcode-14.3-blue">
<br>

### :sparkles: Skills & Tech Stack
* SwiftUI
* Code base
* Core Data
* Nearby Interaction
* Multipeer Connectivity
* HealthKit
<br>

### 🎁 Library
```swift
import SwiftUI
import UIKit
import CoreData
import NearbyInteraction
import MultipeerConnectivity
import Network
import HealthKit
```
<br>

### 🗂 Folder Structure
작성 예정
<br>
 
### 🔀 Git branch & Git Flow
1. Git Convention
  - `[Hotfix]` : issue나, QA에서 급한 버그 수정에 사용
  - `[Fix]` : 버그, 오류 해결
  - `[Add]` : Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시
  - `[Style]` : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
  - `[Feat]` : 새로운 기능 구현
  - `[Del]` : 쓸모없는 코드 삭제
  - `[Docs]` : README나 WIKI 등의 문서 개정
  - `[Chore]` : 코드 수정, 내부 파일 수정, 빌드 업무 수정, 패키지 매니저 수정
  - `[Correct]` : 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용합니다.
  - `[Move]` : 프로젝트 내 파일이나 코드의 이동
  - `[Rename]` : 파일 이름 변경이 있을 때 사용합니다.
  - `[Refactor]` : 전면 수정이 있을 때 사용합니다
  - `[Init]` : Initial Commit
2. Branch 전략
  - `main` : 개발이 완료된 산출물이 저장될 공간
  - `develop` : feature 브랜치에서 구현된 기능들이 merge될 브랜치
  - `feature` : 기능을 개발하는 브랜치, 이슈별/작업별로 브랜치를 생성하여 기능을 개발한다
  - `release` : 릴리즈를 준비하는 브랜치, 릴리즈 직전 QA 기간에 사용한다
  - `hotfix` : 버그를 수정하는 브랜치
<br>

### :lock_with_ink_pen: License
<img width="100" src="https://img.shields.io/badge/MIT License-2.0-yellow">
<br><br>
