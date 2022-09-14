//
//  Pexel.swift
//  Serotonix
//
//  Created by Louis Murguia on 13/09/22.
//

import Foundation

// MARK: - Useful enums

enum Content: String {
	case image = "https://api.pexels.com/v1/"
	case video = "https://api.pexels.com/videos/"
}

enum Orientation: String { case landscape, portrait, square }
enum Size: String { case large, medium, small }

// MARK: - Request

class PexelRequest {
	public private(set) var request: URL?
	
	init(request: URL? = nil) {
		self.request = request
	}
	
	func displayRequest() {
		if let request {
			print("The Pexel Request URL is: \(request)")
		} else {
			print("No Pexel Request URL found")
		}
	}
}

// MARK: - Query Builder

class PexelRequestBuilder {
	enum PexelRequestBuilderError: Error {
		case multipleSearchMethods
	}
	
	// MARK: - Private variables
	
	/// Determines if the search method was called before.
	/// `search(for:)` method must be used once.
	//	private var queryDefined = false
	//	private var query = String() {
	//		didSet {
	//			self.queryDefined = true
	//		}
	//	}
	
	private var query = String()
	private var baseURL = String()
	
	// Optional values
	private var orientation: Orientation?
	private var size: Size?
	private var locale: String?
	private var page: Int?
	private var perPage: Int?
	
	// Aux variables
	private var searchURL = String()
	private var optSearchURL = String()
	
	// MARK: - Methods
	
	// TODO: Verify that each method is used only once
	func contentType(_ content: Content) -> PexelRequestBuilder {
		baseURL = content.rawValue
		return self
	}
	
	/// Search for multiple keywords
	/// - Parameter queries: Array of keywords (strings)
	/// - Returns: Query Builder
	func search(for keywords: String...) -> PexelRequestBuilder {
		//		if self.queryDefined {
		//			throw PexelRequestBuilderError.multipleSearchMethods
		//		}
		
		for word in keywords {
			query.append("\(word)+")
		}
		return self
	}
	
	func with(orientation: Orientation) -> PexelRequestBuilder {
		self.orientation = orientation
		optSearchURL.append("&orientation=\(orientation.rawValue)")
		return self
	}
	
	func with(size: Size) -> PexelRequestBuilder {
		self.size = size
		optSearchURL.append("&size=\(size.rawValue)")
		return self
	}
	
	func language(locale: String) -> PexelRequestBuilder {
		self.locale = locale
		optSearchURL.append("&locale=\(locale)")
		return self
	}
	
	func build() -> PexelRequest {
		self.searchURL.append(baseURL)
		self.searchURL.append("search?")
		self.searchURL.append("query=\(query)")
		
		self.searchURL.append(optSearchURL)
		
		let searchURL = URL(string: self.searchURL)
		return PexelRequest(request: searchURL)
	}
}
