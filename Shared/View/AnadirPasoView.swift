//
//  AnadirPasoView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 10/05/2021.
//

import SwiftUI

struct AnadirPasoView: View {
    var receta: String
    @StateObject var viewModel = PasoViewModel()
    @State var anadir: Bool = false
    @State var anadirMas: Bool = false
    @State var guardar: Bool = false

    var body: some View {
            NavigationView {
                VStack(alignment: .leading, spacing: 6) {
                    Section(header: Text("Descripción")) {
                        TextField("", text: $viewModel.paso.descripcion)
                            .disabled(anadir ? true : false)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                            .padding(.bottom)
                    }
            
                    Section(header: Text("Duración")){
                        TextField("", value: $viewModel.paso.duracion, formatter: NumberFormatter())
                            .disabled(anadir ? true : false)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                            .padding(.bottom)
                    }
                    Button(action: {
                        self.anadir = true
                        viewModel.anadirPaso(ref: self.receta)

                    }, label: {
                        HStack {
                            Spacer()
                            Text(anadir ? "Añadido" : "Añadir paso")
                            Spacer()
                        }
                    }).disabled(anadir)
                    Button(action: {
                        self.anadirMas = true
                        self.anadir = false
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Añadir más pasos")
                            Spacer()
                        }
                    })
                    Button(action: {
                        self.guardar = true
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Guardar receta")
                            Spacer()
                        }
                    }).background(
                        NavigationLink("", destination: DetallesPasosView(refReceta: receta), isActive: $guardar).hidden()
                    )
                    .buttonStyle(EstiloBoton())
                }.padding(.horizontal)
                .navigationBarTitle("Pasos", displayMode: .inline)
            }
        }
    }

struct AnadirPasoView_Previews: PreviewProvider {
    static var previews: some View {
        AnadirPasoView(receta: "")
    }
}
