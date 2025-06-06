//
//  Colors.swift
//  CampusNavigator
//
//  Created by Chathuri Maduka on 2025-06-04.
//

import SwiftUI
extension Color {
    static let appPrimaryBlue = Color(hex: "0A4F9A")
    static let appBackgroundGray = Color(hex: "F9FAFB")
    static let appWhite = Color.white
    static let appBlack = Color.black
    
    static let appLightBlue = Color(hex: "83BBF3")
    static let appRed = Color(hex: "E94040")
    static let appLightRed = Color(hex: "E94040") // Note: Same as red, you may want to adjust
    static let appDarkYellow = Color(hex: "EAD726")
    static let appLightYellow = Color(hex: "F2DC11")
    
    static let appLightGray = Color(hex: "F5F5F5")
    static let appDarkGray = Color(hex: "8E8E93")
    static let appBorderGray = Color(hex: "D1D1D6")
    static let appTextGray = Color(hex: "6D6D6D")
    static let appSuccess = Color(hex: "34C759")
    static let appError = Color(hex: "FF3B30")
    static let appWarning = Color(hex: "FF9500")
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


