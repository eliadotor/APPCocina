//
//  AppDelegate.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 13/05/2021.
//

import SwiftUI
import Firebase

final class AppDelegate:NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
