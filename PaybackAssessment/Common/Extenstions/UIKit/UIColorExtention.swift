//
//  UIColorExtention.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    convenience init(hexString: String) {
        if hexString.hasPrefix("#") {
            let index = hexString.index(hexString.startIndex, offsetBy: 1)
            let beginning = hexString[index...]
            var hexColor = String(beginning)
            if hexColor.count == 6 {
                hexColor = "ff\(hexColor)"
            }
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let newAlpha: CGFloat = CGFloat((hexNumber & 0xff000000) >> 24)
                let alpha: CGFloat = newAlpha / 255
                let newRed: CGFloat = CGFloat((hexNumber & 0x00ff0000) >> 16)
                let red: CGFloat = newRed / 255
                let newGreen: CGFloat = CGFloat((hexNumber & 0x0000ff00) >> 8)
                let green: CGFloat = newGreen / 255
                let newBlue: CGFloat = CGFloat(hexNumber & 0x000000ff)
                let blue: CGFloat = newBlue / 255
                self.init(red: red, green: green, blue: blue, alpha: alpha)
                return
            }
        }
        self.init(white: 1.0, alpha: 0.0)
    }
    
    convenience init(hexString: String, alpha: CGFloat? = nil) {
        if hexString.hasPrefix("#") {
            let index = hexString.index(hexString.startIndex, offsetBy: 1)
            let beginning = hexString[index...]
            var hexColor = String(beginning)
            if hexColor.count == 6 {
                hexColor = "ff\(hexColor)"
            }
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let alpha: CGFloat = alpha ?? 1.0
                let newRed: CGFloat = CGFloat((hexNumber & 0x00ff0000) >> 16)
                let red: CGFloat = newRed / 255
                let newGreen: CGFloat = CGFloat((hexNumber & 0x0000ff00) >> 8)
                let green: CGFloat = newGreen / 255
                let newBlue: CGFloat = CGFloat(hexNumber & 0x000000ff)
                let blue: CGFloat = newBlue / 255
                self.init(red: red, green: green, blue: blue, alpha: alpha)
                return
            }
        }
        self.init(white: 1.0, alpha: 0.0)
    }
    // swiftlint:disable:next function_body_length
    convenience init(colorName: Colors, alpha: CGFloat? = nil) { // swiftlint:disable:this cyclomatic_complexity
        switch colorName {
        case .appBlack:
            self.init(hexString: "#333333", alpha: alpha)
            return
        case .appWhite:
            self.init(hexString: "#FFFFFF", alpha: alpha)
            return
        case .appPrimaryGreen:
            self.init(hexString: "#008092", alpha: alpha)
        case .appLightBlue:
            self.init(hexString: "#4D7CFE", alpha: alpha)
        case .appBlue:
            self.init(hexString: "#007AFF")
        case .appSecondaryLightBlue:
            self.init(hexString: "#D8E0FC", alpha: alpha)
        case .appPrimaryDarkBlue:
            self.init(hexString: "#051B69", alpha: alpha)
        case .appPrimaryBlue:
            self.init(hexString: "#4663CD", alpha: alpha)
        case .appSecondaryGreen:
            self.init(hexString: "#46B4AD", alpha: alpha)
        case .appSecondaryBlue:
            self.init(hexString: "#3957C6", alpha: alpha)
        case .appBadgeGreen:
            self.init(hexString: "#40B4AE", alpha: alpha)
        case .appLightGray:
            self.init(hexString: "#F6F7FB", alpha: alpha)
        case .appMidGray:
            self.init(hexString: "#D8DCEC", alpha: alpha)
        case .appMidLightGray:
            self.init(hexString: "#D8D8D8", alpha: alpha)
        case .appGray:
            self.init(hexString: "#C6CEEF", alpha: alpha)
        case .appSecondaryDarkBlue:
            self.init(hexString: "#1432A3", alpha: alpha)
        case .appRed:
            self.init(hexString: "#D6083B", alpha: alpha)
        case .appPink:
            self.init(hexString: "#FBE6EC", alpha: alpha)
        case .appGreen:
            self.init(hexString: "#4BCA81", alpha: alpha)
        case .appGreenActiveState:
            self.init(hexString: "#08D68B", alpha: alpha)
        case .appGreenBG:
            self.init(hexString: "#D8ECEF", alpha: alpha)
        case .appLightBGGreen:
            self.init(hexString: "#E2F0EF", alpha: alpha)
        case .appYellow:
            self.init(hexString: "#FFB75D", alpha: alpha)
        case .appHintTextColor:
            self.init(hexString: "#848AA0", alpha: alpha)
        case .chatBubble:
            self.init(hexString: "#F1F5FF", alpha: alpha)
            
        case .appGreenBorder:
            self.init(hexString: "#008093", alpha: alpha)
        case .appDisabledBorder:
            self.init(hexString: "#ACB1C6", alpha: alpha)
        case .appDisabledTitleColor:
            self.init(hexString: "#939DC7", alpha: alpha)
            
        case .appWhiteBorder:
            self.init(hexString: "#FFFFFF", alpha: alpha)
        case .appInputDefaultBorder:
            self.init(hexString: "#C3CAE2", alpha: alpha)
        case .appInputFilledBorder:
            self.init(hexString: "#A3ADD0", alpha: alpha)
        case .appInputFilledBody:
            self.init(hexString: "#E7EAF5", alpha: alpha)
        case .appInputActiveBorder:
            self.init(hexString: "#4663CD", alpha: alpha)
        case .appInputErrorBorder:
            self.init(hexString: "#D6083B", alpha: alpha)
        case .appInputDisabledBorder:
            self.init(hexString: "#ADB4D2", alpha: alpha)
        case .appNavy:
            self.init(hexString: "#141F49", alpha: alpha)
        case .appVideoCallNavy:
            self.init(hexString: "#0E1737", alpha: alpha)
        case .appNavigationBarNavy:
            self.init(hexString: "#141F49", alpha: alpha)
        case .appShadow:
            self.init(hexString: "#7E87AF")
        case .appExtraLightRed:
            self.init(hexString: "#FBE6EC")
        case .tabbarSelectedColor:
            self.init(hexString: "#141F49", alpha: alpha)
        case .appBarButtonColor:
            self.init(hexString: "#4460D0", alpha: alpha)
        case .appCricleProgressBar:
            self.init(hexString: "#E3E7F7")
        case .appBorderColor:
            self.init(hexString: "#B9C6F6")
        case .progressDashColor:
            self.init(hexString: "#192F89")
        case .appTextFieldBorder:
            self.init(hexString: "#C0C6DC")
        case .appDarkBlack:
            self.init(hexString: "#000000", alpha: alpha)
        }
    }
    enum Colors {
        case appWhite
        case appBlack
        case appPrimaryGreen
        case appPrimaryDarkBlue
        case appPrimaryBlue
        case appLightBlue
        case appBlue
        case appSecondaryLightBlue
        case appSecondaryGreen
        case appSecondaryBlue
        case appBadgeGreen
        case appSecondaryDarkBlue
        case appLightGray
        case appMidGray
        case appMidLightGray
        case appGray
        case appRed
        case appPink
        case appGreen
        case appGreenActiveState
        case appGreenBG
        case appLightBGGreen
        case appYellow
        case appHintTextColor
        case appNavy
        case appVideoCallNavy
        case appNavigationBarNavy
        case appCricleProgressBar
        case tabbarSelectedColor
        case appBorderColor
        case chatBubble
        case appDarkBlack
        
        case appGreenBorder
        case appDisabledBorder
        case appDisabledTitleColor
        case appWhiteBorder
        case appInputDefaultBorder
        case appInputFilledBorder
        case appTextFieldBorder
        case appInputFilledBody
        case appInputActiveBorder
        case appInputErrorBorder
        case appInputDisabledBorder
        case appBarButtonColor
        
        case appShadow
        case appExtraLightRed
        case progressDashColor
    }
}

