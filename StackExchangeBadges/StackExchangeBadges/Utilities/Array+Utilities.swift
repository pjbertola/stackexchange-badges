//
//  Array+Utilities.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element == UIView {
    
    // MARK: - Methods

    public func hide(animated: Bool, except subviewsNotToHide: [UIView]? = nil) {
        let duration = (animated == true) ? 0.25 : .zero
        UIView.animate(withDuration: duration) {
            for view in self {
                view.alpha = (subviewsNotToHide?.contains(view) == true) ? 1.0 : .zero
            }
        }
    }

    public func show(animated: Bool, except subviewsNotToShow: [UIView]? = nil, only subviewsToShow: [UIView]? = nil) {
        let duration = (animated == true) ? 0.25 : .zero
        UIView.animate(withDuration: duration) {
            for view in self {
                view.alpha = ((subviewsNotToShow != nil && subviewsNotToShow?.contains(view) == true) ||
                              (subviewsToShow != nil && subviewsToShow?.contains(view) == false)) ? .zero : 1.0
            }
        }
    }

}
