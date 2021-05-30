//
//  DetallesCodigoView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 22/05/2021.
//

import SwiftUI
import FirebaseAuth

struct DetallesCodigoView: View {
    @ObservedObject var viewModel = CodigosViewModel()
    @State private var editarCodigo = false
    var idCodigo: String
    var formatoFecha: DateFormatter {
        let formato = DateFormatter()
        formato.dateFormat = "dd-MM-yyyy"
        return formato
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(self.viewModel.codigo.titulo)
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.vertical)
                        .accessibility(addTraits: .isHeader)
                    ImagenStorage(imagenUrl: self.viewModel.codigo.imagenURL)
                        .frame(width: 250, height: 250)
                        .shadow(radius: 5)
                        .padding(.bottom)
                    if self.viewModel.codigo.descripcion != "" {
                        Text("Descripción:")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        Text(self.viewModel.codigo.descripcion)
                            .font(.system(size: 18))
                            .padding(.bottom, 2)
                        
                    }
                    if formatoFecha.string(from: self.viewModel.codigo.fecha) != "01-06-2020" {
                        Text("Fecha de conservación:")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        Text(self.viewModel.codigo.fecha, formatter: formatoFecha)
                            .font(.system(size: 18))
                            .padding(.bottom, 2)
                    }
                    if formatoFecha.string(from: self.viewModel.codigo.caducidad) != "01-06-2020" {
                        Text("Fecha de caducidad:")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        Text(self.viewModel.codigo.caducidad, formatter: formatoFecha)
                            .font(.system(size: 18))
                            .padding(.bottom, 2)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            Spacer()
        }.onAppear(){
            viewModel.getCodigo(ref: idCodigo)
        }.navigationBarItems(trailing:
                                Button(action: {
                                    editarCodigo = true
                                }, label: {
                                    if (Auth.auth().currentUser != nil) {
                                        Label("", systemImage: "square.and.pencil")
                                            .font(.system(size: 18))
                                    }
                                })
        )
        .sheet(isPresented: $editarCodigo) {
            EditorCodigosView(refCodigo: idCodigo, editado: true)
        }
    }
}

