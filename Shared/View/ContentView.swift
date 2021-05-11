
//
//  ContentView.swift
//  Shared
//
//  Created by Elia Dotor Puente on 24/04/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "note.text")
                }
            Menus()
                .tabItem {
                    Label("Menús", systemImage: "calendar")
            }
            Codigos()
                .tabItem {
                    Label("Códigos", systemImage: "qrcode.viewfinder")
            }
            Listas()
                .tabItem {
                    Label("Listas", systemImage: "list.bullet")
            }
            Cuenta()
                .tabItem {
                    Label("Cuenta", systemImage: "person.crop.circle")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
