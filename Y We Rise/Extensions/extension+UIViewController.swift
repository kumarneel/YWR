//
//  extension+UIViewController.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

extension UIViewController {
    func addControllerView(_ v: UIView) {
        view.addSubview(v)
        NSLayoutConstraint.activate([
            v.rightAnchor.constraint(equalTo: view.rightAnchor),
            v.leftAnchor.constraint(equalTo: view.leftAnchor),
            v.topAnchor.constraint(equalTo: view.topAnchor),
            v.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

