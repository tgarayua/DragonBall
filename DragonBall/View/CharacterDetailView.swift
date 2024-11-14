//
//  CharacterDetailView.swift
//  DragonBall
//
//  Created by Thomas Garayua on 11/13/24.
//

import SwiftUI

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [.purple, .black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Character Image with animation and shadow
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 250, height: 600)
                    .background(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                    .scaleEffect(1.1)
                    .padding(.top, 20)
                    .animation(.spring(response: 0.6, dampingFraction: 0.8))
                    
                    // Character Name
                    Text(character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 4)
                    
                    // Character Details with styling
                    VStack(alignment: .leading, spacing: 10) {
                        detailRow(label: "Race", value: character.race)
                        detailRow(label: "Gender", value: character.gender)
                        detailRow(label: "Ki", value: character.ki)
                        detailRow(label: "Max Ki", value: character.maxKi)
                        detailRow(label: "Affiliation", value: character.affiliation)
                        
                        Text("Description")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        Text(character.description)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 4)
                    }
                    .padding()
                }
                .padding()
            }
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Helper view for styling detail rows
    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text("\(label):")
                .font(.headline)
                .foregroundColor(.white)
            Text(value)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(.vertical, 5)
        .background(Color.white.opacity(0.1))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 4)
    }
}


//#Preview {
//    CharacterDetailView()
//}
