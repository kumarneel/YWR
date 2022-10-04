//
//  GetStartedVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

class GetStartedVC: BaseViewController<GetStartedViewModel> {

    lazy var controllerView: GetStartedView = {
        let v = GetStartedView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        for family in UIFont.familyNames {

            let sName: String = family as String
            print("family: \(sName)")

            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addControllerView(controllerView)
    }
}
