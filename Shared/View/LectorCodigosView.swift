//
//  LectorCodigoView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 22/05/2021.
//

import SwiftUI
import CodeScanner

struct LectorCodigosView: View {
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
            DetallesCodigoView(idCodigo: referencia)
        }
    }
}

