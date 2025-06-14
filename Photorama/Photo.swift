//
//  Photo.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/14/25.
//

import Foundation

struct Photo: Codable {
    let title: String
    let remoteURL: URL?
    let photoID: String
    let dateTaken: Date

    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }
}
