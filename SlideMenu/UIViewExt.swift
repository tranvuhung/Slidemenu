//
//  UIViewExt.swift
//  SlideMenu
//
//  Created by Tran Vu Hung on 4/13/18.
//  Copyright © 2018 Tran Vu Hung. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func fadeTo(alpha: CGFloat, withDuration: TimeInterval){
    UIView.animate(withDuration: withDuration, animations: {
      self.alpha = alpha
    })
  }
  
}
