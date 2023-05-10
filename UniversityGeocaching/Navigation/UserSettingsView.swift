//  UserSettingsView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/9/23.
//

import SwiftUI
import UIKit

struct UserSettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isHighContrast") private var isHighContrast = false
    @AppStorage("cacheBubbleColor") private var cacheBubbleColor = "Blue"
    @AppStorage("shareLocation") private var shareLocation = true
    @AppStorage("notificationOn") private var notificationOn = true
    @AppStorage("notificationFrequency") private var notificationFrequency = "Daily"
    @AppStorage("distanceUnit") private var distanceUnit = "Metric"
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                    .padding(.bottom, 10)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                }
                Section(header: Text("Map Settings")) {
                    Picker(selection: $cacheBubbleColor, label: Text("Cache Bubble Color")) {
                        Text("Blue").tag("Blue")
                        Text("Green").tag("Green")
                        Text("Red").tag("Red")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Toggle(isOn: $shareLocation) {
                        Text("Share Location")
                    }
                }
                
                Section(header: Text("Notification Preferences")) {
                    Toggle(isOn: $notificationOn) {
                        Text("Notifications")
                    }
                    Picker(selection: $notificationFrequency, label: Text("Notification Frequency")) {
                        Text("Daily").tag("Daily")
                        Text("Weekly").tag("Weekly")
                        Text("Monthly").tag("Monthly")
                    }
                }
                
                Section(header: Text("Units")) {
                    Picker(selection: $distanceUnit, label: Text("Distance Unit")) {
                        Text("Metric").tag("Metric")
                        Text("Imperial").tag("Imperial")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button(action: {
                        // Handle account deletion
                    }) {
                        Text("Delete Account")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView()
    }
}
