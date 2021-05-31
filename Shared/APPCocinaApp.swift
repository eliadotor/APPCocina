//
//  APPCocinaApp.swift
//  Shared
//
//  Created by Elia Dotor Puente on 24/04/2021.
//

import SwiftUI
import Firebase

@main
struct APPCocinaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            let viewModel = RegistroViewModel()
            ContentView(seleccionado: 0)
                .environmentObject(viewModel)
        }
    }
}
