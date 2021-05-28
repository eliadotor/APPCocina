//
//  GeneradorCodigosView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 23/05/2021.
//

import SwiftUI

struct EditorCodigosView: View {
    @ObservedObject var viewModel = CodigosViewModel()
    @Environment(\.presentationMode) var modoPresentacion
    var refCodigo: String
    @State var ruta = ""

    var imagen: UIImage
    @State private var editado = false
    @State private var selectedDate: Date = Date()
    
    // Alertas
    @State var alert = false
    @State var alertMensaje = ""
        
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            return formatter
        }
    var body: some View {
        VStack {
            if !viewModel.codigo.titulo.isEmpty {
                Text(viewModel.codigo.titulo)
                    .bold()
            }
            Image(uiImage: self.imagen)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            SingleFormView(nombreCampo: "Título", valorCampo: $viewModel.titulo)
            if !viewModel.titulo.isEmpty {
                ValidacionFormularioView(nombreIcono: viewModel.tituloValido ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.tituloValido ? Color.green : Color.red, texto: "Máximo 15 caractéres")
                    .padding(.horizontal)
            }
            SingleFormView(nombreCampo: "Descripción", valorCampo: $viewModel.codigo.descripcion)
            Group {
                DatePicker("Fecha de adquisición", selection: $viewModel.codigo.fecha, displayedComponents: .date)
                    .accentColor(.orange)
                Divider()
            }
            Group {
                DatePicker("Fecha de caducidad", selection: $viewModel.codigo.caducidad, displayedComponents: .date)
                    .accentColor(.orange)
                Divider()
            }
            
            Button("Guardar") {
                if !viewModel.titulo.isEmpty && !viewModel.tituloValido {
                    self.alertMensaje = "El título no puede tener más de 15 caracteres"
                    self.alert.toggle()
                }
                if !viewModel.titulo.isEmpty {
                    viewModel.codigo.titulo = viewModel.titulo
                }
                viewModel.modificarCodigo(ref: refCodigo)
                self.editado = true
                viewModel.codigo.titulo = ""
                viewModel.codigo.descripcion = ""
                modoPresentacion.wrappedValue.dismiss()
            }.buttonStyle(EstiloBoton())
        }.padding(40)
        .navigationBarHidden(true)
        .onAppear(){
            viewModel.getCodigo(ref: refCodigo)
        }.alert(isPresented: $alert, content: {
            Alert(title: Text("¡Importante!"), message: Text(alertMensaje), dismissButton: .cancel(Text("Aceptar")))
        })
    }
}
