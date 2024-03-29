//
//  LoginView.swift
//  Diatom-Dive
//
//  This SwiftUI view serves as the login interface for the Diatom-Dive app, enabling user authentication
//  via username/password or Google Sign-In. It features a welcoming message, diatom image, credential input fields,
//  and options for account registration and password recovery. Navigation triggers and user feedback are handled
//  by the LoginViewModel, following updated SwiftUI navigation paradigms.
//
//  Created by Eli Kulpinski on 3/28/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var viewModel: LoginViewModel // ViewModel injected as an EnvironmentObject
    @State private var rememberMe = false
    @State private var navigateToHome = false
    @State private var navigateToRegister = false
    @State private var navigateToForgotPassword = false
    @State private var navigateToGoogleSignIn = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    // Background color
                    Color(red: 0.40, green: 0.77, blue: 0.62).edgesIgnoringSafeArea(.all)
                    
                    // Main content
                    VStack(spacing: 100) {
                        // Top half with text and diatom image
                        HStack(spacing: 0) {
                            textContainer(geometry: geometry)
                            Spacer()
                            imageContainer(geometry: geometry)
                        }
                        .padding([.leading, .trailing])

                        // Bottom half with login form
                        loginForm(geometry: geometry)
                    }
                }
            }
            .navigationTitle("") // Hide navigation bar title
            .navigationBarHidden(true) // Ensure navigation bar is hidden
            .alert(isPresented: $viewModel.showAlert) { // User feedback alert
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
             
             // Navigation destinations
            .navigationDestination(isPresented: $navigateToHome) {
                 HomeView()
             }
             .navigationDestination(isPresented: $navigateToRegister) {
                 RegisterView()
             }
             .navigationDestination(isPresented: $navigateToForgotPassword) {
                 ChangePasswordView()
             }
             .navigationDestination(isPresented: $navigateToGoogleSignIn) {
                 GoogleSignInView()
             }
         }
     }
    
    // Text container on the left
    private func textContainer(geometry: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Spacer(minLength: geometry.size.height * 0.1)
            Text("Welcome!").font(.custom("Poppins", size: 25)).fontWeight(.light).foregroundColor(.black)
            Spacer(minLength: geometry.size.height * 0.05)
            Text("Sign in to").font(.custom("Poppins", size: 34)).fontWeight(.medium).foregroundColor(.black)
            Text("Diatom Dive").font(.custom("Poppins", size: 28)).fontWeight(.bold).foregroundColor(.black)
        }
        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.2)
    }
    
    // Diatom image container on the right
    private func imageContainer(geometry: GeometryProxy) -> some View {
        Image("LoginDiatom")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.3)
    }
    
    // Login form with username, password fields, and buttons
    private func loginForm(geometry: GeometryProxy) -> some View {
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

            HStack {
                Button(action: { rememberMe.toggle() }) {
                    Image(systemName: rememberMe ? "checkmark.square.fill" : "square").foregroundColor(.black)
                    Text("Remember Me").foregroundColor(.black)
                }

                Spacer()

                Button("Forgot Password?", action: viewModel.forgotPassword)
                    .font(Font.custom("Poppins", size: 16).weight(.bold))
                    .foregroundColor(.black)
            }
            .frame(width: geometry.size.width * 0.8)

            Button("Login", action: viewModel.login)
                .padding()
                .background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(6)
                .shadow(radius: 2)
                .frame(width: geometry.size.width * 0.8)

            HStack {
                Text("Don't Have An Account?").font(.custom("Poppins", size: 16)).foregroundColor(.black)
                Text("Register").font(.custom("Poppins", size: 18)).fontWeight(.black)
                    .foregroundColor(.black).onTapGesture(perform: viewModel.register)
            }
            .padding(.bottom, geometry.safeAreaInsets.bottom + 20) // Padding for bottom safe area
            
            // Google Sign-In button at the bottom
            Button("Sign in with Google", action: viewModel.signInWithGoogle)
                .padding()
                .frame(width: geometry.size.width * 0.8)
                .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                .cornerRadius(20)
                .padding(.bottom, 20)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(LoginViewModel())
    }
}
