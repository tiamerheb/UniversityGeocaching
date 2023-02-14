//
//  NearbyQuestView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/9/23.
//

import Foundation
import SwiftUI

struct NearbyQuestView : View{
    var body : some View{
        ScrollView(.vertical){
            NavigationView{
                VStack{
                    VStack(alignment: .leading) {
                        Text("Nearby Quests")
                            .font(.headline)
                    }
                    HStack{
                        NavigationLink(destination: DiscoverKnauss()){
                            HStack{
                                VStack{
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
                        NavigationLink(destination: CampusCafes()){
                            HStack{
                                VStack{
                                    Text("Campus Cafes")
                                        .font(.headline)
                                    //Image("KNAUSS")
                                    //.resizable()
                                    //.aspectRatio(contentMode: .fit)
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
            }
        }
    }
}
