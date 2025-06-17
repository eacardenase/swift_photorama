//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/16/25.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    let photoImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true

        return imageView
    }()

    let spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true

        return activityIndicator
    }()

    // MARK: - View Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension PhotoCollectionViewCell {
    private func setupUI() {
        addSubview(photoImageView)
        addSubview(spinner)

        // photoImageView
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])

        // spinner
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func update(displaying image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()

            photoImageView.image = imageToDisplay
        } else {
            spinner.startAnimating()

            photoImageView.image = nil
        }
    }
}
