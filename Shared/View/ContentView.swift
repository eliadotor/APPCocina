
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
    @State var irARecetas = false
    @State var irACuenta = false
    @State var seleccionado: Int

    var body: some View {
        NavigationView {
            if viewModel.logueado{
                TabView(selection: $seleccionado) {
                    Home(irHome: $irAHome)
                        .tabItem {
                            Label("Inicio", systemImage: "house.fill")
                        }.tag(0)
                    RecetasView(irARecetas: $irARecetas).environmentObject(RecetaViewModel())
                        .tabItem {
                            Label("Recetas", systemImage: "note.text")
                    }.tag(1)
                    LectorCodigosView()
                        .tabItem {
                            Label("Lector QR", systemImage: "qrcode.viewfinder")
                    }.tag(2)
                    Temporizadores()
                        .tabItem {
                            Label("Temporizador", systemImage: "timer")
                    }.tag(3)
                    Cuenta(irCuenta: $irACuenta)
                        .tabItem {
                            Label("Cuenta", systemImage: "person.crop.circle")
                    }.tag(4)
                }
            } else {
                InicioView()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.orange)
        .onAppear {
            viewModel.logueado = viewModel.signedIn
        }
        .navigationBarHidden(true)
    }
}
