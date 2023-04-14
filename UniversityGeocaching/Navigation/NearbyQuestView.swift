//  NearbyQuestView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/9/23.
//

import SwiftUI

struct NearbyQuestView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // Sample data
    let nearbyQuests = [
        CreatedQuest(title: "Discover Knauss", description: "Explore USD's new business building", imageName: "KNAUSS"),
        CreatedQuest(title: "Campus Cafes", description: "Explore USD's campus dining", imageName: "CAFES")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 170))], spacing: 16) {
                    ForEach(nearbyQuests, id: \.title) { quest in
                        NavigationLink(destination: QuestDetailView(quest: quest)) {
                            QuestCardView(quest: quest)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
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

struct QuestCardView: View {
    let quest: CreatedQuest
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(quest.title)
                .font(.headline)
            Image(quest.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
            Text(quest.description)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct CreatedQuest {
    let title: String
    let description: String
    let imageName: String
}

struct QuestDetailView: View {
    let quest: CreatedQuest
    
    var body: some View {
        Text(quest.title)
            .font(.largeTitle)
            .padding()
    }
}

struct NearbyQuestView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyQuestView()
    }
}
