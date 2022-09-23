//
//  PexelRequestBuilder.swift
//  Serotonix
//
//  Created by Louis Murguia on 15/09/22.
//

import Foundation

// MARK: - Query Builder

class PexelRequestBuilder {
    enum PexelRequestBuilderError: Error {
        case multipleSearchMethods
    }

    // MARK: - Variables

    private var query = String()
    private var optQueries = [URLQueryItem]()
    private var content: Media = .image(endpoint: .search)
    private var searchURL: URL? = Media.image(endpoint: .search).url

    // MARK: - Methods

    /// Search for multiple keywords
    /// - Parameter media: Type of content to search in Pexel (images or videos)
    /// - Parameter keywords: Array of keywords (strings)
    /// - Returns: Query Builder
    func search(for media: Media, of keywords: String...) -> PexelRequestBuilder {
        for word in keywords {
            query.append("\(word)+")
        }
        content = media
        searchURL = media.url

        return self
    }

    func with(orientation: Orientation) -> PexelRequestBuilder {
        optQueries.append(
                URLQueryItem(name: "orientation", value: orientation.rawValue)
        )
        return self
    }

    func with(size: Size) -> PexelRequestBuilder {
        optQueries.append(
                URLQueryItem(name: "size", value: size.rawValue)
        )
        return self
    }

    func language(locale: String) -> PexelRequestBuilder {
        optQueries.append(
                URLQueryItem(name: "locale", value: locale)
        )
        return self
    }

    func perPage(_ perPage: Int) -> PexelRequestBuilder {
        optQueries.append(
                URLQueryItem(name: "per_page", value: String(perPage))
        )

        return self
    }

    func build() -> PexelRequest {
        guard var searchURL else {
            fatalError()
        }
        let queries = URLQueryItem(name: "query", value: query)
        searchURL.append(queryItems: [queries])
        searchURL.append(queryItems: optQueries)

        print("Search URL: \(searchURL)")

        return PexelRequest(request: searchURL, content: content)
    }
}
