//
//  NavigationScreenView.swift
//  UniversityGeocaching
//
//  Created by Ewhondens Kenel and Grace Gresli on 3/19/23.
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation
import CodeScanner

struct Cache: Identifiable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct NavigationScreenView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 32.772364, longitude: -117.187653),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    )
    
    @State var showingUserLocation = false
    
    @State var cacheBubbleColor = Color.green.opacity(0.4)
    
    //for QR code scanner
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a QR code to get started."
    
    @State var isPresentingFinishPopUp = false

    func showFinishPopUp() {
        self.isPresentingFinishPopUp = true
    }
    
    //qr code scannersheet
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string //made a .string device
                    self.isPresentingScanner = false //by setting this to flase it closes the scanner sheet
                    showFinishPopUp()
                }
            }
        )
    }
    
    var caches = [
        Cache(name: "USD Torero Store", coordinate: CLLocationCoordinate2D(latitude: 32.772364, longitude: -117.187653)),
        Cache(name: "Student Life Pavilion", coordinate: CLLocationCoordinate2D(latitude: 32.77244, longitude: -117.18727)),
        Cache(name: "Warrren Hall", coordinate: CLLocationCoordinate2D(latitude: 32.77154, longitude:  -117.18884)),
        Cache(name: "Copley Library", coordinate: CLLocationCoordinate2D(latitude: 32.771443, longitude: -117.193472)),
    ]
    
    var body: some View {
        TabView {
            // Map tab
            ZStack {
                Map(coordinateRegion: $region, showsUserLocation: showingUserLocation, annotationItems: caches) { cache in
                    MapAnnotation(coordinate: cache.coordinate) {
                        Circle()
                            .foregroundColor(cacheBubbleColor)
                            .frame(width: 100, height: 100)
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        // Button to show user's current location
                        Button(action: {
                            showingUserLocation = true
                            locationManager.requestLocation()
                        }) {
                            Image(systemName: "location.circle.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 32))
                                .foregroundColor(.blue)
                                .padding(.top, 10) // Adds 10 points of padding to the top
                                .padding(.leading, 20) // Adds 20 points of padding to the leading (left) side
                                .padding(.bottom, 80) // Adds 30 points of padding to the bottom
                                .padding(.trailing, 40) // Adds 40 points of padding to the trailing (right) side
                                .font(.system(size: 32))
                        }
                    }
                }
            }
            .onAppear {
                locationManager.requestLocation()
                
            }
            .onReceive(locationManager.$location) { location in
                if let location = location {
                    region = MKCoordinateRegion(
                        center: location.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                }
            }
            .tabItem {
                Image(systemName: "map")
                Text("Map")
            }

            // Scanning feature
            VStack{
                Text("Camera/QR reader")
                Button("Scan Code Now"){
                    self.isPresentingScanner = true
                }
                .sheet(isPresented: $isPresentingScanner){
                    self.scannerSheet
                }
            }
            .tabItem {
                Image(systemName: "camera")
                Text("Scan Code")
            }
            // List tab
            NearbyQuestView()
                        .tabItem {
                            Image(systemName: "list.bullet")
                            Text("List")
                        }
                }
                .sheet(isPresented: $isPresentingFinishPopUp) {
                    FinishPopUpView()
                }
                .edgesIgnoringSafeArea(.all)
            }
    
    class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
        private let locationManager = CLLocationManager()
        @Published var location: CLLocation?
        
        override init() {
            super.init()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        func requestLocation() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            location = locations.last
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
    }
}


struct FinishPopUpView: View {
var body: some View {
    VStack {
        Text("Quest Completed!")
            .font(.title)
            .fontWeight(.bold)
            .padding()
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .frame(width: 80, height: 80)
            .foregroundColor(.green)
            .padding()
        Text("Congratulations, you have finished the quest!")
            .multilineTextAlignment(.center)
            .padding()
        Button(action: {
            // Dismiss the pop-up
            dismiss()
        }) {
            Text("Close")
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
    .padding()
    .background(Color.white)
    .cornerRadius(20)
    .shadow(radius: 20)
}

func dismiss() {
    // Dismiss the pop-up
}
}


struct NavigationScreenView_Previews:PreviewProvider {
        static var previews: some View {
            NavigationScreenView()
        }
    }

