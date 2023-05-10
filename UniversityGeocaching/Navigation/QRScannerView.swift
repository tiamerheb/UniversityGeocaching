import SwiftUI
import CodeScanner

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

struct QRScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRScannerView(verificationString: "1234")
    }
}

