//
//  GeneradorCodigosView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 23/05/2021.
//

import SwiftUI

struct GeneradorCodigosView: View {
    @EnvironmentObject var viewModel: CodigosViewModel
    var refCodigo: String
    @State var ruta = ""
    @State private var descripcion = ""


    var imagen: UIImage
    @State private var editado = false
    @State private var selectedDate: Date = Date()
        
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            return formatter
        }
    var body: some View {
        NavigationView {
            VStack {
                
                Image(uiImage: self.imagen)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                SingleFormView(nombreCampo: "Descripción", valorCampo: $descripcion)
                Group {
                    DatePicker("Fecha de adquisición", selection: $viewModel.codigo.fecha, displayedComponents: .date)
                    HStack(alignment: .firstTextBaseline) {
                        Text("Fecha seleccionada:")
                        Text("\(viewModel.codigo.fecha, formatter: dateFormatter)")
                            .multilineTextAlignment(.center)
                    }
                    .padding(.all, 5)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Divider()
                }
                Group {
                    DatePicker("Fecha de caducidad", selection: $viewModel.codigo.caducidad, displayedComponents: .date)
                    HStack(alignment: .firstTextBaseline) {
                        Text("Fecha seleccionada:")
                        Text("\(viewModel.codigo.caducidad, formatter: dateFormatter)")
                            .multilineTextAlignment(.center)
                    }
                    .padding(.all, 5)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Divider()
                }
                
                Button("guardar") {
                    viewModel.codigo.descripcion = descripcion
                    viewModel.modificarCodigo(ref: refCodigo)
                    self.editado = true
                    descripcion = ""


                }
            }.padding()
            .navigationBarTitle("Código QR")
        }.onAppear(){
            viewModel.getCodigo(ref: refCodigo)
        }
    }
}

/*struct GeneradorCodigosView_Previews: PreviewProvider {
    static var previews: some View {
        GeneradorCodigosView(refCodigo: "", imagen: UIImage())
    }
}*/
