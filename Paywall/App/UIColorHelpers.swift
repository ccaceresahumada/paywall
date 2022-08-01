//
//  UIColorHelpers.swift
//  Paywall
//
//  Copyright © 2020 Disney Streaming. All rights reserved.
//

import UIKit

extension UIColor {
  /// Initializes a color object from a hexadecimal RGBA quadruplet in the form `"#rrggbbaa"`.
  public convenience init?(hex: String) {
    let r, g, b, a: CGFloat

    guard hex.hasPrefix("#") else { return nil }
    let start = hex.index(hex.startIndex, offsetBy: 1)
    let hexColor = String(hex[start...])

    guard hexColor.count == 8 else { return nil }
    let scanner = Scanner(string: hexColor)
    var hexNumber: UInt64 = 0

    guard scanner.scanHexInt64(&hexNumber) else { return nil }
    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
    a = CGFloat(hexNumber & 0x000000ff) / 255

    self.init(red: r, green: g, blue: b, alpha: a)
  }
}
