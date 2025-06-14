//
//  ViewController.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/14/25.
//

import UIKit

class PhotosViewController: UIViewController {

    private var imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    // MARK: - View Lifecycle

    override func loadView() {
        view = UIView()

        view.backgroundColor = .systemBackground

        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photorama"
    }

}

// MARK: - Helpers

extension PhotosViewController {
    private func setupUI() {
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
