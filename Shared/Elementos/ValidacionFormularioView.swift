//
//  ValidacionFormularioView.swift
//  cocina
//
//  Created by Elia Dotor Puente on 20/05/2021.
//

import SwiftUI

/* Estructura para validar un campo de un formulario */
struct ValidacionFormularioView: View {
    var nombreIcono = "xmarc.circle"
    var colorIcono = Color(red: 0.9, green: 0.5, blue: 0.5)
    var texto = ""
    var body: some View {
        HStack {
            Image(systemName: nombreIcono)
                .foregroundColor(colorIcono)
            Text(texto)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

/* Estructura para crear un campo de un formulario,
   puede ser de tipo TextField o SecureField */
struct SingleFormView: View {
    var nombreCampo = ""
    @Binding var valorCampo: String
    var protegido = false
    
    var body: some View {
        VStack {
            if protegido {
                SecureField(nombreCampo, text: $valorCampo)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 1).frame(height: 40))
                    .padding(.vertical)
            } else {
                TextField(nombreCampo, text: $valorCampo)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 1).frame(height: 40))
                    .padding(.vertical)
            }
        }
        
    }
}


