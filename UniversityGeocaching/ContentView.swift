//
//  ContentView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/7/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Spacer(minLength: 100)
                VStack(alignment: .leading) {
                    Text("HOME")
                        .font(.headline)
                }
                HStack{
                    NavigationLink(destination: NearbyQuestView()){
                        HStack{
                            Image(systemName: "mappin.circle")
                            Text("Nearby Quests")
                        }
                        .frame(width: 150, height: 30)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(.infinity)
                    }
                    NavigationLink(destination: CreateQuestView()){
                        HStack{
                            Image(systemName: "checklist.unchecked")
                            Text("Create a Quest")
                        }
                        .frame(width: 150, height: 30)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(.infinity)
                    }
                }
                Spacer(minLength: 10)
                VStack{
                    HStack{
                        NavigationLink(destination: PastQuestView()){
                            HStack{
                                Image(systemName: "checkmark.circle")
                                Text("Past Quests")
                            }
                            .frame(width: 150, height: 30)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(.infinity)
                        }
                        NavigationLink(destination: UserSettingsView()){
                            HStack{
                                Image(systemName: "person.2.badge.gearshape")
                                Text("User Settings")
                            }
                            .frame(width: 150, height: 30)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(.infinity)
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Featured Quest")
                            .font(.headline)
                        Image("featuredQuest")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                        Text("Discover the hidden treasures of the ancient temple.")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
};

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

///
///Create a quest needs to be like a Google form
///Past quests has to have all the completed quests (QR code being completed
///adds the current quest to the past quest page)
///NOTE : vetoing the sign-in page
///
///settings (size/font/color)
///
