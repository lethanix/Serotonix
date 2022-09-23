//
//  ContentView.swift
//  Serotonix
//
//  Created by Louis Murguia on 13/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let requestTest = PexelRequestBuilder()
                .search(for: .image(endpoint: .search), of: "Nature", "Bear")
                .perPage(1)
                .build()
        NavigationView {
            VStack {
                Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                Text("Hello, world!")

                Button(action: {
                    print("Testing the API")
                    requestTest.displayRequest()
                    requestTest.fetch()
                }) {
                    Text("Try the API")
                }
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
