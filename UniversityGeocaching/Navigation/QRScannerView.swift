import SwiftUI
import CodeScanner
import Combine

// QRScannerView is a SwiftUI View that allows the user to scan a QR code and check if it matches the verificationString
struct QRScannerView: View {
    var verificationString: String
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var isCodeVerified = false
    

    // The main view content
    var body: some View {
        VStack {
            // A title for the view
            Text("Scan a QR code")
                .font(.title)
                .padding(.bottom, 30)

            // Button to start the QR code scanning
            Button(action: {
                self.isPresentingScanner = true
            }) {
                Text("Start Scanning")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            // Present the CodeScannerView when the user taps the button
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(
                    codeTypes: [.qr],
                    completion: { result in
                        if case let .success(code) = result {
                            self.scannedCode = code.string
                            self.isPresentingScanner = false
                            self.isCodeVerified = (self.scannedCode == self.verificationString)

                        }
                    }
                )
            }

            // Display the scanned code and its verification status
            if let scannedCode = scannedCode {
                Text("Scanned Code: \(scannedCode)")
                    .padding()

                if isCodeVerified {
                    Text("Code verified!")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                } else {
                    Text("Code not verified.")
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

// API class is responsible for fetching the verificationString from the API
class API: ObservableObject {
    // The fetched verificationString
    @Published var verificationString: String = ""

    // Fetches the verificationString for a specific QR code from the API
    func fetchVerificationString(verificationString: String) {
        let urlString = "http://universitygeocaching.azurewebsites.net/api/location/\(verificationString)"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()

                do {
                    let response = try decoder.decode(String.self, from: data)
                    DispatchQueue.main.async {
                        self.verificationString = response
                    }
                } catch {
                    print("Error decoding verification string:", error)
                }
            }
        }.resume()
    }
}

// QRScannerView_Previews is used to provide a preview of the QRScannerView in SwiftUI's design canvas
struct QRScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRScannerView(verificationString: "1234")
    }
}

