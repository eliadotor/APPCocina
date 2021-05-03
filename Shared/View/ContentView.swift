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
            Menus().tabItem {
                Image(systemName: "calendar")
            }.tag(1)
            Codigos().tabItem {
                Image(systemName: "qrcode.viewfinder")
            }.tag(2)
            Listas().tabItem {
                Image(systemName: "list.bullet") 
            }.tag(3)
            Cuenta().tabItem {
                Image(systemName: "person.crop.circle")
            }.tag(4)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
