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
    @StateObject private var viewModel = LoginViewModel()  // Using the same ViewModel for simplicity
    @State private var confirmPassword = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @Environment(\.presentationMode) var presentationMode  // For handling view dismissal

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        // Back button
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.primary)
                                .imageScale(.large)
                                .padding()
                        }

                        Spacer()

                        Text("Create Your Account")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top)
                    }

                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textContentType(.emailAddress)

                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.name)

                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.familyName)

                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.newPassword)

                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.newPassword)

                    Button("Register") {
                        viewModel.registerWithEmail(email: viewModel.email, password: viewModel.password, firstName: firstName, lastName: lastName)
                    }
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty || firstName.isEmpty || lastName.isEmpty || viewModel.password != confirmPassword)
                    .buttonStyle(.borderedProminent)
                    .padding()

                    if viewModel.password != confirmPassword {
                        Text("Passwords do not match")
                            .foregroundColor(.red)
                    }

                    Text("Password must be at least 8 characters long, include a number, and a special character.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .padding()
            }
            .navigationBarTitle("Register", displayMode: .inline)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Registration"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
