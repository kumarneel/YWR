//
//  AlarmVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit
import Combine

class AlarmVC: BaseViewController<AlarmViewModel> {

    lazy var controllerView: AlarmView = {
        let v = AlarmView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()
    }

    func bindViewModel() {
        viewModel.observable.sink { [weak self] in
            guard let self = self else { return }
            self.controllerView.configure(viewModel: self.viewModel)
        }.store(in: &cancellables)

        NotificationCenter.default.addObserver(self, selector: #selector(handleAddedNewAlarm), name: Notification.Name(Observers.addedNewAlarm), object: nil)
    }

    @objc func handleAddedNewAlarm() {
        viewModel.getAlarms()
    }
}

extension AlarmVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
        controllerView.configure(viewModel: viewModel)
    }
}
