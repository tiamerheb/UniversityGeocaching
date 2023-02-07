//
//  ContentView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/7/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Spacer(minLength: 100)
            VStack(alignment: .leading) {
                Text("HOME")
                    .font(.headline)
            }
            HStack{
                Button(action: {
                    // action for button 1
                }) {
                    HStack{
                        Image(systemName: "mappin.circle")
                        Text("Nearby Quests")
                    }
                }
                .frame(width: 150, height: 30)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(.infinity)
                Button(action: {
                    // action for button 2
                }) {
                    HStack{
                        Image(systemName: "checklist.unchecked")
                        Text("List a Quest")
                    }
                }
                .frame(width: 150, height: 30)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(.infinity)
            }
            Spacer(minLength: 10)
            VStack{
                HStack{
                    Button(action: {
                        // action for button 3
                    }) {
                        HStack{
                            Image(systemName: "checkmark.circle")
                            Text("Past Quests")
                        }
                    }
                    .frame(width: 150, height: 30)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(.infinity)
                    
                    Button(action: {
                        // action for button 3
                    }) {
                        HStack{
                            Image(systemName: "person.2.badge.gearshape")
                            Text("User Settings")
                        }
                    }
                    .frame(width: 150, height: 30)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(.infinity)
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
};


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
