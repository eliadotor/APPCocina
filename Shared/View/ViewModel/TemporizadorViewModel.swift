//
//  TemporizadorViewModel.swift
//  APPCocina (iOS)
//
// clase que permite gestionar los temporizadores
//  Created by Agustín Aguirre Rabino on 22/05/2021.
//

import Foundation
import SwiftySound

class TemporizadorViewModel: ObservableObject {
     private var contador = 0
    var tiempoRestante: (minutos: Int, segundos: Int) {
        return (minutos: (self.contador % 3600) / 60, segundos: (self.contador % 3600) % 60)
    }
    var tiempoToString: String {
        return "\(self.tiempoRestante.minutos):\(self.tiempoRestante.segundos)"
    }
    @Published var encurso = false
    @Published var finalizado = false
    @Published var sonido = "defecto"
    func setTiempo(minutos: Int, segundos: Int)
    {
        self.contador = minutos * 60 + segundos
    }
    func setTiempo(_ minutos: Int) {
        self.contador = minutos * 60
    }
    func setTiempo(segundos: Int) {
        self.contador = segundos
    }
    func setSonido(_ sonido: String) {
        self.sonido = sonido
    }
    func iniciar() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
            self.encurso = true
            self.contador -= 1
            if self.contador < 1 {
                self.encurso = false
                self.finalizado = true
                timer.invalidate()
                tts.speakVo(text: "Temporizador finalizado")
                Sound.play(file: "\(self.sonido).wav")
            }
        }
        }
}
