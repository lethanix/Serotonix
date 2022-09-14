//
//  ContentView.swift
//  Serotonix
//
//  Created by Louis Murguia on 13/09/22.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		NavigationView {
			VStack {
				Image(systemName: "globe")
					.imageScale(.large)
					.foregroundColor(.accentColor)
				Text("Hello, world!")
			}
			.padding()
			.navigationTitle("Serotonix")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
