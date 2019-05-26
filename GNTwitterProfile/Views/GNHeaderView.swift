//
//  GNHeaderView.swift
//  GNTwitterProfile
//
//  Created by SUNG HAO LIN on 2019/5/23.
//  Copyright © 2019 GanNaSong. All rights reserved.
//

import UIKit

class GNHeaderView: UIView {

  var navigationBarHeight: CGFloat = 0
  var statusbarHeight: CGFloat = 0

  lazy var imageView: UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.image = UIImage(named: "header_bg")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  lazy var blurImageView: UIImageView = {
    let blurImageView = UIImageView(frame: .zero)
    blurImageView.image = UIImage(named: "header_bg")?.blurredImage(withRadius: 10, iterations: 20, tintColor: .clear)
    blurImageView.contentMode = .scaleAspectFill
    blurImageView.alpha = 0.0
    return blurImageView
  }()

  lazy var headerLabel: UILabel = {
    let headerLabel = UILabel()
    headerLabel.text = "GanNaSong"
    headerLabel.font = .boldSystemFont(ofSize: 22)
    headerLabel.textColor = .white
    return headerLabel
  }()

  func configureWithHeight(with navigationBarHeight: CGFloat, statusbarHeight: CGFloat) {
    self.navigationBarHeight = navigationBarHeight
    self.statusbarHeight = statusbarHeight
  }

  override func updateConstraints() {
    super.updateConstraints()
    removeConstraints(self.constraints)
    setupSubviews()
  }

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupSubviews()
  }

  // MARK: - Private Methods

  private func setupSubviews() {
    addSubview(imageView)
    addSubview(blurImageView)
    addSubview(headerLabel)

    imageView.translatesAutoresizingMaskIntoConstraints = false
    blurImageView.translatesAutoresizingMaskIntoConstraints = false
    headerLabel.translatesAutoresizingMaskIntoConstraints = false

    let views = [
      "imageView": imageView,
      "blurImageView": blurImageView,
      "label": headerLabel
    ]

    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[imageView]|",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[blurImageView]|",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[imageView]|",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[blurImageView]|",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraint(NSLayoutConstraint(
      item: headerLabel,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerX,
      multiplier: 1,
      constant: 0
    ))
    addConstraint(NSLayoutConstraint(
      item: headerLabel,
      attribute: .top,
      relatedBy: .equal,
      toItem: self,
      attribute: .top,
      multiplier: 1,
      constant: navigationBarHeight + statusbarHeight + 40
    ))
  }

}
