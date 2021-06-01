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
    var refCodigo = ""
    var editado: Bool
    @State private var eliminado = false

    // Alertas
    @State var alerta = false
    @State var alert = false
    @State var alertMensaje = ""
    
    var body: some View {
        VStack {
            if !editado {
                Text(viewModel.codigo.titulo)
                    .font(.title)
                    .bold()
            }
            ImagenStorage(imagenUrl: viewModel.codigo.imagenURL)
                    .frame(width: 180, height: 180)
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
                if !viewModel.tituloValido {
                    self.alertMensaje = "El título no puede tener más de 15 caracteres"
                    self.alert.toggle()
                }
                if !viewModel.titulo.isEmpty {
                    viewModel.codigo.titulo = viewModel.titulo
                }
                if !editado {
                    self.alertMensaje = "Código guardado"
                    self.alert.toggle()
                } else {
                    self.alertMensaje = "Código modificado"
                    self.alert.toggle()
                }
            }.buttonStyle(EstiloBoton())
            if editado {
                Button("Eliminar") {
                    self.eliminado = true
                    self.alertMensaje = "¿Está seguro de que desea eliminar el códigoQR?"
                    self.alert.toggle()
                }.font(.title3)
                .foregroundColor(.red)
                .padding(.bottom, 20)
            }
        }.padding(40)
        .navigationBarHidden(true)
        .onAppear(){
            viewModel.getCodigo(ref: refCodigo)
        }
        .alert(isPresented: $alert, content: eliminado ? {
            Alert(title: Text("Importante"), message: Text(alertMensaje), primaryButton: .cancel(Text("No")), secondaryButton:
                    .default(Text("Sí")) {
                        modoPresentacion.wrappedValue.dismiss()
                        viewModel.eliminar(id: refCodigo)
                    })
        }
               :
        {
            Alert(title: Text(alertMensaje), dismissButton: .cancel(Text("Aceptar")){
                    modoPresentacion.wrappedValue.dismiss()
                    viewModel.modificarCodigo(id: refCodigo)

            })
        })
    }
}
