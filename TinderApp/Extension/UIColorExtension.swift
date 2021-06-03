//
//  UIColorExtension.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/02/16.
//

import UIKit

extension UIColor{
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) -> UIColor{
        return .init(red: r/255, green: g/255, blue: b/255, alpha: alpha/1)
    }
}
