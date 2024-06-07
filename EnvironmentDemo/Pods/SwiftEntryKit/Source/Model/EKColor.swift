//
//  EKColor.swift
//  SwiftEntryKit
//
//  Created by Daniel on 21/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/** A color representation attribute as per user interface style */
public struct EKColor: Equatable {
    
    // MARK: - Properties
    
    public private(set) var dark: UIColor
    public private(set) var light: UIColor
    
    // MARK: - Setup
    
    public init(light: UIColor, dark: UIColor) {
        self.light = light
        self.dark = dark
    }
    
    public init(_ unified: UIColor) {
        self.light = unified
        self.dark = unified
    }
    
    public init(rgb: Int) {
        dark = UIColor(rgb: rgb)
        light = UIColor(rgb: rgb)
    }
    
    public init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        let color = UIColor(red: CGFloat(red) / 255.0,
                            green: CGFloat(green) / 255.0,
                            blue: CGFloat(blue) / 255.0,
                            alpha: 1.0)
        light = color
        dark = color
    }
    
    /** Computes the proper UIColor */
    public func color(for traits: UITraitCollection,
                      mode: EKAttributes.DisplayMode) -> UIColor {
        switch mode {
        case .inferred:
            if #available(iOS 13, *) {
                switch traits.userInterfaceStyle {
                case .light, .unspecified:
                    return light
                case .dark:
                    return dark
                @unknown default:
                    return light
                }
            } else {
                return light
            }
        case .light:
            return light
        case .dark:
            return dark
        }
    }
}

public extension EKColor {
    
    /// Returns the inverse of `self` (light and dark swapped)
    var inverted: EKColor {
        return EKColor(light: dark, dark: light)
    }
    
    /** Returns an `EKColor` with the specified alpha component */
    func with(alpha: CGFloat) -> EKColor {
        return EKColor(light: light.withAlphaComponent(alpha),
                       dark: dark.withAlphaComponent(alpha))
    }
    
    /** White color for all user interface styles */
    static var white: EKColor {
        return EKColor(.white)
    }
    
    /** Black color for all user interface styles */
    static var black: EKColor {
        return EKColor(.black)
    }
    
    /** Clear color for all user interface styles */
    static var clear: EKColor {
        return EKColor(.clear)
    }
    
    
    
    /** Clear color for all user interface styles */
    static var red: EKColor {
        return EKColor(.red)
    }
    
    /** Color that represents standard background. White for light mode, black for dark mode */
    static var standardBackground: EKColor {
        return EKColor(light: .white, dark: .black)
    }
    
    /** Color that represents standard content. black for light mode, white for dark mode */
    static var standardContent: EKColor {
        return EKColor(light: .black, dark: .white)
    }
}

struct Color {
    struct BlueGray {
        static let c50 = EKColor(rgb: 0xeceff1)
        static let c100 = EKColor(rgb: 0xcfd8dc)
        static let c300 = EKColor(rgb: 0x90a4ae)
        static let c400 = EKColor(rgb: 0x78909c)
        static let c700 = EKColor(rgb: 0x455a64)
        static let c800 = EKColor(rgb: 0x37474f)
        static let c900 = EKColor(rgb: 0x263238)
    }
    
    struct Netflix {
        static let light = EKColor(rgb: 0x485563)
        static let dark = EKColor(rgb: 0x29323c)
    }
    
    struct Gray {
        static let a800 = EKColor(rgb: 0x424242)
        static let mid = EKColor(rgb: 0x616161)
        static let light = EKColor(red: 230, green: 230, blue: 230)
    }
    
    struct Purple {
        static let a300 = EKColor(rgb: 0xba68c8)
        static let a400 = EKColor(rgb: 0xab47bc)
        static let a700 = EKColor(rgb: 0xaa00ff)
        static let deep = EKColor(rgb: 0x673ab7)
    }
    
    struct BlueGradient {
        static let light = EKColor(red: 100, green: 172, blue: 196)
        static let dark = EKColor(red: 27, green: 47, blue: 144)
    }
    
    struct Yellow {
        static let a700 = EKColor(rgb: 0xffd600)
    }
    
    struct Teal {
        static let a700 = EKColor(rgb: 0x00bfa5)
        static let a600 = EKColor(rgb: 0x00897b)
    }
    
    struct Orange {
        static let a50 = EKColor(rgb: 0xfff3e0)
    }
    
    struct LightBlue {
        static let a700 = EKColor(rgb: 0x0091ea)
    }
    
    struct LightPink {
        static let first = EKColor(rgb: 0xff9a9e)
        static let last = EKColor(rgb: 0xfad0c4)
    }
}
