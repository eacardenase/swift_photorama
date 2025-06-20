//
//  TagDataSource.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/19/25.
//

import CoreData
import UIKit

class TagDataSource: NSObject, UITableViewDataSource {

    var tags = [Tag]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return tags.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(UITableViewCell.self),
            for: indexPath
        )

        let tag = tags[indexPath.row]
        var content = cell.defaultContentConfiguration()

        content.text = tag.name

        cell.contentConfiguration = content
        cell.selectionStyle = .none
        
        cell.accessibilityHint = "Toggles selection"
        cell.accessibilityTraits = [.button]

        return cell
    }
}
