//
//  Common.swift
//  Dinosys
//
//  Created by Hung Nguyen on 9/26/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import Foundation

enum FirstViewControllerStatus {
    case ExpandedTopView
    case CollapsedTopView
}

protocol HorizonCollectionDelegate {
    func updateTableViewCell(index: Int)
    func changeFirstViewStatus(status: FirstViewControllerStatus)
}
