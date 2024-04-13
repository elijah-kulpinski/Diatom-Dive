//
//  NavigationBarView.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 4/12/24.
//

import Foundation
import SwiftUI

struct NavigationBarView: View {
    @Binding var searchText: String
    @Binding var showingBookmarks: Bool  // Binding to manage bookmark visibility
    let viewName: String  // Name of the view for setting the search placeholder dynamically
    var onCommit: () -> Void // Action to perform on commit

    var body: some View {
        HStack {
            Button(action: { print("Back") }) {
                Image(systemName: "arrow.left").foregroundColor(.black)
            }
            Spacer()
            TextField("Search \(viewName)", text: $searchText, onCommit: onCommit)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
            Button(action: { showingBookmarks.toggle() }) {
                Image("BookmarkCollectionIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
            }
        }
        .padding()
        //.background(Color("BackgroundColor"))
    }
}
