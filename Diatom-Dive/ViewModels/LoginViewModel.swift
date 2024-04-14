//
//  LoginViewModel.swift
//  Diatom-Dive
//
//  ViewModel for the LoginView. Manages user authentication, including login with username and password,
//  Google Sign-In, registration, and password recovery functionalities. Provides navigation triggers
//  and user feedback mechanisms.
//
//  Created by Eli Kulpinski on 3/28/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    // Navigation triggers
    @Published var navigateToHome = false
    @Published var navigateToRegister = false
    @Published var navigateToForgotPassword = false
    @Published var navigateToGoogleSignIn = false

    func login() {
        print("Login Triggered")
        if username.isEmpty || password.isEmpty {
            alertMessage = "Username and password are required."
            showAlert = true
        } else {
            navigateToHome = true  // Simulate successful login
        }
    }

    func register() {
        print("Register Triggered.")
        navigateToRegister = true
    }

    func forgotPassword() {
        print("Forgot Password Triggered.")
        navigateToForgotPassword = true
    }

    func signInWithGoogle() {
        print("Sign In W/ Google Triggered.")
        navigateToGoogleSignIn = true
    }
}
