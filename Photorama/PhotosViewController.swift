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

        collectionLayout.itemSize = CGSize(width: 90, height: 90)
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

        navigationItem.title = "Photorama"
        navigationItem.backButtonTitle = ""

        photosCollectionView.dataSource = photoDataSource
        photosCollectionView.delegate = self
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

// MARK: -  UICollectionViewDelegate

extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let photo = photoDataSource.photos[indexPath.row]

        let photoInfoViewController = PhotoInfoViewController(
            for: photo,
            with: store
        )

        navigationController?.pushViewController(
            photoInfoViewController,
            animated: true
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let photo = photoDataSource.photos[indexPath.row]

        store.fetchImage(for: photo) { imageResult in
            guard
                let photoIndex = self.photoDataSource.photos.firstIndex(
                    of: photo
                ), case .success(let image) = imageResult
            else {
                return
            }

            let photoIndexPath = IndexPath(item: photoIndex, section: 0)

            if let cell = collectionView.cellForItem(at: photoIndexPath)
                as? PhotoCollectionViewCell
            {
                cell.update(displaying: image)
            }
        }
    }
}
