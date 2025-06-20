//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/16/25.
//

import UIKit

class PhotoInfoViewController: UIViewController {

    let photo: Photo
    let store: PhotoStore

    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityTraits = [.image]
        imageView.isUserInteractionEnabled = false
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = photo.title

        return imageView
    }()

    // MARK: - Initializers

    init(for photo: Photo, with store: PhotoStore) {
        self.photo = photo
        self.store = store

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func loadView() {
        view = UIView()

        view.backgroundColor = .systemBackground

        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = photo.title

        toolbarItems = [
            UIBarButtonItem(
                title: "Tags",
                style: .plain,
                target: self,
                action: #selector(showTags)
            )
        ]

        navigationController?.isToolbarHidden = false
        navigationItem.backButtonTitle = ""

        store.fetchImage(for: photo) { result in
            switch result {
            case let .success(image):
                self.photoImageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }

}

// MARK: - Helpers

extension PhotoInfoViewController {
    private func setupUI() {
        view.addSubview(photoImageView)

        // photoImageView
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            photoImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            photoImageView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            photoImageView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])
    }
}

// MARK: - Actions

extension PhotoInfoViewController {
    @objc func showTags(_ sender: UIBarButtonItem) {
        let tagsViewController = TagsViewController(for: photo, with: store)

        let navViewController = UINavigationController(
            rootViewController: tagsViewController
        )

        present(navViewController, animated: true)
    }
}
