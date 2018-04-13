//
//  ViewController.swift
//  SlideMenu
//
//  Created by Tran Vu Hung on 4/11/18.
//  Copyright © 2018 Tran Vu Hung. All rights reserved.
//

import UIKit
import NotificationCenter

enum SlideOutState {
  case collapsed
  case leftPanelExpanded
}

class ContainerVC: UIViewController {
  
  @IBOutlet weak var leftMenu: UIView!
  @IBOutlet weak var leftMenuConstraint: NSLayoutConstraint!
  var homeViewController: HomeViewController!
  var tap: UITapGestureRecognizer!
  
  var shouldEpandedMenu: Bool = false
  var currentState: SlideOutState = .collapsed {
    didSet {
      let shouldShadow = (currentState != .collapsed)
      shouldShowShadow(status: shouldShadow)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "homeVC" {
      let homeVC = segue.destination as! HomeViewController
      homeVC.delegateExpanded = self
      homeViewController = homeVC
    }
  }

}

extension ContainerVC: ExpandedMenu{
  func toggoleLeftPanel() {
   let notAlreadyExpanded = (currentState != .leftPanelExpanded)
    animateLeftPanel(shouldExpand: notAlreadyExpanded)
  }
  
  @objc func animateLeftPanel(shouldExpand: Bool) {
    if shouldExpand {
      currentState = .leftPanelExpanded
      animateStatusBar()
      setupWhiteCoverView()
      animateLayoutConstraint(constant: 0)
    } else {
      animateStatusBar()
      hideWhiteCoverView()
      animateLayoutConstraint(constant: -210) { (finished) in
        if finished == true {
          self.currentState = .collapsed
        }
      }
    }
  }
  
  func animateLayoutConstraint(constant: CGFloat, completion: ((Bool) -> Void)! = nil) {
    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
      self.leftMenuConstraint.constant = constant
      self.view.layoutIfNeeded()
    }, completion: completion)
  }
  
  func animateStatusBar(){
    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
      self.setNeedsStatusBarAppearanceUpdate()
    })
  }
  
  func setupWhiteCoverView(){
    let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    whiteCoverView.backgroundColor = UIColor.white
    whiteCoverView.tag = 21
    whiteCoverView.alpha = 0.0
    
    homeViewController.view.addSubview(whiteCoverView)
    whiteCoverView.fadeTo(alpha: 0.75, withDuration: 0.5)
    
    tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
    tap.numberOfTapsRequired = 1
    
    homeViewController.view.addGestureRecognizer(tap)
  }
  
  func hideWhiteCoverView(){
    homeViewController.view.removeGestureRecognizer(tap)
    for subview in homeViewController.view.subviews{
      if subview.tag == 21 {
        UIView.animate(withDuration: 0.5, animations: {
          subview.alpha = 0.0
        }, completion: { (finished) in
          subview.removeFromSuperview()
        })
      }
    }
  }
  
  func shouldShowShadow(status: Bool) {
    if status == true {
      leftMenu.layer.shadowOpacity = 0.6
    } else {
      leftMenu.layer.shadowOpacity = 0.0
    }
  }
}
