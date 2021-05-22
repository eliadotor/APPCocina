//
//  PasoView.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 22/05/2021.
//

import SwiftUI

struct PasoView: View {
    var refReceta = ""
    @State var comenzarReceta = false
    @State var irAInicio = false
    @ObservedObject private var viewModel = PasoViewModel()
    @State var paso: Int
    @State var temporizador = false
    @State private var siguientePaso = false
    @State private var terminarReceta = false
    @State private var pasosReceta = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Paso \(viewModel.paso.id)")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                    .accessibility(addTraits: .isHeader)
                Spacer()
            }
            Text(viewModel.paso.descripcion)
                .padding(.bottom)
            HStack {
                Text("Duración")
                Text("\(viewModel.paso.duracion) min")
                    .foregroundColor(.orange)
                    .fontWeight(.bold)
            }.padding(.bottom)
            if viewModel.paso.duracion != 0 {
                Button(action: {
                    if paso < viewModel.pasos.count {
                        self.paso += 1
                        siguientePaso = true
                    }
                }, label: {
                    Text("temporizador")
                })
                .background(
                    NavigationLink("", destination: PasoView(refReceta: refReceta, paso: paso), isActive: $siguientePaso)
                )
            }
            if paso <=   viewModel.pasos.count {
                NavigationLink("", destination: PasoView(refReceta: refReceta, paso: paso), isActive: $siguientePaso).hidden()
            
            } else {
                NavigationLink("", destination: EmptyView(), isActive: $terminarReceta).hidden()
            }
        
            Button(action: {
                if paso < viewModel.pasos.count {
                    self.paso += 1
                    siguientePaso = true
                } else {
                    terminarReceta = true
                }
            }, label: {
                Text(paso < viewModel.pasos.count ? "Siguiente paso" : "Terminar receta")
            })
            .navigationBarTitle("Paso \(viewModel.paso.id)", displayMode: .inline)
            Spacer()
            
        }.padding()
        .onAppear() {
            viewModel.getPaso(ref: refReceta, id: paso)
            viewModel.getPasos(ref: refReceta)

        }
    }
}
