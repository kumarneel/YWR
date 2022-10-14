//
//  SettingsVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit

class SettingsVC: BaseViewController<SettingsViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "YWRCream")!
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tabBarItem = UITabBarItem(title: "", image: UIImage(named: "SettingsIconUnfilled"), selectedImage: UIImage(named: "SettingsIconFilled"))
    }
}
