//
//  ProfileVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/18/22.
//

import UIKit

extension ProfileVC: ProfileViewDelegate {
    
    func didTapProfileImage() {
        let optionMenu = UIAlertController(title: "Profile Image", message: "", preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { ACTION in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            } else {
                print("camera not available")
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(takePhotoAction)
        optionMenu.addAction(cancelAction)

        self.present(optionMenu, animated: true, completion: nil)
    }

    func didUpdateName(name: String) {
        viewModel.updateName(name: name)
    }

    func didUpdateBirthday(date: Date) {
        viewModel.updateBirthday(date: date.timeIntervalSince1970)
    }

    func didTapEditSleepStyle() {
        viewModel.didTapEditStyle()
    }
    
    func didTapEditMotivationStyle() {
        viewModel.didTapEditMotivition()
    }
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        
        picker.dismiss(animated: true, completion: { [weak self] in
            guard let self = self else { return }
            self.controllerView.profileImageView.image = image
            self.controllerView.profileImageView.layer.cornerRadius = 15
            self.controllerView.profileImageView.layer.masksToBounds = true
            self.controllerView.profileImageView.contentMode = .scaleAspectFill
            ProfileService.instance.saveProfileImage(image: image)
        })
    }
}
