//
//  ColorExtension.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/10.
//

import SwiftUI

/**
 컬러 이름에 대한 수정이 필요함.
 어떤 색깔인지 명시적으로 추측할 수 없음.
 디자이너와의 토의를 통해 컬러에 대한 네이밍을 하고, 현재 적용된 컬러를 대폭 수정하는 것이 필요.
 또한
 
 extension Color {
     /// Assets에 추가한 색상 사용하기 편하도록 extenstion 구현
     /// ```
     /// Ex)
     /// Text("Red Color")
     ///     .foregroundColor(Color.theme.red)
     /// ```
     static let theme = ColorTheme()
 }

 struct ColorTheme {
     let teGreen = Color("TennisGreen")
     let teSkyBlue = Color("TennisSkyBlue")
     let teBlue = Color("TennisBlue")
     let teBlack = Color("TennisBlack")
     let teRealBlack = Color("TennisRealBlack")
     let teDarkGray = Color("TennisDarkGray")
     let teLightGray = Color("TennisLightGray")
     let teGray = Color("TennisGray")
     let teWhite = Color("TennisWhite")
 }

 extension UIColor {
     static let theme = ColorTheme()
 }
 
 이런 식으로 extension을 활용하여 Color에서 일어날 수 있는 네이밍 충돌을 방지하여야 함.
 
 */
extension Color {
    static let backgroundColor = Color("backgroundColor")
    static let subGray = Color("subGray")
    static let mainSection = Color("mainSection")
    static let mainSection2 = Color("mainSection2")
    static let mainSection3 = Color("mainSection3")
    static let iconColor = Color("iconColor")
    static let bunnyColor = Color("bunnyColor")
    static let bunnyColorSub = Color("bunnyColorSub")
    static let mainTextColor = Color("mainTextColor")
    static let subTextColor = Color("subTextColor")
}
