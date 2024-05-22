//
//  CartView.swift
//  NeppatsrevCoffee
//
//  Created by Ryan Mackintosh on 4/5/2024.
//

import SwiftUI

/* If I were to do this again, I would take everything out that isn't directly for the View and create a Data/Object class. */

// Defines the data structure for items in the shopping cart.
struct CartItem: Identifiable {
	let id: Int
	let name: String
	let price: Double
	let description: String
	let imageName: String
	let type: ItemType
	var quantity: Int = 1

	// Optional properties for drinks
	var size: String? = nil
	var milk: String? = nil
	var shots: Int? = nil
	var isDecaf: Bool? = nil

	enum ItemType {
		case drink, snack
	}
}

// ObservableObject class that manages the state of the cart items.
class CartManager: ObservableObject {
	@Published var items: [CartItem] = []

	// Adds an item to the cart or increases its quantity if it already exists.
 func addItem(_ item: CartItem) {
	 if let index = items.firstIndex(where: { $0.id == item.id }) {
		 items[index].quantity += 1
	 } else {
		 items.append(item)
	 }
 }

	// Removes an item or decreases its quantity.
 func removeItem(_ item: CartItem) {
	 if let index = items.firstIndex(where: { $0.id == item.id }) {
		 if items[index].quantity > 1 {
			 items[index].quantity -= 1
		 } else {
			 items.remove(at: index)
		 }
	 }
 }

	// Deletes items from the cart using a set of indices.
 func deleteItems(at offsets: IndexSet) {
	 items.remove(atOffsets: offsets)
 }
}

// The main view component for the cart interface.
struct CartView: View {
	@EnvironmentObject var cartManager: CartManager
	@EnvironmentObject var productManager: ProductManager

	var body: some View {
		NavigationView {
			VStack {
				List {
					ForEach($cartManager.items) { $item in
						HStack(spacing: 15) {
							Image(item.imageName)
								.resizable()
								.scaledToFill()
								.frame(width: 50, height: 50)
								.cornerRadius(5)

							VStack(alignment: .leading, spacing: 5) {
								Text(item.name)
									.font(.caption)
									.bold()

								HStack(spacing: 5) {
									Button(action: { item.quantity > 1 ? item.quantity -= 1 : nil }) {
										Image(systemName: "minus.circle.fill")
									}
									.buttonStyle(.bordered)
									.font(.caption2)

									Text("\(item.quantity)")
										.padding(.horizontal, 5)

									Button(action: { item.quantity += 1 }) {
										Image(systemName: "plus.circle.fill")
									}
									.buttonStyle(.bordered)
									.font(.caption2)
								}

								Text("$\(item.price * Double(item.quantity), specifier: "%.2f")")
									.font(.caption)
									.fontWeight(.semibold)
							}

							Spacer()

							Button(action: { self.removeItem(item: item) }) {
								Image(systemName: "trash")
									.foregroundColor(.red)
							}
						}
					}
					.onDelete(perform: deleteItems)
				}

				// Displays total price and GST calculations.
				Text("$\(totalPrice * 0.9, specifier: "%.2f")")
					.frame(maxWidth: .infinity, alignment: .trailing)
				Text("GST: $\(totalPrice * 0.1, specifier: "%.2f")")
					.frame(maxWidth: .infinity, alignment: .trailing)
					.font(.caption)
				Text("Total: $\(totalPrice, specifier: "%.2f")")
					.bold()
					.frame(maxWidth: .infinity, alignment: .trailing)

				HStack {
					VStack(alignment: .leading, spacing: 5) {
						Text("Feel like a snack?")
							.bold()
							.font(.headline)
						Text("Or do you just wanna be a snack ;)")
							.font(.caption)
					}
					.padding()
					Spacer()
				}

				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 10) {
						ForEach(productManager.snacks, id: \.id) { snack in
							snackThumbnail(for: snack)
						}
					}
					.padding(.horizontal)
				}

				Spacer()

				Button("ORDER NOW") {
					// Order logic in future updates :)
				}
				.frame(maxWidth: .infinity)
				.font(.title)
				.padding()
				.foregroundColor(.white)
				.background(Color.blue)
				.cornerRadius(10)
			}
			.padding(.horizontal)
			.navigationTitle("Cart")
		}
	}

	private func deleteItems(at offsets: IndexSet) {
		cartManager.items.remove(atOffsets: offsets)
	}

	private func removeItem(item: CartItem) {
		cartManager.removeItem(item)
	}

	// Helper function to calculate the total price of all items in the cart.
	private var totalPrice: Double {
		cartManager.items.reduce(0) { $0 + $1.price * Double($1.quantity) }
	}

	@ViewBuilder
	private func snackThumbnail(for snack: CartItem) -> some View {
		VStack {
			Image(snack.imageName)
				.resizable()
				.frame(width: 80, height: 80) // Specify width and height to match your design
				.cornerRadius(10)
				.overlay(
					Button(action: { addSnackToCart(snack) }) {
						Image(systemName: "plus.circle.fill")
							.foregroundColor(.blue)
							.padding(5)
					},
					alignment: .topTrailing
				)

			Text(snack.name)
				.font(.caption)
				.lineLimit(1) // Ensures the text does not wrap to a new line
				.frame(width: 80) // Limit the width of the text to match the image width
				.multilineTextAlignment(.center) // Centers the text if it is not long enough to fill the width
		}
	}

	// Adds a snack item directly to the cart from the thumbnail view.
	private func addSnackToCart(_ snack: CartItem) {
		cartManager.addItem(snack)
	}
}

struct CartView_Previews: PreviewProvider {
	static var previews: some View {
		CartView()
			.environmentObject(ProductManager())
			.environmentObject(CartManager())
	}
}
