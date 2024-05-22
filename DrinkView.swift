//
//  DrinkView.swift
//  NeppatsrevCoffee
//
//  Created by Ryan Mackintosh on 3/5/2024.
//

import SwiftUI

// Defines the properties of a drink available.
struct Drink: Identifiable {
	let id: Int
	let name: String
	let basePrice: Double
	let imageName: String
	var sizeOptions: [String] = ["Small", "Regular", "Large"]
	var selectedSize: String = "Regular" {
		didSet {
			updateShotsForSize()  // Adjusts the default number of shots based on the selected size.
		}
	}
	var shotOptions: [Int] = [1, 2, 3]
	var selectedShots: Int = 2
	var milkOptions: [String] = ["Full Cream", "Skinny", "Almond", "Oat", "Coconut"]
	var selectedMilk: String = "Full Cream"
	var isDecaf: Bool = false

	// Calculates the price based on the selected options.
	var price: Double {
		var finalPrice = basePrice
		if selectedMilk != "Full Cream" {
			finalPrice += 0.50
		}
		if isDecaf {
			finalPrice += 0.50
		}
		finalPrice += Double(selectedShots - 2) * 0.50
		return finalPrice
	}

	// Updates the default number of espresso shots based on the selected drink size.
	mutating func updateShotsForSize() {
		switch selectedSize {
		case "Small":
			selectedShots = 1
		case "Regular":
			selectedShots = 2
		case "Large":
			selectedShots = 3
		default:
			selectedShots = 2
		}
	}
}

// View for customising and adding a drink to the cart.
struct DrinkView: View {
	@EnvironmentObject var cartManager: CartManager  // Accesses the cart data from the environment.
		@State var drink: Drink  // State for local modifications.

	var body: some View {
		Form {
			Section(header: Text("Customise Your Drink")) {
				Image(drink.imageName)
					.resizable()
					.scaledToFit()
					.frame(height: 300)

				Picker("Size", selection: $drink.selectedSize) {
					ForEach(drink.sizeOptions, id: \.self) { size in
						Text(size).tag(size)
					}
				}

				Stepper(value: $drink.selectedShots, in: 1...6) {
					Text("Shots: \(drink.selectedShots)")
				}

				Picker("Milk", selection: $drink.selectedMilk) {
					ForEach(drink.milkOptions, id: \.self) { milk in
						Text(milk).tag(milk)
					}
				}

				Toggle(isOn: $drink.isDecaf) {
					Text("Decaf")
				}
			}

			Section {
				Button(action: addToCart) {
					Text("Add to Cart - \(String(format: "$%.2f", drink.price))")
						.frame(maxWidth: .infinity)
						.font(.title2)
						.padding()
						.foregroundColor(.white)
						.background(Color.blue)
						.cornerRadius(10)
				}
				.buttonStyle(.plain)
			}
		}
		.navigationTitle(drink.name)
		.navigationBarTitleDisplayMode(.inline)
	}

	// Adds the customised drink to the cart.
	private func addToCart() {
		let cartItem = CartItem(
			id: drink.id,  // Unique identifier for the cart item.
			name: drink.name,
			price: drink.price,
			description: "Customised \(drink.name)",
			imageName: drink.imageName,
			type: .drink,
			quantity: 1,
			size: drink.selectedSize,
			milk: drink.selectedMilk,
			shots: drink.selectedShots,
			isDecaf: drink.isDecaf  // Make sure the CartItem structure supports this
		)
		cartManager.addItem(cartItem)
	}
}

// Preview Provider
struct DrinkView_Previews: PreviewProvider {
	static var previews: some View {
		DrinkView(drink: Drink(id: 1, name: "Latte", basePrice: 5.30, imageName: "NeppatsrevCoffee", sizeOptions: ["Small", "Regular", "Large"], selectedSize: "Regular", shotOptions: [1, 2, 3], selectedShots: 2, milkOptions: ["Full Cream", "Skinny", "Almond", "Oat", "Coconut"], selectedMilk: "Full Cream", isDecaf: false))
		.environmentObject(CartManager())
	}
}
