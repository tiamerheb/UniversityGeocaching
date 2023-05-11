import SwiftUI
import Combine
import Foundation
import CoreLocation
import MapKit

struct NearbyQuestView: View {
    @State private var nearbyQuests: [CreatedQuest] = []
    @StateObject private var cancellables = Cancellables()
    @StateObject private var locationManager = LocationManager()

    var body: some View {
            NavigationView {
                VStack {
                    Text("Nearby Quests")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, 10)

                    List(nearbyQuests, id: \.id) { quest in
                        NavigationLink(destination: QuestMapView(quest: quest)) {
                            HStack {
                                Text(quest.cachename)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                .navigationBarHidden(true)
                .onAppear(perform: loadData)
            }
        }


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
                    self.nearbyQuests = self.sortQuestsByDistance(quests)
                }
            })
            .store(in: &cancellables.storage)
    }

    func fetchQuests() -> AnyPublisher<[CreatedQuest], Error> {
        let url = URL(string: "http://universitygeocaching.azurewebsites.net/api/location")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("*/*", forHTTPHeaderField: "accept")
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

    func sortQuestsByDistance(_ quests: [CreatedQuest]) -> [CreatedQuest] {
        guard let userLocation = locationManager.lastKnownLocation else {
            return quests
        }

        return quests.sorted { quest1, quest2 in
            let quest1Location = CLLocation(latitude: quest1.latitude, longitude: quest1.longitude)
            let quest2Location = CLLocation(latitude: quest2.latitude, longitude: quest2.longitude)
            return userLocation.distance(from: quest1Location) < userLocation.distance(from: quest2Location)
        }
    }
}

class Cancellables: ObservableObject {
    var storage = Set<AnyCancellable>()
}

struct CreatedQuest: Identifiable, Codable {
    let id: Int
    let cachename: String
    let latitude: Double
    let longitude: Double

    let verificationString: String
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var lastKnownLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lastKnownLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)")
    }
}



struct QuestMapView: View {
    var quest: CreatedQuest
    @State private var region: MKCoordinateRegion
    
    init(quest: CreatedQuest) {
        self.quest = quest
        self._region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: quest.latitude, longitude: quest.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [quest]) { quest in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: quest.latitude, longitude: quest.longitude)) {
                Image(systemName: "mappin.circle")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 40, height: 40)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle(Text(quest.cachename), displayMode: .inline)
    }
}

struct QuestMapView_Previews: PreviewProvider {
    static var previews: some View {
        QuestMapView(quest: CreatedQuest(id: 0, cachename: "Sample Cache", latitude: 37.7749, longitude: -122.4194, verificationString:"1234"))
    }
}



struct NearbyQuestView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyQuestView()
    }
}



