//
//  SnackView.swift
//  NeppatsrevCoffee
//
//  Created by Tiffany Hames on 5/5/2024.
//

import SwiftUI

// Seperated from DrinkView because Snacks don't have any options to modify.
struct SnackView: View {
	@EnvironmentObject var cartManager: CartManager  // Access to the global cart manager object to manage cart items.
		var item: CartItem  // The snack item to display.

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				Image(item.imageName)
					.resizable()
					.scaledToFit()
					.frame(height: 300)
					.cornerRadius(10)

				VStack(alignment: .leading, spacing: 5) {
					Text(item.name).font(.title).bold()
					Text(item.description).font(.body)
				}
				.padding()

				// Button to add the item to the cart.
				Button(action: { addToCart() }) {
					Text("Add to Cart - \(String(format: "$%.2f", item.price))")
						.frame(maxWidth: .infinity)
						.font(.title2)
						.padding()
						.foregroundColor(.white)
						.background(Color.blue)
						.cornerRadius(10)
				}
				.buttonStyle(.plain)
				.padding(.top, 20)
			}
			.padding()
			.navigationTitle("Details")
			.navigationBarTitleDisplayMode(.inline)
		}
	}

	// Adds the current snack item to the cart.
	private func addToCart() {
		cartManager.addItem(item)
	}
}

// Preview Provider
struct SnackView_Previews: PreviewProvider {
	static var previews: some View {
		SnackView(item: CartItem(id: 1, name: "Homemade Shortbread Biscuit", price: 4.20, description: "Buttery and crumbly, a classic treat to pair with your coffee.", imageName: "shortbread-pexels-perfect-lens-13143701", type: .snack, size: "Regular", milk: "Full Cream", shots: 2, isDecaf: false))
			.environmentObject(CartManager()) // Make sure the CartManager is provided for the previews
	}
}
