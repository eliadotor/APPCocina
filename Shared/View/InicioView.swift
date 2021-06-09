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
    @State var currentNonce: String?
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
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
            .overlay(
                VStack {
                    /*Image("TracSin")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .padding(.bottom, 150)*/
                    Button(action: {
                        self.inicioSesion = true
                    }, label: {
                        HStack {
                            Image(systemName: "envelope")
                            Text("Iniciar sesión con tu email")
                        }
                    }).foregroundColor(.black)
                    .frame(width: 350, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.white)
                    .cornerRadius(5)
                    .font(.system(size: 15))
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
                                            // Initialize a Firebase credential.
                                            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                                                      idToken: idTokenString,
                                                                                      rawNonce: nonce)
                                            // Sign in with Firebase.
                                            Auth.auth().signIn(with: credential) { (authResult, error) in
                                              if (error != nil) {
                                                // Error. If error.code == .MissingOrInvalidNonce, make sure
                                                // you're sending the SHA256-hashed nonce as a hex string with
                                                // your request to Apple.
                                                print(error?.localizedDescription as Any)
                                                return
                                              }
                                              // User is signed in to Firebase with Apple.
                                              // ...
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


                }.padding()
                .frame(width: 350, height: 115, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .navigationTitle("")
            )
    }
}

struct InicioView_Previews: PreviewProvider {
    static var previews: some View {
        InicioView()
    }
}
