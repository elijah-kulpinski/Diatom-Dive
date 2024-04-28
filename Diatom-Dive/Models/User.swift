//
//  User.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 4/26/24.
//

import Foundation

struct User {
    var uid: String
    var email: String
    var username: String
    var firstName: String
    var lastName: String
    var createdAt: Date?
    var uploadedDiatoms: [String]               // IDs of diatoms uploaded
    var exploredRegions: [String]               // Regions for Fog of War Removal
    var leaderboardScores: [Int]
    var quizScores: [QuizScore]                 // Scores from diatom identification quizzes
    var userRegistrationNumber: Int             // Serial number based on registration order
    var achievements: [String]                  // Achievement IDs or descriptions
    var badges: [String]                        // Badge icons or descriptions
    var friendsList: [String]                   // User IDs or usernames of friends
    var lastLogin: Date?
    var preferences: UserPreferences
    var activityLog: [UserActivity]             // Log of user activities
    var participationInChallenges: [String]     // IDs or names of challenges participated in
    var userLevel: Int                          // User level or rank based on activity points
}

struct UserPreferences {
    var notificationsEnabled: Bool
    var privacySettings: PrivacySettings
    var locationTrackingEnabled: Bool
    var participateInResearch: Bool
}

struct PrivacySettings {
    var profileVisible: Bool
    var locationSharingEnabled: Bool
}

struct QuizScore {
    var date: Date
    var score: Int
}

struct UserActivity {
    var date: Date
    var activityType: String
    var description: String
}
