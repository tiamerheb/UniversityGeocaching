import SwiftUI
import CodeScanner

struct QRScannerView: View {
    @State private var isShowingScanner = false
    @State private var scannedCode: String?

    var body: some View {
        NavigationView {
            VStack {
                if let code = scannedCode {
                    Text("Scanned QR Code:")
                    Text(code)
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                } else {
                    Text("No QR Code Scanned")
                }
                Spacer()
                Button(action: {
                    isShowingScanner = true
                }) {
                    Text("Start Scanning")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "example-qr-code") { result in
                    isShowingScanner = false
                    if case .success(let code) = result {
                        scannedCode = code.string
                    } else {
                        print("Scanning failed")
                    }
                }
            }
            .navigationBarTitle("QR Scanner")
        }
    }
}

struct QRScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRScannerView()
    }
}

