//
//  LoginView.swift
//  Diatom-Dive
//
//  This view provides the login interface for the Diatom-Dive app. It allows users to sign in
//  using their username and password or through Google. The view includes a welcoming greeting,
//  an image of a diatom, input fields for username and password, a login button, options to
//  register and recover passwords, and an option to sign in with Google.
//
//  Created by Eli Kulpinski on 3/28/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var rememberMe = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.40, green: 0.4, blue: 0.62)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 100) {
                    // Top half of the screen with text and image containers
                    HStack(spacing: 0) {
                        // Left container with text
                        VStack(alignment: .leading, spacing: 5) {
                            Spacer(minLength: geometry.size.height * 0.1)
                            Text("Welcome!")
                                .font(Font.custom("Poppins", size: 25).weight(.light))
                                .foregroundColor(.black)
                            
                            Spacer(minLength: geometry.size.height * 0.05) // Positioning "Sign in to" centrally in height
                            
                            Text("Sign in to")
                                .font(Font.custom("Poppins", size: 34).weight(.medium))
                                .foregroundColor(.black)
                            
                            Text("Diatom Dive")
                                .font(Font.custom("Poppins", size: 28).weight(.bold))
                                .foregroundColor(.black)
                        }
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.2)

                        Spacer()

                        // Right container with diatom image
                        Image("LoginDiatom")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.3)
                    }
                    .padding([.leading, .trailing])

                    // Bottom half of the screen with fields and buttons
                    VStack(spacing: 15) {
                        TextField("Enter Your Username", text: $viewModel.username)
                            .padding()
                            .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.black, lineWidth: 1))
                            .shadow(radius: 2)
                            .frame(width: geometry.size.width * 0.8)
                        
                        SecureField("Enter Your Password", text: $viewModel.password)
                            .padding()
                            .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.black, lineWidth: 1))
                            .shadow(radius: 2)
                            .frame(width: geometry.size.width * 0.8)

                        // Remember Me and Forgot Password
                        HStack {
                            Button(action: {
                                rememberMe.toggle()
                            }) {
                                Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.black)
                                Text("Remember Me")
                                    .foregroundColor(.black)
                            }

                            Spacer()

                            Button("Forgot Password?") {
                                viewModel.forgotPassword()
                            }
                            .font(Font.custom("Poppins", size: 16).weight(.bold))
                            .foregroundColor(.black)
                        }
                        .frame(width: geometry.size.width * 0.8)

                        // Login Button
                        Button(action: {
                            viewModel.login()
                        }) {
                            Text("Login")
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color.black)
                                .foregroundColor(Color.white)
                                .cornerRadius(6)
                        }
                        .shadow(radius: 2)
                        .frame(width: geometry.size.width * 0.8)

                        // Registration Prompt
                        HStack {
                            Text("Don't Have An Account?")
                                .font(Font.custom("Poppins", size: 16))
                                .foregroundColor(.black)

                            Text("Register")
                                .font(Font.custom("Poppins", size: 18).weight(.black))
                                .foregroundColor(.black)
                                .onTapGesture {
                                    viewModel.register()
                                }
                        }
                    }
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 20) // Padding for the bottom safe area

                    Spacer()
                }

                // Sign in with Google Button at the bottom
                VStack {
                    Spacer()
                    Button(action: viewModel.signInWithGoogle) {
                        Text("Sign in with Google")
                            .padding()
                            .frame(width: geometry.size.width * 0.8)
                            .foregroundColor(.black)
                            .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                            .cornerRadius(20)
                    }
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 20) // Padding for the bottom safe area
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegisterView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")

            RegisterView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
