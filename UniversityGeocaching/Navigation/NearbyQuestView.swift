import SwiftUI
import Combine
import MapKit
import CoreLocation
import Foundation

// QuestWrapper is a class that wraps a CreatedQuest and adds an observable "completed" property.
class QuestWrapper: ObservableObject, Identifiable {
    let quest: CreatedQuest
    @Published var completed: Bool

    init(quest: CreatedQuest) {
        self.quest = quest
        self.completed = quest.completed
    }
}

// NearbyQuestView displays a list of nearby quests.
struct NearbyQuestView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var nearbyQuests: [QuestWrapper] = []
    @StateObject private var cancellables = Cancellables()
    @StateObject private var viewModel = NearbyQuestViewModel()

    // The body of the NearbyQuestView.
    var body: some View {
        NavigationView {
            List {
                // Display a list of nearby quests.
                ForEach(nearbyQuests) { questWrapper in
                    NavigationLink(destination: QuestDetailView(quest: questWrapper.quest)) {
                        HStack {
                            QuestCardView(quest: questWrapper.quest)
                            CheckBox(questWrapper: questWrapper)
                        }
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
        .onAppear(perform: loadData)
    }

    // Fetches quests from the server and updates the nearbyQuests property.
    func loadData() {
        fetchQuests()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching quests completed successfully")
                case .failure(let error):
                    print("Error fetching quests: \(error)")
                }
            }, receiveValue: { quests in
                print("Received quests: \(quests)")
                DispatchQueue.main.async {
                    viewModel.filterAndSortQuests(quests)
                    nearbyQuests = viewModel.nearbyQuests
                }
            })
            .store(in: &cancellables.storage)
    }


    // Fetches quests from the server using URLSession and Combine.
    func fetchQuests() -> AnyPublisher<[CreatedQuest], Error> {
        let url = URL(string: "http://universitygeocaching.azurewebsites.net/api/location")!

        // Create a URLRequest with custom headers
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("*/*", forHTTPHeaderField: "accept")

        // Set the authorization token
        request.setValue("starterKey420", forHTTPHeaderField: "X-Auth")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status code: \(httpResponse.statusCode)")
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "Unable to decode response")")

                    if httpResponse.statusCode != 200 {
                        throw URLError(.badServerResponse)
                    }
                }
                return data
            }
            .decode(type: [CreatedQuest].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }


}

// Cancellables is a class that holds a set of AnyCancellables.
class Cancellables: ObservableObject {
    var storage = Set<AnyCancellable>()
}

// CreatedQuest is a struct representing a created quest.
struct CreatedQuest: Identifiable, Codable {
    let id: Int
    var uuid: UUID {
        return UUID(uuidString: "\(id)")!
    }
    let cachename: String
    let difficulty: Int
    let hints: String
    let latitude: Double
    let longitude: Double
    let radius: Int
    let timestamp: String
    let trivia: String
    let users: [String] // Assuming users is an array of strings
    let verificationString: String
    var completed: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, cachename, difficulty, hints, latitude, longitude, radius, timestamp, trivia, users, verificationString
    }
}




// QuestCardView displays a single quest card.
struct QuestCardView: View {
    let quest: CreatedQuest

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(quest.cachename)
                .font(.headline)

            // Display the quest's hints, difficulty, and other information
            Text("Hints: \(quest.hints)")
                .font(.footnote)
                .foregroundColor(.secondary)

            Text("Difficulty: \(quest.difficulty)")
                .font(.footnote)
                .foregroundColor(.secondary)

            Text("Trivia: \(quest.trivia)")
                .font(.footnote)
                .foregroundColor(.secondary)

            Text("Verification String: \(quest.verificationString)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


// CheckBox is a custom view that displays a checkmark when the quest is completed.
struct CheckBox: View {
    @ObservedObject var questWrapper: QuestWrapper

    var body: some View {
        Button(action: {
            questWrapper.completed.toggle()
        }) {
            Image(systemName: questWrapper.completed ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(questWrapper.completed ? .blue : .gray)
        }
    }
}

// QuestDetailView displays the details of a single quest.
struct QuestDetailView: View {
    let quest: CreatedQuest

    var body: some View {
        VStack {
            Text(quest.cachename) // Use 'cachename' instead of 'title'
                .font(.largeTitle)
                .padding()
            Text(quest.trivia) // Use 'trivia' instead of 'description'
                .font(.body)
                .padding()
            // Display the quest's location on a map
            MapView(coordinate: CLLocationCoordinate2D(latitude: quest.latitude, longitude: quest.longitude))
                .frame(height: 300)
        }
    }
}


// MapView is a UIViewRepresentable that displays a map with a single annotation.
struct MapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        uiView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        uiView.addAnnotation(annotation)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}

// NearbyQuestViewModel is a class that handles filtering and sorting quests based on location.
class NearbyQuestViewModel: ObservableObject {
    @Published var nearbyQuests: [QuestWrapper] = []

    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocation? {
        locationManager.location
    }

    init() {
        locationManager.requestWhenInUseAuthorization()
    }

    // Filters and sorts quests based on the user's current location.
    func filterAndSortQuests(_ quests: [CreatedQuest]) {
        guard let currentLocation = currentLocation else {
            return
        }

        let wrappedQuests = quests.map { QuestWrapper(quest: $0) }
        let filteredQuests = wrappedQuests.filter { !$0.completed }
        nearbyQuests = filteredQuests.sorted {
            let quest1Location = CLLocation(latitude: $0.quest.latitude, longitude: $0.quest.longitude)
            let quest2Location = CLLocation(latitude: $1.quest.latitude, longitude: $1.quest.longitude)
            return currentLocation.distance(from: quest1Location) < currentLocation.distance(from: quest2Location)
        }
    }
}

struct NearbyQuestView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyQuestView()
    }
}

