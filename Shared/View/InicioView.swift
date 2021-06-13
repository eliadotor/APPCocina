//
//  InicioView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 5/6/21.
//

import SwiftUI
import CryptoKit
import FirebaseAuth
import AuthenticationServices

let img = "gs://appcocina-5d597.appspot.com/TRAC.jpg"
struct InicioView: View {
    @State private var inicioSesion = false
    @State private var crearCuenta = false

    @State var currentNonce: String?
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }
        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    var body: some View {
        Image("inicio")
            .resizable()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .opacity(0.7)
            .accessibilityHidden(true)
            .overlay(
                VStack {
                    Image("TRACblanco")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .padding(.bottom, 200)
                        .accessibilityLabel("Te damos la bienvenida a TRAC. Inicia sesión o regístrate.")
                    Button(action: {
                        self.inicioSesion = true
                    }, label: {
                        HStack {
                            Image(systemName: "envelope")
                                .font(.system(size: 11))
                            Text("Iniciar sesión con tu email")
                        }
                    }).foregroundColor(.black)
                    .frame(width: 350, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.white)
                    .cornerRadius(5)
                    .font(.system(size: 14))
                    .background(NavigationLink(
                                    "", destination:
                                    LoginView(),
                                    isActive: $inicioSesion).hidden())
                    SignInWithAppleButton(
                        onRequest: { request in
                            let nonce = randomNonceString()
                            currentNonce = nonce
                            request.requestedScopes = [.fullName, .email]
                            request.nonce = sha256(nonce)
                        }, onCompletion: { result in
                            switch result {
                                case.success(let authResults):
                                    switch authResults.credential {
                                        case let appleIDCredential as ASAuthorizationAppleIDCredential: _ = appleIDCredential.user
                                            print("Apple ID Credenciales: \(appleIDCredential.user)")
                                            guard let nonce = currentNonce else {
                                              fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                            }
                                            guard let appleIDToken = appleIDCredential.identityToken else {
                                              print("Unable to fetch identity token")
                                              return
                                            }
                                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                              print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                              return
                                            }
                                            // Initializar credencial de Firebase
                                            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                                                      idToken: idTokenString,
                                                                                      rawNonce: nonce)
                                            // Registrado con Firebase
                                            Auth.auth().signIn(with: credential) { (authResult, error) in
                                              if (error != nil) {
                                                print(error?.localizedDescription as Any)
                                                return
                                              }
                                              // Inicio de sesión con apple
                                                print("Inicio de sesión")
                                            }
                                            print("\(String(describing: Auth.auth().currentUser?.uid))")
                                    default:
                                        break
                                    }
                            case .failure(_):
                                break
                            }
                        })
                        .frame(width: 350, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 10)
                    VStack {
                        //
                    }.frame(width: 350, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.black)
                    .opacity(0.5)
                    .cornerRadius(5)
                    .overlay(
                        Button(action: {
                            self.crearCuenta = true
                        }, label: {
                            Text("Crear una cuenta")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                        }).background(NavigationLink("", destination: RegistroView(), isActive: $crearCuenta).hidden())
                    )
                    .padding(.bottom, 220)
                    Spacer()
            }.padding()
            .navigationTitle("")
        )
    }
}

