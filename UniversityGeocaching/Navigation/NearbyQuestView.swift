//
//  NearbyQuestView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/9/23.
//

import Foundation
import SwiftUI

struct NearbyQuestView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    HStack {
                        NavigationLink(destination: DiscoverKnauss()) {
                            HStack {
                                VStack {
                                    Text("Discover Knauss")
                                        .font(.headline)
                                    Image("KNAUSS")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text("Explore USD's new business building")
                                }
                            }
                            .frame(width: 150, height: 250)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                        }
                        NavigationLink(destination: CampusCafes()) {
                            HStack {
                                VStack {
                                    Text("Campus Cafes")
                                        .font(.headline)
                                    Image("CAFES")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text("Explore USD's campus dining")
                                }
                            }
                            .frame(width: 150, height: 250)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                        }
                    }
                }
                .navigationBarTitle(Text("Nearby Quests"))
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Close")
                }))
            }
        }
    }
}

struct NearbyQuestView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyQuestView()
    }
}
