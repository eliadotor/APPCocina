//
//  LectorCodigoView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 22/05/2021.
//

import SwiftUI
import CodeScanner

struct LectorCodigosView: View {
    @State private var mostrarDetalles = false
    @State var referencia = ""
    var body: some View {
        VStack() {
            CodeScannerView(codeTypes: [.qr], scanMode: .continuous, scanInterval: 3) { resultado in
                switch resultado {
                    case .success(let codigo):
                        self.referencia = codigo
                        mostrarDetalles = true
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            VStack{
                Text(self.referencia)
            }
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .overlay(
            VStack {
                Spacer()
                Rectangle().stroke(Color.orange, lineWidth: 1).frame(width: 250, height: 250)
                    .accessibilityLabel("Esperando código QR.")
                Spacer()
            }
        )
        .sheet(isPresented: $mostrarDetalles, onDismiss: {
            self.referencia = ""
        }) {
            DetallesCodigoView(idCodigo: referencia, escaneado: true)
        }
    }
}
