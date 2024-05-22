//
//  ContentView.swift
//  NeppatsrevCoffee
//
//  Created by Ryan Mackintosh on 2/5/2024.
//

import SwiftUI

// ContentView struct defines the main view for the NeppastrevCoffee app.
struct ContentView: View {
	// Access shared cartManager instance defined elsewhere in the app.
	@EnvironmentObject var cartManager: CartManager

	var body: some View {
		// TabView to hold various main views of the app as tab items.
		TabView {
			// Menu view tab
			MenuView()
				.tabItem {
					Label("Menu", systemImage: "list.bullet") // System icon and text label for the tab.
				}

			// VIP section view tab
			VIPView()
				.tabItem {
					Label("VIP", systemImage: "star") // System icon and text label for the tab.
				}

			// Map view for store locations tab
			MapView()
				.tabItem {
					Label("Stores", systemImage: "map.fill") // System icon and text label for the tab.
				}

			// Cart view wrapped in a NavigationView to allow navigation to detailed views.
			NavigationView {
				CartView()
			}
			.tabItem {
				Label {
					Text("Cart")
				} icon: {
					// Icon for the cart, showing number of items dynamically
					if cartManager.items.count > 0 {
						Image(systemName: "cart")
						Text("\(cartManager.items.count)")
							.font(.caption2)
							.foregroundColor(.white)
							.padding(5)
							.background(Color.red)
							.clipShape(Circle())
							.offset(x: 10, y: -10)
					} else {
						Image(systemName: "cart")
					}
				}
			}

			// Settings view tab
			SettingsView()
				.tabItem {
					Label("Settings", systemImage: "gear") // System icon and text label for the tab.
				}
		}
	}
}

// SwiftUI preview for ContentView
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(ProductManager())
			.environmentObject(CartManager()) // Providing the environment object for preview
	}
}
