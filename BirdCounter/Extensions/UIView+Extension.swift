//
//  UIView+Extension.swift
//  BirdCounter
//
//  Created by Zvonimir Medak on 10.04.2021..
//

import Foundation
import UIKit

public extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
