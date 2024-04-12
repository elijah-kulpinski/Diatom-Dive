//
//  CardView.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 4/11/24.
//

import SwiftUI

struct CardView: View {
    let imageName: String
    let labelText: String

    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 175, height: 172)
                .clipShape(TopRoundedCornersShape(cornerRadius: 20))
                
            Text(labelText)
                .font(Font.custom("SF Pro Display", size: 24).weight(.black))
                .foregroundColor(.primary)
                .frame(width: 175, height: 38, alignment: .center)
                .multilineTextAlignment(.center)

        }
        .frame(width: 175, height: 210)
        .background(Color("ButtonBackgroundColor"))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
    }
}

struct TopRoundedCornersShape: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Start from the bottom left
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        
        // Line to the top left, start rounding
        path.addLine(to: CGPoint(x: 0, y: rect.minY + cornerRadius))
        path.addArc(center: CGPoint(x: cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)
        
        // Top edge
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        
        // Top right corner
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 270),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        
        // Right edge and bottom
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}
