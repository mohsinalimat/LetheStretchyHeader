//
//  LetheStretchyHeader.swift
//  LetheStretchyHeader
//
//  Created by Osman YILDIRIM on 3.06.2019.
//  Copyright © 2019 Osman YILDIRIM. All rights reserved.
//

import UIKit

public final class LetheStretchyHeader: UIView {
    fileprivate var customHeader: UIView?
    fileprivate var height: CGFloat = 0
    public var imageView: UIImageView!
    fileprivate var inset: CGFloat = 0
    fileprivate var type: HeaderType = .alwaysHideNavigationBar
    fileprivate var viewController: UIViewController!
    fileprivate var viewSize = CGSize.zero

    private func initialImageView(_ width: CGFloat, _ height: CGFloat) {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
    }

    public func initial(viewController: UIViewController, parentView: UIScrollView, customHeader: UIView?, image: UIImage?, height: CGFloat, type: HeaderType) {
        self.customHeader = customHeader
        self.height = height
        self.type = type
        self.viewController = viewController

        switch type {
        case .alwaysHideNavigationBar, .afterShowNavigationBar:
            if let customHeader = self.customHeader {
                customHeader.alpha = 0
            } else {
                viewController.navigationController!.navigationBar.alpha = 0
            }

        case .alwaysShowNavigationBar:
            if let customHeader = self.customHeader {
                inset = customHeader.frame.height
            } else {
                if let translucent = viewController.navigationController?.navigationBar.isTranslucent {
                    if translucent {
                        inset = UIApplication.shared.statusBarFrame.height + (viewController.navigationController?.navigationBar.frame.size.height ?? 44)
                    }
                }
            }
        }

        initialImageView(viewController.view.frame.width, height)
        self.frame = CGRect(x: 0, y: inset, width: viewController.view.frame.width, height: height)
        viewSize = self.frame.size

        if let customHeader = self.customHeader {
            viewController.view.insertSubview(self, belowSubview: customHeader)
        } else if let navigationBar = viewController.navigationController?.navigationBar {
            viewController.view.insertSubview(self, belowSubview: navigationBar)
        } else {
            viewController.view.addSubview(self)
        }
        parentView.contentInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        (parentView as UIScrollView).delegate = self

        guard let image = image else { return }
        imageView.image = image
        self.isUserInteractionEnabled = false

        parentView._letheStretchyHeader = self
    }
}

extension LetheStretchyHeader: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if imageView == nil { return }
        if scrollView.contentOffset.y != 0 {

            let scrollOffset = scrollView.contentOffset.y + height

            if scrollOffset < 0 {
                imageView.frame = CGRect(x: scrollOffset, y: scrollOffset, width: scrollView.bounds.size.width - (scrollOffset * 2), height: viewSize.height - scrollOffset * 2)

            } else {
                imageView.frame = CGRect(x: 0, y: -scrollOffset, width: viewSize.width, height: viewSize.height)
            }

            navigationBarAlpha(scrollOffset)
        }
    }

    private func navigationBarAlpha(_ scrollOffset: CGFloat) {
        if type == .afterShowNavigationBar {
            let navBarHeight = (customHeader?.frame.height ?? viewController.navigationController?.navigationBar.frame.maxY) ?? 0

            if (viewSize.height - scrollOffset) > navBarHeight {
                if let customHeader = self.customHeader {
                    customHeader.alpha = scrollOffset / (viewSize.height - navBarHeight)
                } else {
                    viewController.navigationController!.navigationBar.alpha = scrollOffset / (viewSize.height - navBarHeight)
                }
            } else {
                if let customHeader = self.customHeader {
                    customHeader.alpha = 1
                } else {
                    viewController.navigationController!.navigationBar.alpha = 1
                }
            }
        }
    }
}

var prop_1: String? = nil
extension UIScrollView {
    public var _letheStretchyHeader: LetheStretchyHeader! {
        get { return objc_getAssociatedObject(self, &prop_1) as? LetheStretchyHeader }
        set { objc_setAssociatedObject(self, &prop_1, newValue as LetheStretchyHeader?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public enum HeaderType {
    case afterShowNavigationBar
    case alwaysHideNavigationBar
    case alwaysShowNavigationBar
}
