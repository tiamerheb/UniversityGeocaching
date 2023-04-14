//  PastQuestView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/9/23.
//

import SwiftUI

struct PastQuestView: View {
    // Sample data
    let pastQuests = [
        Quest(title: "Quest 1", location: "GYM", completionDate: "2023-03-01"),
        Quest(title: "Quest 2", location: "SLP", completionDate: "2023-02-15"),
        Quest(title: "Quest 3", location: "KNAUSS", completionDate: "2023-01-20")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                List(pastQuests, id: \.title) { quest in
                    VStack(alignment: .leading) {
                        Text(quest.title)
                            .font(.headline)
                        Text(quest.location)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(quest.completionDate)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                Text("Completed Geocaching Quests")
                    .font(.title2)
                    .padding()
                
                CarouselView(quests: pastQuests)
                    .frame(height: 200)
            }
            .navigationBarTitle("Past Quests")
        }
    }
}

struct CarouselView: View {
    var quests: [Quest]
    
    @State private var currentIndex = 0
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(quests.indices, id: \.self) { index in
                VStack {
                    Spacer()
                    Text(quests[index].title)
                        .font(.headline)
                        .padding(.bottom)
                    Text(quests[index].location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width)
            }
        }
        .offset(x: -CGFloat(currentIndex) * UIScreen.main.bounds.width)
        .animation(.spring(), value: currentIndex)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                currentIndex = (currentIndex + 1) % quests.count
            }
        }
    }
}

struct Quest {
    let title: String
    let location: String
    let completionDate: String
}

struct PastQuestView_Previews: PreviewProvider {
    static var previews: some View {
        PastQuestView()
    }
}
