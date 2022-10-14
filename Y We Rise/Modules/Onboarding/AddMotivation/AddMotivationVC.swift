//
//  AddMotivationVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/11/22.
//

import UIKit

class AddMotivationVC: BaseViewController<AddMotivationViewModel> {

    lazy var controllerView: AddMotivationView = {
        let v = AddMotivationView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    let picker = UIImagePickerController()

    var imageNumber: ImageNumber = .one

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()
        picker.delegate = self
        picker.allowsEditing = false
    }

    func imageTapped(){
        let optionMenu = UIAlertController(title: nil, message: "Add Motiviation", preferredStyle: .actionSheet)

        let uploadPhotoAction = UIAlertAction(title: "Upload Photo", style: .default) { ACTION in
            self.picker.sourceType = .photoLibrary
            self.picker.modalPresentationStyle = .fullScreen
            self.present(self.picker, animated: false, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(uploadPhotoAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
}

extension AddMotivationVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
    }
}

