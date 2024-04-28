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

    func registerWithEmail(email: String, password: String, username: String, firstName: String, lastName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let uid = authResult?.user.uid else {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                return
            }
            let userData = [
                "email": email,
                "username": username,
                "firstName": firstName,
                "lastName": lastName,
                "createdAt": FieldValue.serverTimestamp(),
                // Initialize other fields with default or empty values
                "uploadedDiatoms": [],
                "exploredRegions": [],
                "leaderboardScores": [],
                "quizScores": [],
                "achievements": [],
                "badges": [],
                "friendsList": [],
                "lastLogin": FieldValue.serverTimestamp(),  // Set at registration
                "preferences": [
                    "notificationsEnabled": true,
                    "privacySettings": [
                        "profileVisible": true,
                        "locationSharingEnabled": false
                    ],
                    "locationTrackingEnabled": false,
                    "participateInResearch": false
                ],
                "activityLog": [],
                "participationInChallenges": [],
                "userLevel": 1
            ] as [String : Any]
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

            // Constructing User object with comprehensive fields
            let user = User(
                uid: uid,
                email: data["email"] as? String ?? "",
                username: data["username"] as? String ?? "UnknownUser",
                firstName: data["firstName"] as? String ?? "",
                lastName: data["lastName"] as? String ?? "",
                createdAt: (data["createdAt"] as? Timestamp)?.dateValue(),
                uploadedDiatoms: data["uploadedDiatoms"] as? [String] ?? [],
                exploredRegions: data["exploredRegions"] as? [String] ?? [],
                leaderboardScores: data["leaderboardScores"] as? [Int] ?? [],
                quizScores: (data["quizScores"] as? [[String: Any]] ?? []).map { QuizScore(date: ($0["date"] as? Timestamp)?.dateValue() ?? Date(), score: $0["score"] as? Int ?? 0) },
                userRegistrationNumber: data["userRegistrationNumber"] as? Int ?? 0,
                achievements: data["achievements"] as? [String] ?? [],
                badges: data["badges"] as? [String] ?? [],
                friendsList: data["friendsList"] as? [String] ?? [],
                lastLogin: (data["lastLogin"] as? Timestamp)?.dateValue(),
                preferences: UserPreferences(
                    notificationsEnabled: (data["preferences"] as? [String: Any])?["notificationsEnabled"] as? Bool ?? false,
                    privacySettings: PrivacySettings(
                        profileVisible: (data["preferences"] as? [String: Any])?["privacySettings.profileVisible"] as? Bool ?? true,
                        locationSharingEnabled: (data["preferences"] as? [String: Any])?["privacySettings.locationSharingEnabled"] as? Bool ?? false
                    ),
                    locationTrackingEnabled: (data["preferences"] as? [String: Any])?["locationTrackingEnabled"] as? Bool ?? false,
                    participateInResearch: (data["preferences"] as? [String: Any])?["participateInResearch"] as? Bool ?? false
                ),
                activityLog: (data["activityLog"] as? [[String: Any]] ?? []).map { UserActivity(date: ($0["date"] as? Timestamp)?.dateValue() ?? Date(), activityType: $0["activityType"] as? String ?? "", description: $0["description"] as? String ?? "") },
                participationInChallenges: data["participationInChallenges"] as? [String] ?? [],
                userLevel: data["userLevel"] as? Int ?? 1
            )
            completion(.success(user))
        }
    }
}

extension FirebaseService {
    // Check if the username already exists in the database
    func usernameExists(username: String, completion: @escaping (Bool) -> Void) {
        let usersRef = Firestore.firestore().collection("users")
        usersRef.whereField("username", isEqualTo: username).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}

