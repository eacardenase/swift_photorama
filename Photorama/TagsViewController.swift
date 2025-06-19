//
//  TagsViewController.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/19/25.
//

import CoreData
import UIKit

class TagsViewController: UITableViewController {

    let photo: Photo
    let store: PhotoStore
    
    var selectedIndexPaths = [IndexPath]()

    // MARK: - Initializers

    init(for photo: Photo, with store: PhotoStore) {
        self.photo = photo
        self.store = store

        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tags"
    }
}
