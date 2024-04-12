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

import SwiftUI

struct HomeView: View {
  var body: some View {
    ZStack {
      // Home background
      Image("HomeBackgroundImg") // HomeBackground asset
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 393, height: 852)
        .offset(x: 0, y: 0)

        // Using CardView for each functionality
        // Database Card
        CardView(imageName: "DatabaseCard", labelText: "Database")
            .offset(x: -95, y: -233)
        
        // Upload Card
        CardView(imageName: "UploadCard", labelText: "Upload")
            .offset(x: 95, y: -233)
        
        // Map Card
        CardView(imageName: "MapCard", labelText: "Map View")
            .offset(x: -95, y: -9)
        
        // Viewer Card
        CardView(imageName: "ViewerCard", labelText: "Viewer")
            .offset(x: 95, y: -9)
        
        // Resources Card
        CardView(imageName: "ResourcesCard", labelText: "Resources")
            .offset(x: -95, y: 215)
        
        // Study Card
        CardView(imageName: "StudyCard", labelText: "Study")
            .offset(x: 95, y: 215)

      // Logout Button
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 281, height: 71)
        .background(Color("LogoutButtonColor"))
        .cornerRadius(50)
        .offset(x: -8, y: 369.50)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
      
      Text("Logout")
        .font(Font.custom("SF Pro Text", size: 28).weight(.medium))
        .foregroundColor(.black)
        .offset(x: -8, y: 369.50)
    }
    .frame(width: 393, height: 852)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
