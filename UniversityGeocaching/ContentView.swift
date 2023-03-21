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
                    
                    Text("University of San Diego")
                        .font(.system(size: 32, weight: .bold))
                        .frame(width: 450, height: 00)
                        .foregroundColor(Color(red: 0/255, green: 55/255, blue: 112/255))
                        .padding(.vertical, 0)
                    Text(" Geocaching")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.green)
                        .frame(width: 450, height: 00)
                        .padding(.vertical, 40)
                        .cornerRadius(40)
                        .multilineTextAlignment(.center)
                    Spacer()

                    //NavigationLink(destination: NearbyQuestView()){
                        //HStack{
                            //Image(systemName: "mappin.circle")
                            //Text("Nearby Quests")
                        //}
                        //.frame(width: 100, height: 30)
                        //.padding()
                        //.foregroundColor(.white)
                        //.background(Color.blue)
                        //.cornerRadius(.infinity)
                    //}
                    
                }
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
                        
                        
                        
                        NavigationLink(destination: NavigationScreenView()){
                            HStack{
                                Image(systemName: "mappin.circle")
                                Text("Navigation Screen")
                            }
                            .frame(width: 150, height: 30)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(.infinity)
                            
                        }
                        
                    }
                    
                    VStack{
                        HStack{
                            
                            //@FIXME do we want this done from the app?
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
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
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
