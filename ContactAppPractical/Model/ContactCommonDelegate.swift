//
//  ContactCommonDelegate.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation
import UIKit

protocol ContactCommonDelegate: class {
    func startLoading()
    func finishLoading()
    func getRootView() -> UIView
    func showAlertWithError(error: Error)
}

