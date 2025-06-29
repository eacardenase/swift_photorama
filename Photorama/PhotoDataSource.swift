//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/16/25.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {

    var photos = [Photo]()

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return photos.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NSStringFromClass(
                    PhotoCollectionViewCell.self
                ),
                for: indexPath
            ) as? PhotoCollectionViewCell
        else {
            fatalError("Could not type cast PhotoCollectionViewCell")
        }

        let photo = photos[indexPath.row]

        cell.photoDescription = photo.title
        cell.update(displaying: nil)

        return cell
    }
}
