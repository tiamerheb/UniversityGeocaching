import SwiftUI
import CodeScanner
import Combine


struct QRScannerView: View {
    var verificationString: String
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var isCodeVerified = false

    var body: some View {
        VStack {
            Text("Scan a QR code")
                .font(.title)
                .padding(.bottom, 30)

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



class API: ObservableObject {
    @Published var verificationString: String = ""

    func fetchVerificationString(verificationString: String) {
        // Replace the urlString with your own API endpoint
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


struct QRScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRScannerView(verificationString: "1234")
    }
}


