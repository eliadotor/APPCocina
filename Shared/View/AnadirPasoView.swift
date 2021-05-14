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
                Form {
                    Section(header: Text("Ingrediente")) {
                        TextField(self.receta, text: $viewModel.paso.tecnica)
                            .disabled(anadir ? true : false)
                        TextField("", value: $viewModel.paso.duracion, formatter: NumberFormatter())
                            .disabled(anadir ? true : false)
                        TextField("", text: $viewModel.paso.tecnica)
                            .disabled(anadir ? true : false)
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
                        NavigationLink("", destination: EmptyView())
                    )
                }.navigationBarTitle("Pasos", displayMode: .inline)
            }
        }
    }

struct AnadirPasoView_Previews: PreviewProvider {
    static var previews: some View {
        AnadirPasoView(receta: "")
    }
}
