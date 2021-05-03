//
//  ContentView.swift
//  Shared
//
//  Created by Elia Dotor Puente on 24/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var indice = 0;
    var body: some View {
        TabView(selection: $indice) {
            Home().tabItem {
                Image(systemName: "note.text")
            }.tag(0)
            Alertas().tabItem {
                Image(systemName: "calendar")
            }.tag(1)
            Codigos().tabItem {
                Image(systemName: "qrcode.viewfinder")
            }.tag(2)
            Listas().tabItem {
                Image(systemName: "list.bullet") /* El nombre entre paréntesis es el
                    nombre de la imagen de tu carpeta assets.xcassets */
            }.tag(3) // Para indicar la posición de las pestañas
            Recetas().tabItem {
                Image(systemName: "gearshape")
            }.tag(4)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
