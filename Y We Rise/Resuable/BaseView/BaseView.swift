//
//  BaseView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

class BaseView: UIView {

    let activityView: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        
    }

    func addActivityView() {
        addSubview(activityView)

        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
