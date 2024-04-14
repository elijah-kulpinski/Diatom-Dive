//
//  HomeView.swift
//  Diatom-Dive
//
//  This view serves as the main home screen of the Diatom-Dive app, offering users a dashboard
//  with various functionalities such as database management, map viewing, study resources,
//  and more. The view is designed with user engagement in mind, featuring interactive cards
//  for each function like Database, Map, Resources, Study, Upload, Viewer, and a logout option.
//  It provides a quick and efficient way for users to navigate through the app's features.
//
//  Created by Eli Kulpinski on 3/28/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    // Padding Constants
    private let gridSpacing: CGFloat = 20
    private let cardPadding: CGFloat = 20
    private let gridHorizontalPadding: CGFloat = 20
    private let gridTopPadding: CGFloat = 70
    private let logoutButtonBottomPadding: CGFloat = 30
    
    @State var isLoggedOut: Bool = false

    var body: some View {
        ZStack {
            // Home background
            Image("HomeBackgroundImg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            // Main content arranged in a scrollable grid
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: gridSpacing), GridItem(.flexible())], spacing: gridSpacing) {
                    CardView(imageName: "DatabaseCard", labelText: "Database")
                        .padding([.leading, .trailing], cardPadding)
                    CardView(imageName: "UploadCard", labelText: "Upload")
                        .padding([.leading, .trailing], cardPadding)
                    CardView(imageName: "MapCard", labelText: "Map View")
                        .padding([.leading, .trailing], cardPadding)
                    CardView(imageName: "ViewerCard", labelText: "Viewer")
                        .padding([.leading, .trailing], cardPadding)
                    CardView(imageName: "ResourcesCard", labelText: "Resources")
                        .padding([.leading, .trailing], cardPadding)
                    CardView(imageName: "StudyCard", labelText: "Study")
                        .padding([.leading, .trailing], cardPadding)
                }
                .padding(.horizontal, gridHorizontalPadding)  // Horizontal padding within the grid
                .padding(.top, gridTopPadding)                 // Top padding to separate from the top edge
            }

            // Logout button placed at the bottom
            VStack {
                Spacer()  // Pushes everything down
                Button(action: {
                    // Handle logout action
                    isLoggedOut = true
                }) {
                    Text("Logout")
                        .frame(width: 250, height: 60)
                        .background(Color("LogoutButtonColor"))
                        .cornerRadius(50)
                        .foregroundColor(.black)
                        .font(Font.custom("SF Pro Text", size: 28).weight(.medium))
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
                }
                .padding(.bottom, logoutButtonBottomPadding)  // Bottom padding for logout button
            }
        }
        
        .fullScreenCover(isPresented: $isLoggedOut, onDismiss: {
            isLoggedOut = false // Reset login state when returning
        }) {
            LoginView() // Present LoginView when logged out
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
