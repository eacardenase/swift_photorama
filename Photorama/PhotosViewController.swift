//
//  ViewController.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/14/25.
//

import UIKit

class PhotosViewController: UIViewController {

    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()

    var photosCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
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

        photosCollectionView.dataSource = photoDataSource
        photosCollectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(
                PhotoCollectionViewCell.self
            )
        )

        store.fetchInterestingPhotos { photoResult in
            switch photoResult {
            case .success(let photos):
                print("Successfully found \(photos.count) photos.")

                self.photoDataSource.photos = photos
            case .failure(let error):
                print("Error fetching interesting photos: \(error)")

                self.photoDataSource.photos.removeAll()
            }

            self.photosCollectionView.reloadSections(IndexSet(integer: 0))
        }
    }
}

// MARK: - Helpers

extension PhotosViewController {
    private func setupUI() {
        view.addSubview(photosCollectionView)

        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            photosCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            photosCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
        ])
    }
}
