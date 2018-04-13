//
//  HomeViewController.swift
//  SlideMenu
//
//  Created by Tran Vu Hung on 4/12/18.
//  Copyright © 2018 Tran Vu Hung. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  var delegateExpanded: ExpandedMenu?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func expandedMenu(_ sender: Any) {
    print("Expanded menu")
    delegateExpanded?.toggoleLeftPanel()
  }
}
