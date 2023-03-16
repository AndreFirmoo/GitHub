//
//  ViewCoded.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import Foundation
protocol ViewCoded {
    func setup()
    func addConstraints()
    func setupView()
}

extension ViewCoded {
    func setup() {
        setupView()
        addConstraints()
    }
}
