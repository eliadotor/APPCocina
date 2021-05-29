//
//  DetallesCodigoView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 22/05/2021.
//

import SwiftUI

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
            ForEach(self.viewModel.codigos) { codigo in
                HStack {
                    VStack(alignment: .leading) {
                        Text(codigo.titulo)
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.vertical)
                            .accessibility(addTraits: .isHeader)
                        ImagenStorage(imagenUrl: codigo.imagenURL)
                            .frame(width: 250, height: 250)
                            .shadow(radius: 5)
                            .padding(.bottom)
                        if codigo.descripcion != "" {
                            Text("Descripción:")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                            Text(codigo.descripcion)
                                .font(.system(size: 18))
                                .padding(.bottom, 2)
                            
                        }
                        if formatoFecha.string(from: codigo.fecha) != "01-06-2020" {
                            Text("Fecha de conservación:")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                            Text(codigo.fecha, formatter: formatoFecha)
                                .font(.system(size: 18))
                                .padding(.bottom, 2)
                        }
                        if formatoFecha.string(from: codigo.caducidad) != "01-06-2020" {
                            Text("Fecha de caducidad:")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                            Text(codigo.caducidad, formatter: formatoFecha)
                                .font(.system(size: 18))
                                .padding(.bottom, 2)
                        }
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 30)
            Spacer()
        }.onAppear(){
            viewModel.getRefCodigo(id: idCodigo)
        }.navigationBarItems(trailing:
                                Button(action: {
                                    editarCodigo = true
                                }, label: {
                                    Label("", systemImage: "square.and.pencil")
                                        .font(.system(size: 18))
                                })
        )
        .sheet(isPresented: $editarCodigo) {
            EmptyView()
        }
    }
}

