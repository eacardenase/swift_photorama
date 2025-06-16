//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/16/25.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    // MARK: - View Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
