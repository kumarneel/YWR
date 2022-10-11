//
//  AddMotivitionDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/11/22.
//

import UIKit

extension AddMotivationVC: AddMotivationViewDelegate {
    func didTapNext() {

    }

    func didTapAddImage() {
        imageTapped()
    }
}

extension AddMotivationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        picker.dismiss(animated: true, completion: {

        })
    }
}
