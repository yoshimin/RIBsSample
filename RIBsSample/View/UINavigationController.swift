//
//  UINavigationController.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/30.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import UIKit
import RIBs

extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController { return self }

    public convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}
