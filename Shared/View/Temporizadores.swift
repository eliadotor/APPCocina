//
//  Temporizadores.swift
//  APPCocina
//
//  Created by Agustín Aguirre Rabino on 22/5/21.
//
import SwiftUI

struct Temporizadores: View {
    @ObservedObject var temporizador = TemporizadorViewModel()
@State var minutos = 0
@State var segundos = 0
    @State var titulo = "Nuevo temporizador de 0 minutos y 0 segundos."
    var body: some View {
    VStack {
        HStack {
            Text(titulo)
                .accessibility(addTraits: .isHeader)
        }
        Spacer()
        HStack {
        Picker("Minutos", selection: $minutos){
            ForEach(0...120, id: \.self) {
                Text("\($0)")
            }
        }
        Picker("Segundos", selection: $segundos){
            ForEach(0...59, id: \.self) {
                Text("\($0)")
            }
        }
        }
        Spacer()
        HStack {
            Button("Iniciar temporizador") {
                temporizador.setTiempo(minutos: minutos, segundos: segundos)
                temporizador.setSonido("temporizador")
                if !temporizador.encurso {
                    temporizador.iniciar()
                    segundos = 0
                    minutos = 0
                    tts.speakVo(text: "Temporizador iniciado")
                }
            }
            .accessibilityHint("Pulsa dos veces para iniciar el temporizador")
            .disabled(temporizador.encurso)
            if temporizador.encurso {
            Spacer()
            Text(temporizador.tiempoToString)
            }
        }
        Spacer()
    }
}
}
