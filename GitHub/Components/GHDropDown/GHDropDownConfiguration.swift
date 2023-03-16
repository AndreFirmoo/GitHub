//
//  GHDropDownConfiguration.swift
//  GitHub
//
//  Created by Andre Firmo on 15/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

struct GHDropDownConfiguration {
    var delegate: GHDropDownActionDelegate
    var title: String
    var placeholder: String
    var colorPlaceholder: UIColor = .black
    var borderWidth: CGFloat = 0
    var borderColor: CGColor = UIColor.black.cgColor
    var items: [String]
    var selectedIndex: Int = -1
    var imageToTrailing: Bool = true
    var viewController: UIViewController
    var bottomSheetViewController: GHBottomSheetViewController
}
