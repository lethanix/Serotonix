//
//  PexelRequest.swift
//  Serotonix
//
//  Created by Louis Murguia on 14/09/22.
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

struct PexelRequest {
	public private(set) var request: URL?
	public private(set) var content: Content
	
	init(request: URL? = nil, content: Content = Content.image) {
		self.request = request
		self.content = content
	}
	
	enum RequestError: String, Error {
		case requestUrl = "The request URL is invalid"
		case invalidResponse = "Invalid response from Pexels"
		case invalidData = "Invalid data received from Pexels"
	}

	func displayRequest() {
		if let request {
			print("The Pexel Request URL is: \(request)")
		} else {
			print("No Pexel Request URL found")
		}
	}
	
	private func getKey() -> String {
		guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
			fatalError("API Key not found")
		}
		return apiKey
	}
	
	func fetch() {
		guard let url = request else {
			fatalError(RequestError.requestUrl.rawValue)
		}
		
		// Set the Authorization API Key
		var req = URLRequest(url: url)
		req.httpMethod = "GET"
		req.setValue(getKey(), forHTTPHeaderField: "Authorization")
		
		let task = URLSession.shared.dataTask(with: req) { data, response, error in
			if let error {
				fatalError("Error accessing Pexels: \(error.localizedDescription)")
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				fatalError("Error: invalid response")
			}
			
			guard let data = data else {
				fatalError("Error: no data found")
			}
			
			do {
				let result = try JSONDecoder().decode(PhotoCollection.self, from: data)
				print(result)
			} catch {
				fatalError(RequestError.invalidData.rawValue)
			}
		}
		task.resume()
	}
}

