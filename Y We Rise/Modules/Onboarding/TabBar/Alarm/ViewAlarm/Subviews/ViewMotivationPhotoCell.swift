//
//  ViewMotivationPhotoCell.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/26/22.
//

import UIKit

class ViewMotivationPhotoCell: UICollectionViewCell {
    static let ResuableIdentifier = "ViewMotivationPhotoCellId"

    let imageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        return imv
    }()

    func setupView() {
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
