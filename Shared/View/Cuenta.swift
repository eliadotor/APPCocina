//
//  Cuenta.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 03/05/2021.
//

import SwiftUI

struct Cuenta: View {
    @EnvironmentObject var viewModel: RegistroViewModel

    var body: some View {
        NavigationView {
            if viewModel.logueado {
                VStack {
                    Text("Logueado")
                    Button(action: {
                        viewModel.logout()
                    }, label: {
                        Text("Cerrar sesión")
                            .foregroundColor(Color.orange)
                    }).background(NavigationLink("",
                                                destination: LoginView()))
                }
            } 
        }.onAppear {
            viewModel.logueado = viewModel.signedIn
        }
    }
}

struct Cuenta_Previews: PreviewProvider {
    static var previews: some View {
        Cuenta().environmentObject(RegistroViewModel())
    }
}
