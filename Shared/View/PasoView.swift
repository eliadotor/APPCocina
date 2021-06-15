
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
    @ObservedObject private var viewModel = PasoViewModel()
    @State var paso: Int
    @ObservedObject private var temporizador = TemporizadorViewModel()
    @State private var siguientePaso = false
    @State private var terminarReceta = false

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Paso \(viewModel.paso.id)")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.vertical)
                        .accessibilityHidden(true)
                    Spacer()
                }
                Text("Descripción: ")
                    .foregroundColor(.orange)
                    .fontWeight(.bold)
                Text(viewModel.paso.descripcion)
                    .padding(.bottom)
                Text("Duración: ")
                    .foregroundColor(.orange)
                    .fontWeight(.bold)
                Text("\(viewModel.paso.duracion) min")
                .padding(.bottom)
            }
            Divider()
            if temporizador.encurso {
                HStack{
                    Spacer()
                    Text(temporizador.tiempoToString)
                        .font(.system(size: 60))
                        .foregroundColor(.orange)
                    Spacer()
                }
            }
            if viewModel.paso.duracion != 0 {
                if !temporizador.encurso {
                    Button("Iniciar paso") {
                        temporizador.setTiempo(viewModel.paso.duracion)
                        if paso < viewModel.pasos.count {
                            temporizador.setSonido("paso")
                        } else {
                            temporizador.setSonido("finReceta")
                        }
                        temporizador.iniciar()
                    }.foregroundColor(.orange)
                    .buttonStyle(EstiloBotonSecundario())
                    .foregroundColor(.white)
                } else {
                    Button("Terminar") {
                        if temporizador.encurso {
                            temporizador.terminar()
                            if paso < viewModel.pasos.count-1 {
                                tts.speakVo(text: "Paso \(viewModel.paso.id) finalizado")
                            } else {
                                tts.speakVo(text: "Receta finalizada")
                                terminarReceta = true
                            }
                            temporizador.encurso = false
                        }
                    }
                    .buttonStyle(EstiloBoton())
                }
            }
            if paso < viewModel.pasos.count-1 {
            NavigationLink(destination: PasoView(refReceta: refReceta, paso: paso+1), isActive: $temporizador.finalizado) {
                EmptyView()
            }
            .hidden()
            }
            NavigationLink(destination: PasoView(refReceta: refReceta, paso: paso+1), isActive: $siguientePaso) {
                EmptyView()
            }
            .hidden()
            NavigationLink(destination: ContentView(seleccionado: 0), isActive: $terminarReceta) {
                EmptyView()
            }
            .hidden()
            if !temporizador.encurso {
                Button(paso < viewModel.pasos.count ? "Siguiente paso" : "Terminar receta") {
                    if paso < viewModel.pasos.count {
                        siguientePaso = true
                        return
                    } else {
                        tts.speakVo(text: "Receta finalizada")
                        terminarReceta = true
                    }
                }.buttonStyle(EstiloBoton())
                .navigationBarTitle("Paso \(paso)", displayMode: .inline)
            }
            Spacer()
        }.padding(.horizontal, 40)
        .onAppear() {
            viewModel.getPaso(ref: refReceta, id: paso)
            viewModel.getPasos(ref: refReceta)
        }
    }
}

