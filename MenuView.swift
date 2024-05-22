//
//  MenuView.swift
//  NeppatsrevCoffee
//
//  Created by Ryan Mackintosh on 3/5/2024.
//

import SwiftUI

// Displays the main menu of the app, listing available drinks and snacks.
struct MenuView: View {
		@EnvironmentObject var productManager: ProductManager  // Access to the product data.
		@EnvironmentObject var cartManager: CartManager       // Access to the cart management.

		var body: some View {
			// Wrapping the content inside a navigation view for hierarchical navigation.
			NavigationView {
				// List to display sections and items.
				List {
					// Section for drinks.
					Section(header: Text("Drinks")) {
					ForEach(productManager.drinks) { drink in
						MenuItemView(item: drink)
					}
				}

				// Section for snacks.
				Section(header: Text("Snacks")) {
					ForEach(productManager.snacks) { snack in
						MenuItemView(item: snack)
					}
				}
			}
			.navigationTitle("Mobile Order")
		}
	}
}

// Represents a single menu item within the list.
struct MenuItemView: View {
	var item: CartItem
	@EnvironmentObject var cartManager: CartManager
	@EnvironmentObject var productManager: ProductManager

	var body: some View {
		// Link to navigate to the detailed view of the item.
		NavigationLink(destination: destinationView) {
			HStack {
				Image(item.imageName)
					.resizable()
					.frame(width: 50, height: 50)
					.cornerRadius(5)

				VStack(alignment: .leading) {
					Text(item.name).bold()
					Text(item.description)
						.font(.caption)
						.foregroundColor(.gray)
				}
				Spacer()
			}
		}
	}

	// Determines the destination view based on the type of item (drink or snack).
	@ViewBuilder
	private var destinationView: some View {
		if item.type == .drink {
			DrinkView(drink: productManager.convertToDrink(item))
		} else {
			SnackView(item: item)
		}
	}
}



struct MenuView_Previews: PreviewProvider {
	static var previews: some View {
		MenuView()
			.environmentObject(ProductManager())
			.environmentObject(CartManager())
	}
}
