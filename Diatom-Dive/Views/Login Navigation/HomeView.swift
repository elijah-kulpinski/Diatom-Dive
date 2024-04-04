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
      Image("HomeBackground") // HomeBackground asset
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 393, height: 852)
        .offset(x: 0, y: 0)
      
      // Top bar decoration
      HStack(spacing: 0) {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 139, height: 5)
          .background(.black)
          .cornerRadius(100)
          .rotationEffect(.degrees(-180))
      }
      .padding(EdgeInsets(top: 0, leading: 127, bottom: 0, trailing: 127))
      .frame(width: 393, height: 21)
      .offset(x: -2, y: 415.50)

      // Clock in the top bar
      HStack(spacing: 67) {
        HStack(spacing: 4) {
          HStack(spacing: 0) {
            Text("9")
              .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
              .foregroundColor(.black)
            Text(":")
              .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
              .foregroundColor(.black)
            Text("41")
              .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
              .foregroundColor(.black)
          }
        }
        HStack(spacing: 8.50) {
          HStack(alignment: .bottom, spacing: 2) {

          }
          .frame(width: 18, height: 10)
          VStack(spacing: -1.08) {

          }
          .frame(width: 16, height: 11.62)
          ZStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 17, height: 8)
              .background(.black)
              .cornerRadius(1)
              .offset(x: -1.50, y: 0)
          }
          .frame(width: 24, height: 12)
        }
      }
      .padding(EdgeInsets(top: 16, leading: 35, bottom: 16, trailing: 20))
      .frame(width: 393, height: 48)
      .background(Color(red: 1, green: 1, blue: 1).opacity(0))
      .offset(x: 0, y: -402)

      // Database Card
      Image("DatabaseCard") // DatabaseCard asset
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 175, height: 210)
        .cornerRadius(20)
        .offset(x: -95, y: -233)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
      
      // Upload Card
      Image("UploadCard") // UploadCard asset
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 175, height: 210)
        .cornerRadius(20)
        .offset(x: 95, y: -233)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)

      // Map Card
      Image("MapCard") // MapCard asset
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 175, height: 210)
        .cornerRadius(20)
        .offset(x: -95, y: -9)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)

      // Viewer Card
      Image("ViewerCard") // ViewerCard asset
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 175, height: 210)
        .cornerRadius(20)
        .offset(x: 95, y: -9)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)

      // Resources Card
      Image("ResourcesCard") // ResourcesCard asset
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 175, height: 210)
        .cornerRadius(20)
        .offset(x: -95, y: 215)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)

      // Study Card
      Image("StudyCard") // StudyCard asset
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 175, height: 210)
        .cornerRadius(20)
        .offset(x: 95, y: 215)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)

      // Text Labels for Cards
      Group {
        Text("Database")
          .font(Font.custom("SF Pro Display", size: 24).weight(.bold))
          .foregroundColor(.black)
          .offset(x: -95, y: -149.50)

        Text("Upload")
          .font(Font.custom("SF Pro Display", size: 24).weight(.bold))
          .foregroundColor(.black)
          .offset(x: 95, y: -149.50)

        Text("Map View")
          .font(Font.custom("SF Pro Display", size: 24).weight(.bold))
          .foregroundColor(.black)
          .offset(x: -95, y: 74.50)

        Text("Viewer")
          .font(Font.custom("SF Pro Display", size: 24).weight(.bold))
          .foregroundColor(.black)
          .offset(x: 94.50, y: 74.50)

        Text("Resources")
          .font(Font.custom("SF Pro Display", size: 24).weight(.bold))
          .foregroundColor(.black)
          .offset(x: -95.50, y: 298.50)

        Text("Study")
          .font(Font.custom("SF Pro Display", size: 24).weight(.bold))
          .foregroundColor(.black)
          .offset(x: 95, y: 298.50)
      }

      // Logout Button
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 281, height: 71)
        .background(Color(red: 0.53, green: 0.92, blue: 1))
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
