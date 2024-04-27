//
//  FirebaseService.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 3/28/24.
//

import Firebase
import FirebaseAuth

class FirebaseService {
    static let shared = FirebaseService() // Singleton instance
    static let rememberMeDuration: TimeInterval = 7 * 24 * 60 * 60 // 7 days in seconds

    private init() {}

    func signInWithEmail(email: String, password: String, rememberMe: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                if rememberMe {
                    let expirationDate = Date().addingTimeInterval(FirebaseService.rememberMeDuration)
                    UserDefaults.standard.set(expirationDate, forKey: "sessionExpiration")
                }
                completion(.success(()))
            }
        }
    }

    func registerWithEmail(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let uid = authResult?.user.uid else {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                return
            }
            let userData = ["email": email, "firstName": firstName, "lastName": lastName, "createdAt": FieldValue.serverTimestamp()] as [String : Any]
            Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }

    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func isUserLoggedIn() -> Bool {
        if let expirationDate = UserDefaults.standard.object(forKey: "sessionExpiration") as? Date {
            return Date() < expirationDate
        }
        return false
    }
    
    func fetchUserData(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { document, error in
            guard let document = document, document.exists, let data = document.data() else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "DataError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user data found"])))
                }
                return
            }

            // Constructing User object with firstName and lastName
            let user = User(
                uid: uid,
                email: data["email"] as? String ?? "",
                firstName: data["firstName"] as? String ?? "",
                lastName: data["lastName"] as? String ?? "",
                createdAt: (data["createdAt"] as? Timestamp)?.dateValue()
            )
            completion(.success(user))
        }
    }
}
