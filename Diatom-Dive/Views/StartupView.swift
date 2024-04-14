//
//  StartupView.swift
//  Diatom-Dive
//
//  This view serves as the startup screen for the Diatom-Dive app, showcasing an animated
//  spinning image ("DiatomSpinner") and displaying a welcome message after a brief delay.
//  It provides an engaging introduction to the app, indicating initial data loading or
//  other startup checks. The view transitions to the LoginView either after a set timeout
//  or upon user interaction.
//
//  Created by Eli Kulpinski on 3/28/24.
//

import SwiftUI

struct StartupView: View {
    @ObservedObject var viewModel = StartupViewModel()

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image("StartupBackgroundImg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    
                    if viewModel.isSpinning {
                        Image("DiatomSpinner")
                            .resizable()
                            .frame(width: 150, height: 150)
                            // Ensure continuous clockwise rotation
                            .rotationEffect(.degrees(viewModel.spinDegrees))
                            .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: viewModel.spinDegrees)
                    }
                    
                    VStack {
                        if viewModel.showWelcomeText {
                            Text("Welcome to Diatom Dive!")
                                .font(.system(size: 28, weight: .bold, design: .default))
                                // Use opacity transition for fading in
                                .transition(.opacity)
                                .padding(.horizontal)
                        }
                        Spacer()
                    }
                    .padding(.top, geometry.size.height * 0.15)
                    
                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(DragGesture(minimumDistance: 3).onEnded { _ in viewModel.userInteracted() })
                        .gesture(LongPressGesture(minimumDuration: 0.5).onEnded { _ in viewModel.userInteracted() })
                        .onTapGesture { viewModel.userInteracted() }
                    
                    // Handle navigation
                    if viewModel.navigateToLogin {
                        LoginView()
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.startAnimations()  // Ensure animations start on appear
        }
    }
}

struct StartupView_Previews: PreviewProvider {
    static var previews: some View {
        StartupView()
    }
}
