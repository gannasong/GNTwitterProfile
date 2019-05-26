//
//  GNViewController.swift
//  GNTwitterProfile
//
//  Created by SUNG HAO LIN on 2019/5/23.
//  Copyright © 2019 GanNaSong. All rights reserved.
//

import UIKit

class GNViewController: UIViewController {

  // header 停止的位置，不再縮小
  var offset_HeaderStop: CGFloat {
    return navigationBarHeight
  }

  // At this offset the Black label reaches the Header
  let offset_B_LabelHeader: CGFloat = 95.0

  // The distance between the bottom of the Header and the top of the White Label
  var distance_W_LabelHeader: CGFloat {
    return offset_HeaderStop - (headerView.headerLabel.frame.height / 2)
  }

  lazy var headerView: GNHeaderView = {
    let headerView = GNHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 107))
    headerView.configureWithHeight(with: navigationBarHeight, statusbarHeight: statusBarHeight)
    headerView.clipsToBounds = true
    return headerView
  }()

  lazy var scrollView: GNScrollView = {
    let scrollView = GNScrollView()
    scrollView.configureWithHeight(with: navigationBarHeight, statusbarHeight: statusBarHeight)
    scrollView.backgroundColor = .clear
    scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
    scrollView.delegate = self
    return scrollView
  }()

  // iPhone X = 44, low device = 22
  let statusBarHeight = UIApplication.shared.statusBarFrame.height
  var navigationBarHeight: CGFloat = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
    setupSubViews()
  }

  // MARK: - Private Methods

  private func setupSubViews() {
    view.addSubview(headerView)
    view.addSubview(scrollView)

    headerView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false

    let views = [
      "headerView": headerView,
      "scrollView": scrollView
    ]

    let metrics = [
      "headerHeight": navigationBarHeight + statusBarHeight + 43
    ]

    view.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[headerView]|",
      options: [],
      metrics: nil,
      views: views
    ))
    view.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[scrollView]|",
      options: [],
      metrics: nil,
      views: views
    ))
    view.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[headerView(headerHeight)]",
      options: [],
      metrics: metrics,
      views: views
    ))
    view.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[scrollView]|",
      options: [],
      metrics: nil,
      views: views
    ))

    scrollView.updateConstraints()
    headerView.updateConstraints()
  }

}

extension GNViewController: UIScrollViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard let scrollView = scrollView as? GNScrollView else { return }
    let offset = scrollView.contentOffset.y
    print("offset: \(offset)")
    var avatarTransform = CATransform3DIdentity
    var headerTransform = CATransform3DIdentity

    // PULL DOWN

    if offset < 0 {
      // 當 scrollView 在頂底且持續將 crollView 往下拉時，這時 headerView 圖片要放大
      let headerScaleFactor: CGFloat = -(offset) / headerView.bounds.height
      let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height) / 2.0
      headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
      headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
      headerView.layer.transform = headerTransform
    } else {
      // SCROLL UP/DOWN

      // Header
      headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)

      // Label
      let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
      headerView.headerLabel.layer.transform = labelTransform

      // Blur
      headerView.blurImageView.alpha = min(1.0, (offset - offset_B_LabelHeader) / distance_W_LabelHeader)

      // Avatar
      let avatarScaleFactor = (min(offset_HeaderStop, offset)) / scrollView.avatarView.bounds.height / 1.4 // Slow down the animation
      let avatarSizeVariation = ((scrollView.avatarView.bounds.height * (1.0 + avatarScaleFactor)) - scrollView.avatarView.bounds.height) / 2.0
      avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
      avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)

      if offset <= offset_HeaderStop {
        if scrollView.avatarView.layer.zPosition < headerView.layer.zPosition {
          headerView.layer.zPosition = 0 // 改變層級，將頭像位置移至最下層
        }
      } else {
        if scrollView.avatarView.layer.zPosition >= headerView.layer.zPosition {
          headerView.layer.zPosition = 2 // 將頭像位置移至最上層
        }
      }

      // Apply Transformations
      headerView.layer.transform = headerTransform
      scrollView.avatarView.layer.transform = avatarTransform
    }
  }

}
