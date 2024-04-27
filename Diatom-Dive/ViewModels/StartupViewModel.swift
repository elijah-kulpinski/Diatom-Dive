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
    private var navigationTimer: Timer?

    func startAnimations() {
        isSpinning = true

        // Start spinner rotation with a smooth and consistent increment
        rotationTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.spinDegrees += 7.5  // Adjust the increment for a smoother rotation
        }

        // Show welcome text after a few seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showWelcomeText = true
            }
        }

        // Navigate to LoginView after delay or user interaction
        navigationTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if !self.hasNavigated {
                    self.navigateToLogin = true
                    self.hasNavigated = true
                    // Ensure to stop the timers to prevent re-triggering navigation
                    self.invalidateTimers()
                }
            }
        }
    }

    func userInteracted() {
        if !hasNavigated {
            navigateToLogin = true
            hasNavigated = true
            invalidateTimers()
        }
    }

    private func invalidateTimers() {
        rotationTimer?.invalidate()
        navigationTimer?.invalidate()
        rotationTimer = nil
        navigationTimer = nil
    }

    deinit {
        invalidateTimers()
    }
}
