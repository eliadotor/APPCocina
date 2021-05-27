//
//  LectorCodigoView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 22/05/2021.
//

import SwiftUI
import CodeScanner


struct LectorCodigosView: View {
    //@EnvironmentObject var viewModel: CodigosViewModel
    var refCodigo = ""
    @State private var mostrarScanner = false
    @State var referencia = ""

    var body: some View {
        VStack() {
            CodeScannerView(codeTypes: [.qr]) { resultado in
                switch resultado {
                    case .success(let codigo):
                        self.referencia = codigo
                        mostrarScanner = true
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            Text(self.referencia)
        }.sheet(isPresented: $mostrarScanner) {
            DetallesCodigoView(refCodigo: referencia)
        }
        /*NavigationView {
            VStack(spacing: 10) {
                if self.referencia != "" {
                    NavigationLink("Next page", destination: DetallesCodigoView(refCodigo: refCodigo), isActive: .constant(true)).hidden()
                }
                Button("Escanear QR") {
                    self.mostrarScanner = true
                }
                .sheet(isPresented: $mostrarScanner) {
                    /*CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)*/
                }
            }

        }*/
    }
    /*func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            /*let codigo = CodigosViewModel()
            person.name = details[0]
            person.emailAddress = details[1]

            self.prospects.people.append(person)*/
        case .failure(let error):
            print(error)
        }
    }
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code
                    self.isPresentingScanner = false
                }
            }
        )
    }*/
    
}

