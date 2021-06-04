//
//  TemporizadorViewModel.swift
//  APPCocina (iOS)
//
//  Clase que permite gestionar los temporizadores
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
    
    @Published var temporizador: Timer? = nil
    
    // Alertas
    @Published var alert = false
    @Published var alertMensaje = ""
    
    /* Función que asigna el tiempo (en minutos y segundos) al temporizador
     * Parámetros: minutos -> número de minutos
     * segundos -> número de segundos
     */
    func setTiempo(minutos: Int, segundos: Int) {
        self.contador = minutos * 60 + segundos
    }
    
    /* Función que asigna el tiempo en minutos al temporizador
     * Parámetro: minutos -> número de minutos
     */
    func setTiempo(_ minutos: Int) {
        self.contador = minutos * 60
    }
    
    /* Función que asigna el tiempo en minutos al temporizador
     * Parámetro: segundos -> número de minutos
     */
    func setTiempo(segundos: Int) {
        self.contador = segundos
    }
    
    /* Función que asigna un sonido al temporizador
     * Parámetro: sonido -> sonido asignado
     */
    func setSonido(_ sonido: String) {
        self.sonido = sonido
    }
    
    /* Función que inicia el temporizador */
    func iniciar() {
        temporizador = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
            self.encurso = true
            self.contador -= 1
            if self.contador < 1 {
                self.encurso = false
                self.terminar()
            }
        }
    }
    
    /* Función que finaliza el temporizador */
    func terminar() {
        self.finalizado = true
        temporizador?.invalidate()
        temporizador = nil
        Sound.play(file: "\(self.sonido).wav")
        self.alertMensaje = "Temporizador finalizado"
        self.alert.toggle()
    }
    
    /* Función que para el sonido del temporizador */
    func terminarSonido() {
        Sound.stop(file: "\(self.sonido).wav")
    }
}
