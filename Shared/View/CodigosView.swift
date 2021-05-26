//
//  CodigosView.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 22/05/2021.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct CodigosView: View {
    @EnvironmentObject var viewModel: CodigosViewModel
    @State var refCodigo = ""
    @State var imagen = UIImage()
    @State private var nuevoCodigo = false
    @State private var irACodigo = false
    
    // Definición de las columnas que tendrá cada fila
        var columnas: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        NavigationView {
            ScrollView([ .vertical ], showsIndicators: false){
                if (viewModel.codigos.count >= 1){
                        ForEach(viewModel.codigos) { codigo in
                            Button (action: {
                                irACodigo = true
                                
                            }) {
                                Image(uiImage: imagen)
                                    .interpolation(.none)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(12)
                                
                                
                            }.background(NavigationLink("", destination: DetallesCodigoView(refCodigo: refCodigo), isActive: $irACodigo))
                        }
                } else {
                   Button("Crear código") {
                        nuevoCodigo = true
                        self.refCodigo = viewModel.anadirCodigo()
                        self.imagen = viewModel.generarCodigoQR(from: refCodigo)
                        viewModel.guardarImgCodigo(ref: refCodigo, imagen: imagen)
                    }
                }
            }.navigationBarTitle("Mis Códigos")
            .onAppear() {
                self.viewModel.getCodigos()
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        nuevoCodigo = true
                        self.refCodigo = viewModel.anadirCodigo()
                        self.imagen = viewModel.generarCodigoQR(from: refCodigo)
                        viewModel.guardarImgCodigo(ref: refCodigo, imagen: imagen)
                    }, label: {
                        Label("Nuevo código", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $nuevoCodigo) {
                GeneradorCodigosView(refCodigo: refCodigo, imagen: imagen)
            }
            
        }
    }
}

