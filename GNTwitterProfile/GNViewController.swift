//
//  GNViewController.swift
//  GNTwitterProfile
//
//  Created by SUNG HAO LIN on 2019/5/23.
//  Copyright © 2019 GanNaSong. All rights reserved.
//

import UIKit

class GNViewController: UIViewController {



  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .yellow
  }

}

extension GNViewController: UIScrollViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    var avatarTransform = CATransform3DIdentity
    var headerTransform = CATransform3DIdentity
  }

}
