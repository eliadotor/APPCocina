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
    
    // Definición de las columnas que tendrá cada fila
    var columnas: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        VStack {
            ScrollView([ .vertical ], showsIndicators: false){
                LazyVGrid(columns: columnas, alignment: .center, spacing: 18) {
                    ForEach(self.viewModel.codigos) { codigo in
                        NavigationLink(destination: DetallesCodigoView(idCodigo: codigo.id, escaneado: false)){
                            VStack(alignment: .leading) {
                                ImagenStorage(imagenUrl: codigo.imagenURL)
                                Text(" \(codigo.titulo)")
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }.padding()
            }.navigationBarTitle("Mis Códigos", displayMode: .inline)
            .onAppear() {
                self.viewModel.getCodigos()
            }
            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing){
                    Button(action: {
                        nuevoCodigo = true
                        self.refCodigo = viewModel.anadirCodigo()
                        self.imagen = viewModel.generarCodigoQR(from: refCodigo)
                        viewModel.guardarImgCodigo(imagen: imagen, ref: refCodigo)
                    }, label: {
                        Label("Nuevo código", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $nuevoCodigo) {
                EditorCodigosView(refCodigo: refCodigo, editado: false)
            }
        }
    }
}

