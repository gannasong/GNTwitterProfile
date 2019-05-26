//
//  GNNavigationController.swift
//  GNTwitterProfile
//
//  Created by SUNG HAO LIN on 2019/5/26.
//  Copyright © 2019 GanNaSong. All rights reserved.
//

import UIKit

class GNNavigationController: UINavigationController {

  lazy var emptyImage: UIImage = {
    let emptyImage = UIImage()
    return emptyImage
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.isTranslucent = true
    navigationBar.setBackgroundImage(emptyImage, for: .default)
    navigationBar.shadowImage = emptyImage
  }

  override var preferredStatusBarStyle: UIStatusBarStyle{
    return .lightContent
  }

}
