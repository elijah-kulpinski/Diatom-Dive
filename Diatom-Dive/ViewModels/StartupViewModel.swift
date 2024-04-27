//
//  StartupViewModel.swift
//  Diatom-Dive
//
//  ViewModel for StartupView. Manages the state and transitions for the startup sequence, including
//  an animated spinning image and the appearance of a welcome message. Handles user interactions
//  to transition to the LoginView either after a delay or upon interaction.
//
//  Created by Eli Kulpinski on 3/28/24.
//

import Combine
import Foundation
import SwiftUI

class StartupViewModel: ObservableObject {
    @Published var isSpinning = false
    @Published var showWelcomeText = false
    @Published var navigateToLogin = false
    @Published var hasNavigated = false
    @Published var spinDegrees = 0.0

    private var rotationTimer: Timer?

    func startAnimations() {
        isSpinning = true
        
        // Start spinner rotation with a smooth and consistent increment
        rotationTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.spinDegrees += 5  // Adjust the increment for a smoother rotation
            // No need to reset to 0; continuous increase will ensure smooth clockwise rotation
        }
        
        // Show welcome text after a few seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showWelcomeText = true
            }
        }
        
        // Navigate to LoginView after delay or user interaction
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
            self?.navigateToLogin = true
        }
    }

    func userInteracted() {
        if !hasNavigated {
            navigateToLogin = true
            hasNavigated = true
            rotationTimer?.invalidate()  // Stop the spinner rotation when user interacts
        }
    }

    deinit {
        rotationTimer?.invalidate()  // Ensure the timer is invalidated when the view model is deinitialized
    }
}
