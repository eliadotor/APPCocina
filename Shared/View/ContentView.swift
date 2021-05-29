
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
    @State var irACuenta = false

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
                    LectorCodigosView()
                        .tabItem {
                            Label("Códigos", systemImage: "qrcode.viewfinder")
                    }
                    Listas()
                        .tabItem {
                            Label("Listas", systemImage: "list.bullet")
                    }
                    Cuenta(irCuenta: $irACuenta)
                        .tabItem {
                            Label("Cuenta", systemImage: "person.crop.circle")
                    }
                }
            } else {
                LoginView()
            }
        }.accentColor(.orange)
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
