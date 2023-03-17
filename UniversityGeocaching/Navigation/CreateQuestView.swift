//
//  CreateQuestView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 3/14/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct CreateQuestView : View{
    //    Sanatize inputs later
    @State private var username: String = ""
    @State private var difficulty: String = ""
    @State private var hints: String = ""
    @State private var radius: String = ""
    
    private let manager = CLLocationManager()
    private var cacheCoordniates: String = "0.0, 0.0"
    
    //    might need to make a function for each input? also need to validate thats not in the db unclear best way to do this
    func validate(cacheName:String) -> Bool {
        return true
    }
    
    func getCurrentCoordinates() -> String{
        manager.requestLocation()
//        var location = CLLocations.first() // @FIXME sanatize to make sure non null
//        var lat = location?.coordinate.latitude
//        var long = location.longitude
        return "0.0,0.0"
    }
    var body : some View{
        
        VStack(spacing: 20){
            Text("Create new Quest").font(.headline)
            Form{
                
                TextField("Cache Name:",
                          text: $username
                ).onSubmit {
                    validate(cacheName: username)
                }
                TextField("Difficulty (1-5)",
                          text: $difficulty
                )
                TextField("Hints:",
                          text: $hints
                )
                TextField("Radius (feet):",
                          text: $radius
                )
                HStack{
                    Text("Coordinates: " + cacheCoordniates)
                    Spacer()
                    Button("Update") {
                        //call function here
                    }
                }
                // @FIXME link this to a function to get current gps coordinates
            }
            
            Text("Commit using current location").font(.headline)
            Spacer()

        }
    }
}


struct CreateQuestView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuestView()
    }
}

