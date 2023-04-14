//  CreateQuestView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 3/14/23.
//

import SwiftUI
import CoreLocation

struct CreateQuestView: View {
    @State private var cacheName: String = ""
    @State private var difficulty: String = ""
    @State private var hints: String = ""
    @State private var radius: String = ""

    private let manager = CLLocationManager()
    private var cacheCoordinates: String = "0.0, 0.0"

    func validate(cacheName: String) -> Bool {
        return true
    }

    func getCurrentCoordinates() -> String {
        manager.requestLocation()
        return "0.0,0.0"
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Create New Quest")
                .font(.largeTitle)
                .padding()

            List {
                Section(header: Text("Quest Details")) {
                    HStack {
                        Text("Cache Name:")
                        Spacer()
                        TextField("Enter cache name", text: $cacheName)
                    }
                    HStack {
                        Text("Difficulty (1-5):")
                        Spacer()
                        TextField("Enter difficulty", text: $difficulty)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Hints:")
                        Spacer()
                        TextField("Enter hints", text: $hints)
                    }
                    HStack {
                        Text("Radius (feet):")
                        Spacer()
                        TextField("Enter radius", text: $radius)
                            .keyboardType(.numberPad)
                    }
                }

                Section(header: Text("Location")) {
                    HStack {
                        Text("Coordinates: ")
                        Spacer()
                        Text(cacheCoordinates)
                            .foregroundColor(.secondary)
                    }
                    Button(action: {
                        // Update coordinates here
                    }) {
                        Text("Update Coordinates")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .listStyle(GroupedListStyle())

            Spacer()
        }
    }
}

struct CreateQuestView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuestView()
    }
}
