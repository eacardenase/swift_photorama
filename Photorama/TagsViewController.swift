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
    let tagDataSource = TagDataSource()

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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTag)
        )

        tableView.dataSource = tagDataSource
        tableView.delegate = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self)
        )

        updateTags()
    }
}

// MARK: - Helpers

extension TagsViewController {

    private func updateTags() {
        store.fetchAllTags { result in
            switch result {
            case let .success(tags):
                self.tagDataSource.tags = tags

                guard let photoTags = self.photo.tags as? Set<Tag> else {
                    return
                }

                for tag in photoTags {
                    if let index = self.tagDataSource.tags.firstIndex(of: tag) {
                        let indexPath = IndexPath(row: index, section: 0)

                        self.selectedIndexPaths.append(indexPath)
                    }
                }
            case let .failure(error):
                print("Error fetching tags: \(error)")
            }
        }

        OperationQueue.main.addOperation {
            self.tableView.reloadSections(
                IndexSet(integer: 0),
                with: .automatic
            )
        }
    }
}

// MARK: - UITableViewDelegate

extension TagsViewController {

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let tag = tagDataSource.tags[indexPath.row]

        if let index = selectedIndexPaths.firstIndex(of: indexPath) {
            selectedIndexPaths.remove(at: index)

            photo.removeFromTags(tag)
        } else {
            selectedIndexPaths.append(indexPath)

            photo.addToTags(tag)
        }

        do {
            try store.persistentContainer.viewContext.save()
        } catch {
            print("Core Data save failed: \(error)")
        }

        tableView.reloadRows(at: [indexPath], with: .fade)
    }

    override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if selectedIndexPaths.firstIndex(of: indexPath) != nil {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}

// MARK: - Actions

extension TagsViewController {

    @objc func done(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }

    @objc func addNewTag(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(
            title: "Add tag",
            message: nil,
            preferredStyle: .alert
        )

        alertController.addTextField { textField in
            textField.placeholder = "Tag name"
            textField.autocapitalizationType = .words
        }

        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            if let tagName = alertController.textFields?.first?.text {
                let context = self.store.persistentContainer.viewContext
                let newTag = Tag(context: context)

                newTag.name = tagName

                do {
                    try context.save()
                } catch {
                    print("Core Data save failed: \(error)")
                }

                self.updateTags()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}
