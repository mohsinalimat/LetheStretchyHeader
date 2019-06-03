//
//  ViewController.swift
//  Example
//
//  Created by Vizyoneks on 4.06.2019.
//  Copyright © 2019 Osman YILDIRIM. All rights reserved.
//

import UIKit
import LetheStretchyHeader

final class ViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialHeader()
    }

    private func initialHeader() {
        LetheStretchyHeader().initial(viewController: self, parentView: scrollView, customHeader: nil, image: UIImage(named: "sample"), height: 200, type: .afterShowNavigationBar)
    }
}

