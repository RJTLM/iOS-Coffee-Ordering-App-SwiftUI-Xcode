//
//  NeppatsrevCoffeeApp.swift
//  NeppatsrevCoffee
//
//  Created by Ryan Mackintosh on 2/5/2024.
//

import SwiftUI

@main
struct NeppatsrevCoffeeApp: App {
	// Initialise productManager to manage product related data throughout the app.
	var productManager = ProductManager()
	// Initialise cartManager to manage the shopping cart data.
	var cartManager = CartManager()

	var body: some Scene {
		WindowGroup {
			ContentView()
				.environmentObject(productManager) // Injects productManager environment object.
				.environmentObject(cartManager)    // Injects cartManager environment object.
		}
	}
}
