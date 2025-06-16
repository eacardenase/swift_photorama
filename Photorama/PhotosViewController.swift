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
        let collectionLayout = UICollectionViewFlowLayout()

        collectionLayout.estimatedItemSize = CGSize(width: 90, height: 90)
        collectionLayout.minimumLineSpacing = 2
        collectionLayout.minimumInteritemSpacing = 2
        collectionLayout.sectionInset = UIEdgeInsets(
            top: 2,
            left: 2,
            bottom: 2,
            right: 2
        )

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionLayout
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    // MARK: - View Lifecycle

    override func loadView() {
        view = photosCollectionView
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
