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
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var rememberMe: Bool = false
    
    // Navigation triggers
    @Published var navigateToHome = false
    @Published var navigateToRegister = false
    @Published var navigateToForgotPassword = false

    func login() {
        FirebaseService.shared.signInWithEmail(email: email, password: password, rememberMe: rememberMe) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.navigateToHome = true
                case .failure(let error):
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }

    func register() {
        navigateToRegister = true
    }
    
    func forgotPassword() {
        navigateToForgotPassword = true
    }
}

extension LoginViewModel {
    
    // Enhanced registration function to include username along with first and last names
    func registerWithEmail(email: String, password: String, username: String, firstName: String, lastName: String) {
        FirebaseService.shared.registerWithEmail(email: email, password: password, username: username, firstName: firstName, lastName: lastName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    // Clear user data after successful registration
                    self.clearUserData()
                    self.alertMessage = "Registration Successful. You can now log in."
                    self.showAlert = true
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }

    // Function to validate password strength
    func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    // Function to check if the username is unique
    func checkUsernameUnique(username: String, completion: @escaping (Bool) -> Void) {
        FirebaseService.shared.usernameExists(username: username) { exists in
            DispatchQueue.main.async {
                completion(!exists)
            }
        }
    }

    // Function to handle password reset requests
    func resetPassword() {
        FirebaseService.shared.resetPassword(email: self.email) { result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self.email = ""
                    self.alertMessage = "Check your email to reset your password."
                    self.showAlert = true
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }

    // Clear user data from the ViewModel
    private func clearUserData() {
        email = ""
        password = ""
        username = ""
        firstName = ""
        lastName = ""
    }
}
