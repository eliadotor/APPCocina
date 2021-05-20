
//
//  ContentView.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 24/04/2021.
//

import SwiftUI
import Combine
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var viewModel: RegistroViewModel
    @State var irAHome = false

    var body: some View {
        NavigationView {
            if viewModel.logueado{
                TabView {
                    Home(irHome: $irAHome)
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
                }.navigationBarTitle("APP Cocina", displayMode: .inline)
            } else {
                LoginView()
            }
        }
        .onAppear {
            viewModel.logueado = viewModel.signedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RegistroViewModel())
    }
}
