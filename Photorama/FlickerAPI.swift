//
//  FlickerAPI.swift
//  Photorama
//
//  Created by Edwin Cardenas on 6/14/25.
//

import UIKit

enum Endpoint: String {
    case interestingPhotos = "flickr.interestingness.getList"
}

struct FlickrAPI {
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let apiKey = "a6d819499131071f158fd740860a5a88"

    private static func flickrURL(
        endpoint: Endpoint,
        parameters: [String: String]?
    ) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()

        let baseParams = [
            "method": endpoint.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": apiKey,
        ]

        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)

            queryItems.append(item)
        }

        if let additionalParameters = parameters {
            for (key, value) in additionalParameters {
                let item = URLQueryItem(name: key, value: value)

                queryItems.append(item)
            }
        }

        components.queryItems = queryItems

        return components.url!
    }

    static var interestingPhotosURL: URL {
        return flickrURL(
            endpoint: .interestingPhotos,
            parameters: ["extras": "url_z,date_taken"]
        )
    }
}
