//
//  GNScrollView.swift
//  GNTwitterProfile
//
//  Created by SUNG HAO LIN on 2019/5/25.
//  Copyright © 2019 GanNaSong. All rights reserved.
//

import UIKit

class GNScrollView: UIScrollView {

  var navigationBarHeight: CGFloat = 0
  var statusbarHeight: CGFloat = 0

  lazy var avatarView: UIImageView = {
    let avatarView = UIImageView(frame: .zero)
    avatarView.image = UIImage(named: "profile")
    avatarView.layer.cornerRadius = 40
    avatarView.layer.borderColor = UIColor.white.cgColor
    avatarView.layer.borderWidth = 3.0
    avatarView.clipsToBounds = true
    return avatarView
  }()

  lazy var nameLabel: UILabel = {
    let nameLabel = UILabel()
    nameLabel.text = "GanNaSong"
    nameLabel.baselineAdjustment = .alignCenters
    return nameLabel
  }()

  lazy var accountLabel: UILabel = {
    let accountLabel = UILabel()
    accountLabel.text = "@iOS Developer"
    accountLabel.textColor = UIColor.lightGray
    accountLabel.font = .boldSystemFont(ofSize: 16)
    return accountLabel
  }()

  lazy var followButton: UIButton = {
    let followButton = UIButton(type: .system)
    followButton.setTitle("Follow", for: .normal)
    followButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    followButton.setTitleColor(UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0), for: .normal)
    followButton.layer.cornerRadius = 15.0
    followButton.layer.borderColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0).cgColor
    followButton.layer.borderWidth = 1.5
    return followButton
  }()

  lazy var loveMark: UIImageView = {
    let loveMark = UIImageView(frame: .zero)
    loveMark.image = UIImage(named: "love")
    return loveMark
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubViews()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupSubViews()
  }

  func configureWithHeight(with navigationBarHeight: CGFloat, statusbarHeight: CGFloat) {
    self.navigationBarHeight = navigationBarHeight
    self.statusbarHeight = statusbarHeight
  }

  override func updateConstraints() {
    super.updateConstraints()
    removeConstraints(self.constraints)
    setupSubViews()
  }

  // MARK: - Private Methods

  private func setupSubViews() {
    addSubview(avatarView)
    addSubview(nameLabel)
    addSubview(followButton)
    addSubview(accountLabel)
    addSubview(loveMark)

    avatarView.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    followButton.translatesAutoresizingMaskIntoConstraints = false
    accountLabel.translatesAutoresizingMaskIntoConstraints = false
    loveMark.translatesAutoresizingMaskIntoConstraints = false

    let views = [
      "avatar": avatarView,
      "name": nameLabel,
      "button": followButton,
      "account": accountLabel,
      "love": loveMark
    ]

    let metrics = [
      "padding": navigationBarHeight + statusbarHeight + 16
    ]

    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|-(10)-[avatar(80)]",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|-(10)-[name(224)]",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|-(10)-[account(224)]",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|-\(UIScreen.main.bounds.width - 112 - 10)-[button(112)]",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|-(padding)-[avatar(80)]-(8)-[name(24)][account(24)]",
      options: [],
      metrics: metrics,
      views: views
    ))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:[button(30)]",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraint(NSLayoutConstraint(
      item: followButton,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: avatarView,
      attribute: .bottom,
      multiplier: 1,
      constant: 0
    ))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:[love(30)]",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:[love(30)]",
      options: [],
      metrics: nil,
      views: views
    ))
    addConstraint(NSLayoutConstraint(
      item: loveMark,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerX,
      multiplier: 1,
      constant: 0
    ))
    addConstraint(NSLayoutConstraint(
      item: loveMark,
      attribute: .top,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerY,
      multiplier: 1,
      constant: self.frame.size.height / 2 + 50
    ))
  }

}
