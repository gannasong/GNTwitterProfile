//
//  GNHeaderView.swift
//  GNTwitterProfile
//
//  Created by SUNG HAO LIN on 2019/5/23.
//  Copyright © 2019 GanNaSong. All rights reserved.
//

import UIKit

class GNHeaderView: UIView {

  lazy var headerImageView: UIImageView = {
    let headerImageView = UIImageView(image: UIImage(named: "header"))
    headerImageView.contentMode = .scaleAspectFill
    return headerImageView
  }()

  lazy var headerBlurImageView: UIImageView = {
    let headerBlurImageView = UIImageView(image: UIImage(named: "header")?.blurredImage(withRadius: 10, iterations: 20, tintColor: .clear))
    headerBlurImageView.contentMode = .scaleAspectFill
    headerBlurImageView.alpha = 0.0
    return headerBlurImageView
  }()

  lazy var headerLabel: UILabel = {
    let headerLabel = UILabel(frame: .zero)
    headerLabel.text = "Ponkoi"
    return headerLabel
  }()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUpSubviews()
  }

  // MARK: - Private Methods

  private func setUpSubviews() {
    addSubview(headerImageView)
    addSubview(headerBlurImageView)
    addSubview(headerLabel)

    headerImageView.translatesAutoresizingMaskIntoConstraints = false
    headerBlurImageView.translatesAutoresizingMaskIntoConstraints = false
    headerLabel.translatesAutoresizingMaskIntoConstraints = false

    let views = [
      "imageView": headerImageView,
      "blurImageView": headerBlurImageView,
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
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:[label(44)]|",
      options: [],
      metrics: nil,
      views: views
    ))
  }

}
