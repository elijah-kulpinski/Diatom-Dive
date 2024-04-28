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

struct ChangePasswordView: View {
    @StateObject private var viewModel = LoginViewModel() // Using the same ViewModel for simplicity
    @State private var isShowingLogin = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                    backButton
                    Spacer()
                    title
                    Spacer()
                    Spacer()
                }
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Send Reset Link") {
                    viewModel.resetPassword()
                }
                .disabled(viewModel.email.isEmpty)
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Password Reset"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .fullScreenCover(isPresented: $isShowingLogin) {
            LoginView()
        }
    }
    
    private var backButton: some View {
        Button(action: {
            isShowingLogin = true
        }) {
            HStack {
                Image(systemName: "arrow.left")
            }
            .foregroundColor(.primary)
            .imageScale(.large)
        }
    }
    
    private var title: some View {
        Text("Reset Password")
            .font(.largeTitle)
            .padding()
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
