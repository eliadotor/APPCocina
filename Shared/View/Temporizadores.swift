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
   
    var body: some View {
        VStack {
            Text("Temporizador")
                .font(.system(size: 40))
                .accessibility(addTraits: .isHeader)
                .padding()
            if !temporizador.encurso {
                HStack {
                    Picker(selection: $minutos, label: Text("Minutos").foregroundColor(.orange)) {
                        ForEach(0...59, id: \.self) {
                            Text("\($0)")
                                .accessibilityLabel($0 != 1 ? "\($0) Minutos" : "\($0) Minuto")
                        }
                    }
                    .frame(minWidth: 80, maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(1)
                    Text("minutos")
                        .foregroundColor(.orange)
                        .accessibilityHidden(true)
                    Picker(selection: $segundos, label: Text("Segundos").foregroundColor(.orange)) {
                        ForEach(0...59, id: \.self) {
                            Text("\($0)")
                                .accessibilityLabel($0 != 1 ? "\($0) Segundos" : "\($0) Segundo")
                        }
                    }
                    .frame(minWidth: 80, maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(5)
                    Text("segundos")
                        .foregroundColor(.orange)
                        .accessibilityHidden(true)
                }.padding(30)
            } else {
                Text(temporizador.tiempoToString)
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
            }
            if !temporizador.encurso {
                Button("Iniciar") {
                    temporizador.setTiempo(minutos: minutos, segundos: segundos)
                    temporizador.setSonido("temporizador")
                    if !temporizador.encurso {
                        temporizador.iniciar()
                        segundos = 0
                        minutos = 0
                        tts.speakVo(text: "Temporizador iniciado")
                    }
                }.buttonStyle(EstiloBoton())
                .padding(50)
                .accessibilityHint("Pulsa dos veces para iniciar el temporizador")
            } else {
                Button("Terminar") {
                    if temporizador.encurso {
                        temporizador.sonar = false
                        temporizador.terminar()
                        segundos = 0
                        minutos = 0
                        tts.speakVo(text: "Temporizador finalizado")
                        temporizador.encurso = false
                    }
                }.buttonStyle(EstiloBoton())
                .padding(50)
                .accessibilityHint("Pulsa dos veces para terminar el temporizador")
            }
            Spacer()
        }.alert(isPresented: $temporizador.alert, content: {
            Alert(title: Text(temporizador.alertMensaje), dismissButton: .cancel(Text("Aceptar")){
                temporizador.encurso = false
                temporizador.terminarSonido()
            })
        })
        
    }
}

