//
//  UserSettingsView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/9/23.
//

import Foundation
import SwiftUI

struct UserSettingsView : View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("cacheBubbleColor") private var cacheBubbleColor = "Blue"
    @AppStorage("shareLocation") private var shareLocation = true
    
    var body : some View{
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            Toggle(isOn: $isDarkMode) {
               Text("Dark Mode")
            }
            .padding(.bottom, 10)
            .preferredColorScheme(isDarkMode ? .dark : .light)
            
            VStack(alignment: .leading) {
                Text("Cache Bubble Color")
                
                Picker(selection: $cacheBubbleColor, label: Text("Cache Bubble Color")) {
                    Text("Blue").tag("Blue")
                    Text("Green").tag("Green")
                    Text("Red").tag("Red")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.bottom, 10)
            
            Toggle(isOn: $shareLocation) {
                Text("Share Location")
            }
        }
        .padding()
    }
}



struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView()
    }
}

