
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
    //@State var irAInicio = false
    @ObservedObject private var viewModel = PasoViewModel()
    @State var paso: Int
    @ObservedObject private var temporizador = TemporizadorViewModel()
    @State private var siguientePaso = false
    @State private var terminarReceta = false

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
            if temporizador.encurso {
                Text(temporizador.tiempoToString)
            }
            if viewModel.paso.duracion != 0 {
                Button("Iniciar paso") {
                    temporizador.setTiempo(viewModel.paso.duracion)
                    if paso < viewModel.pasos.count-1 {
                        temporizador.setSonido("paso")
                    }
                    else {
                    temporizador.setSonido("finReceta")
                    }
                    temporizador.iniciar()
                }
                .disabled(temporizador.encurso)
            }
                NavigationLink(destination: PasoView(refReceta: refReceta, paso: paso+1), isActive: $temporizador.finalizado)
                {
                    EmptyView()
                }
                .hidden()
                NavigationLink(destination: PasoView(refReceta: refReceta, paso: paso+1), isActive: $siguientePaso)
                {
                    EmptyView()
                }
                .hidden()
                NavigationLink(destination: Text("Receta terminada"), isActive: $terminarReceta)
                {
                    Text("probando")
                }
                .hidden()
            Button(paso < viewModel.pasos.count-1 ? "Siguiente paso" : "Terminar receta") {
                if paso < viewModel.pasos.count-1 {
                    siguientePaso = true
                     return
                }
                    terminarReceta = true
                }
            .disabled(temporizador.encurso)
            .navigationBarTitle("Paso \(paso)", displayMode: .inline)
            Spacer()
        }.padding()
        .onAppear() {
            viewModel.getPaso(ref: refReceta, id: paso)
            viewModel.getPasos(ref: refReceta)
        }
    }
}

