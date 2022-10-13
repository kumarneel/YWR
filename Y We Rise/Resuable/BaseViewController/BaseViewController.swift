//
//  BaseViewController.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

class BaseViewController<ViewModel>: UIViewController {

    /// View model of view controller.
    let viewModel: ViewModel

    /// - SeeAlso: UIViewController.preferredStatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    /// Initializes view controller with given View.
    ///
    /// - Parameter view: Maker for the UIView.
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        overrideUserInterfaceStyle = .light
    }

    /// - SeeAlso: NSCoding.init?(coder:)
    @available(*, unavailable, message: "Not available, use init(view:viewModel)")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
