//
//  AlarmView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit

protocol AlarmViewDelegate: AnyObject {
    func didTapAddNewAlarm()
}

class AlarmView: BaseView {

    var viewModel: AlarmViewModel!

    weak var delegate: AlarmViewDelegate?

    let YWRLogo: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "YWRLogoIcon")
        return imv
    }()

    lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.ReusableIdentifier)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        tv.separatorColor = UIColor.clear
        tv.allowsMultipleSelectionDuringEditing = false
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

    func configure(viewModel: AlarmViewModel) {
        self.viewModel = viewModel
        self.tableView.reloadData()
    }
}

extension AlarmView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.alarms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.ReusableIdentifier, for: indexPath) as? AlarmCell else { return UITableViewCell() }
        cell.setupView()
        cell.alarm = viewModel.alarms[indexPath.row]
        return cell
    }

    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            viewModel.didTapRemoveAlarm(index: indexPath.row)
            viewModel.alarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = NoAlarmsHeaderView()
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewModel.alarms.isEmpty {
            return 120
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = NewAlarmFooterView()
        footerView.delegate = self
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 69
    }

}

extension AlarmView: NewAlarmFooterViewDelegate {
    func didTapAddNewAlarm() {
        delegate?.didTapAddNewAlarm()
    }
}
