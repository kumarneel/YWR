//
//  AlarmView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit

class AlarmView: BaseView {

    let YWRLogo: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "YWRLogoIcon")
        return imv
    }()

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        return tv
    }()

    override func setupView() {
        backgroundColor = UIColor(named: "YWRCream")!

        [YWRLogo, tableView].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            YWRLogo.topAnchor.constraint(equalTo: topAnchor, constant: 82),
            YWRLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            YWRLogo.heightAnchor.constraint(equalToConstant: 22),
            YWRLogo.widthAnchor.constraint(equalToConstant: 140),

            tableView.topAnchor.constraint(equalTo: YWRLogo.bottomAnchor, constant: 30),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

extension AlarmView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = NoAlarmsHeaderView()
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = NewAlarmFooterView()
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 69
    }

}
