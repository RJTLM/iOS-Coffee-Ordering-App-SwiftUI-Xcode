//
//  LoyaltyCardView.swift
//  NeppatsrevCoffee
//
//  Created by Ryan Mackintosh on 3/5/2024.
//

import SwiftUI

// No functionality here either, it's all just to demonstrate Proof-of-Concept.
struct VIPView: View {
	// Placeholder for the member's earned points
	@State var pointsEarned: Int = 3 // Simulating points earned (3 is my lucky number)

	var body: some View {
		ScrollView {
			VStack(spacing: 10) {
				// Loyalty Card Information
				VStack(alignment: .leading, spacing: 10) {
					Text("Earn 10 points = Free drink!")
						.bold()
						.foregroundColor(.blue)
						.padding(.bottom, 5)

					Text("1 drink = 1 point")
						.fontWeight(.thin)

					Image("barcode")
						.resizable()
						.scaledToFit()
						.frame(height: 100)
						.padding(.bottom, 5)

					Text("    Member Name:\n    Toto Wolff") // Member name
						.bold()
						.padding(.bottom, 5)

					HStack {
						Text("Member Number:\nNCVIP00001")
						Spacer()
						Text("VIP Points:\n\(pointsEarned)")
					}
					.padding(.horizontal)
				}
				.padding()
				.background(Color.white)
				.cornerRadius(10)
				.shadow(radius: 5)
				.padding(.horizontal)

				// Free Drink Counter
				HStack {
					Text("You have \(10 - pointsEarned) points to your next free drink!")
						.font(.caption)
					Spacer()
					Image(systemName: "cup.and.saucer.fill")
						.foregroundColor(.red)
				}
				.padding()
				.background(Color.white)
				.cornerRadius(10)
				.shadow(radius: 5)
				.padding(.horizontal)

				// Links for Blog and Secret Menu with custom images
				VStack {
					Image("Blog")
						.resizable()
						.scaledToFit()
						.frame(height: 200)
						.cornerRadius(10)
						.shadow(radius: 5)

					Image("SecretMenu")
						.resizable()
						.scaledToFit()
						.frame(height: 200)
						.cornerRadius(10)
						.shadow(radius: 5)
				}
				.padding(.horizontal)
			}
			.navigationTitle("Loyalty Card")
			.padding(.top)
		}
	}
}

struct VIPView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			VIPView()
		}
	}
}
