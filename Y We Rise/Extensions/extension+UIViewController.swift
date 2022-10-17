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

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

