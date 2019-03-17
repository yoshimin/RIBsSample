//
//  UIView+nib.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/17.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import UIKit

extension UIView {
    static var name: String {
        let type: AnyClass = classForCoder()
        return String(describing: type).components(separatedBy: ".").last!
    }
    static var nib: UINib {
        return UINib(nibName: name, bundle: nil)
    }
}
