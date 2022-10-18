//
//  AddMotivitionDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/11/22.
//

import UIKit

extension AddMotivationVC: AddMotivationViewDelegate {
    func didTapAddImage(imageNumber: ImageNumber) {
        self.imageNumber = imageNumber
        imageTapped()
    }

    func didTapNext() {
        viewModel.didTapNext(alarmString: "yo")
    }
}

extension AddMotivationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        picker.dismiss(animated: true, completion: { [weak self] in
            guard let self = self else { return }
            switch self.imageNumber {
            case .one:
                self.controllerView.imageView1.image = image
                self.controllerView.imageView1.emptyIconImageView.isHidden = true
                self.controllerView.imageView1.layer.cornerRadius = 16
                self.controllerView.imageView1.layer.masksToBounds = true
            case .two:
                self.controllerView.imageView2.image = image
                self.controllerView.imageView2.emptyIconImageView.isHidden = true
                self.controllerView.imageView2.layer.cornerRadius = 16
                self.controllerView.imageView2.layer.masksToBounds = true
            case .three:
                self.controllerView.imageView3.image = image
                self.controllerView.imageView3.emptyIconImageView.isHidden = true
                self.controllerView.imageView3.layer.cornerRadius = 16
                self.controllerView.imageView3.layer.masksToBounds = true
            case .four:
                self.controllerView.imageView4.image = image
                self.controllerView.imageView4.emptyIconImageView.isHidden = true
                self.controllerView.imageView4.layer.cornerRadius = 16
                self.controllerView.imageView4.layer.masksToBounds = true
            }
            self.controllerView.layoutSubviews()
        })
        controllerView.nextBtn.setImage(UIImage(named: "SendCodeBtnFilled"), for: .normal)
        controllerView.nextBtn.isUserInteractionEnabled = true
    }
}
