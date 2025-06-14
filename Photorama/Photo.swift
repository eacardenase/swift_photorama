//
//  Photo.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/14/25.
//

import Foundation

class Photo: Codable {
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date

    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }

    init(title: String, remoteURL: URL, photoID: String, dateTaken: Date) {
        self.title = title
        self.remoteURL = remoteURL
        self.photoID = photoID
        self.dateTaken = dateTaken
    }
}
