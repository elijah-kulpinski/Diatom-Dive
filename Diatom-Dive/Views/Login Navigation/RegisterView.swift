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
    @State private var confirmPassword = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var usernameIsUnique = true
    @State private var isShowingLogin = false
    @Environment(\.presentationMode) var presentationMode

    // Lists for generating random usernames
    let adjectives = [
        "Abyssal", "Agile", "Algorithmic", "Ancient", "Animated", "Arctic", "Asymptotic", "Astral", "Benthic",
        "Binary", "Bioluminescent", "Bitwise", "Blazing", "Bright", "Bubbly", "Calm", "Celestial", "Charming",
        "Clear", "Clever", "Coastal", "Cosmic", "Curious", "Cyclic", "Dancing", "Daring", "Dazzling", "Deep",
        "Detailed", "Digital", "Divergent", "Dynamic", "Ebbing", "Effervescent", "Elusive", "Emerging",
        "Ephemeral", "Epic", "Evolving", "Exponential", "Fathomless", "Flowing", "Fluorescent", "Fractal",
        "Frosty", "Futuristic", "Gigantic", "Gleaming", "Glistening", "Glitchy", "Glacial", "Glowing",
        "Graceful", "Graphical", "Harmonic", "Hashed", "Heuristic", "Holographic", "Hypersonic", "Innovative",
        "Intertidal", "Invisible", "Iterative", "Jubilant", "Kaleidoscopic", "Kelp-laden", "Legendary",
        "Littoral", "Logical", "Luminous", "Lunar", "Mangrove", "Matrix", "Miraculous", "Mystic", "Mysterious",
        "Mythic", "Nautical", "Nebulous", "Nimble", "Nonlinear", "Numeric", "Oceanic", "Opalescent",
        "Optimal", "Orbital", "Parallel", "Passionate", "Pelagic", "Phantom", "Pixelated", "Planetary",
        "Pioneering", "Prismatic", "Probabilistic", "Quantum", "Quixotic", "Radiant", "Recursive",
        "Resilient", "Retro", "Restorative", "Rippling", "Roaming", "Robotic", "Sage", "Saline", "Scalar",
        "Serene", "Shimmering", "Silent", "Silver", "Solar", "Sparkling", "Spectral", "Spirited", "Steady",
        "Sublime", "Sweeping", "Swift", "Symbolic", "Synthetic", "Tactical", "Tidal", "Timeless",
        "Tranquil", "Transcendent", "Turbulent", "Twinkling", "Ultrasonic", "Undulating", "Unfolding",
        "Uplifting", "Vector", "Vibrant", "Vivid", "Vortex", "Wandering", "Wave-kissed", "Whispering",
        "Winding", "Wired", "Xenophyophore", "Yielding", "Zen", "Zooplanktonic"
    ]

    let nouns = [
        "Acidophile", "Algorithm", "Amphiprora", "Anabaena", "Array", "Astronomer", "Bacillaria",
        "Bacillariophyte", "Bandwidth", "Bioluminescence", "Bit", "Brachysira", "Buffer", "Byte", "Cache",
        "Centric", "Chaetoceros", "Cipher", "Cladophora", "Cluster", "Cocconeis", "Code", "Coscindiscus",
        "CPU", "Cyclotella", "Cymatopleura", "Cymbella", "Data", "Delphineis", "Diatoma", "Digit",
        "Dinobryon", "Dinoflagellate", "Diploneis", "Divisor", "Domain", "Drone", "Echolocation", "Euglena",
        "Eunotia", "Explorer", "Fibonacci", "Foraminifera", "Fucus", "Function", "Fustule", "Gamer",
        "Gomphonema", "Graph", "Guardian", "Gyre", "Gyrosigma", "Hacker", "Heliozoa", "Hex", "Himantidium",
        "Holoplankton", "Ichthyologist", "Index", "Integer", "Jellyfish", "Kernel", "Krill", "Larvacean",
        "Lithodesmium", "Logic", "Lyngbya", "Matrix", "Melosira", "Merismopedia", "Micrasterias", "Mollusk",
        "Nacre", "Naturalist", "Navicula", "Neutron", "Node", "Nematochrysopsis", "Nitzschia", "Oedogonium",
        "Orca", "Oscillatoria", "Pediastrum", "Pennate", "Peridinium", "Phacus", "Phaeodactylum", "Pixel",
        "Pirate", "Planktothrix", "Pleurosigma", "Portal", "Pseudo-nitzschia", "Pterosperma", "Query", "Queue",
        "Quasar", "Quester", "Rhizosolenia", "Root", "Router", "Scalar", "Skeletonema", "Socket", "Stack",
        "Stauroneis", "Steward", "Stream", "String", "Synedra", "Tabellaria", "Tensor", "Thalassionema",
        "Thalassiosira", "Thread", "Tracer", "Triceratium", "Ulnaria", "User", "Valonia", "Vector", "Vertex",
        "Virus", "Volvox", "Vortex", "Vorticella", "Widget", "Wizard", "Zygnema", "Zygoptera"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Spacer()
                    HStack {
                        backButton
                        Spacer()
                        title
                        Spacer()
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        usernameField
                        randomizeButton
                    }
                    otherFields
                    HStack{
                        Spacer()
                        registerButton
                        Spacer()
                    }
                }
                validationMessages
            }
            .padding()
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Registration"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
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
        Text("Create Your Account")
            .font(.title)
            .fontWeight(.bold)
    }

    private var usernameField: some View {
        TextField("Username", text: $username, onEditingChanged: { _ in
            checkUsername()
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.none)
        .disableAutocorrection(true)
    }

    private var randomizeButton: some View {
        Button("Randomize") {
            username = generateRandomUsername()
            checkUsername()
        }
        .buttonStyle(.bordered)
        .foregroundColor(.black)
    }

    private var otherFields: some View {
        Group {
            TextField("Email", text: $email)
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

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.newPassword)

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.newPassword)
            
            Text("Password must be at least 8 characters long, include a number, and a special character.")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }

    private var registerButton: some View {
        Button(action: {
            viewModel.registerWithEmail(email: email, password: password, username: username, firstName: firstName, lastName: lastName)
        }) {
            Text("Register")
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
        }
        .buttonStyle(.borderedProminent)
        .disabled(email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty || password != confirmPassword || !viewModel.isPasswordValid(password) || username.isEmpty || !usernameIsUnique)
    }
    
    private var validationMessages: some View {
        Group {
            if username.isEmpty {
                Text("Username required.")
                    .foregroundColor(.red)
            }
            
            if !usernameIsUnique{
                Text("Username already taken.")
                    .foregroundColor(.red)
            }
            
            if email.isEmpty {
                Text("Email required.")
                    .foregroundColor(.red)
            }
            
            if firstName.isEmpty || lastName.isEmpty {
                Text("Full name required.")
                    .foregroundColor(.red)
            }
            
            if !viewModel.isPasswordValid(password) {
                Text("Password isn't valid.")
                    .foregroundColor(.red)
            }
            
            if password != confirmPassword{
                Text("Passwords do not match.")
                    .foregroundColor(.red)
            }
        }
    }

    private func generateRandomUsername() -> String {
        let randomAdjective = adjectives.randomElement() ?? "Cool"
        let randomNoun = nouns.randomElement() ?? "Seafarer"
        return "\(randomAdjective)\(randomNoun)\(Int.random(in: 100...999))"
    }

    private func checkUsername() {
        viewModel.checkUsernameUnique(username: username) { isUnique in
            usernameIsUnique = isUnique
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
