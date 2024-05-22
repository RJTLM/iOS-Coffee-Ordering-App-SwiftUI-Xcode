//
//  ProductManager.swift
//  NeppatsrevCoffee
//
//  Created by Ryan Mackintosh on 4/5/2024.
//

import Foundation

// Wanted to make the program more modular, idea from PDI student class in Worksheet 8
// Drinks
class ProductManager: ObservableObject {
	@Published var drinks: [CartItem] = [
		CartItem(id: 1, name: "Latte", price: 5.30, description: "A creamy blend of espresso and steamed milk, perfect for a cozy morning.", imageName: "NeppatsrevCoffee", type: .drink, size: "Regular", milk: "Full Cream", shots: 2, isDecaf: false),
		CartItem(id: 2, name: "Cappuccino", price: 5.30, description: "Frothy and light, topped with a sprinkle of cocoa for that tincy bit of deluxe.", imageName: "NeppatsrevCoffee", type: .drink, size: "Regular", milk: "Full Cream", shots: 2, isDecaf: false),
		CartItem(id: 3, name: "Flat White", price: 5.30, description: "Smooth espresso with velvety milk, for those who like it rich.", imageName: "NeppatsrevCoffee", type: .drink, size: "Regular", milk: "Full Cream", shots: 2, isDecaf: false),
		CartItem(id: 4, name: "Espresso", price: 3.60, description: "As strong, bold, and smooth as an Italian man swooning over his lover in the 1980s.", imageName: "NeppatsrevCoffee", type: .drink, size: "Regular", milk: "Full Cream", shots: 2, isDecaf: false),
		CartItem(id: 5, name: "Puppaccino", price: 3.25, description: "A delightful frothy treat for your furry friend.", imageName: "NeppatsrevCoffee", type: .drink, size: "Regular", milk: "Full Cream", shots: 2, isDecaf: false),
		CartItem(id: 6, name: "Babyccino", price: 3.25, description: "A fun, frothy milk treat sprinkled with cocoa, safe for the little ones.", imageName: "NeppatsrevCoffee", type: .drink, size: "Regular", milk: "Full Cream", shots: 2, isDecaf: false)
	]

	// Snacks
	@Published var snacks: [CartItem] = [
		CartItem(id: 7, name: "Homemade Shortbread Biscuit", price: 4.20, description: "Buttery and crumbly, a classic treat to pair with your coffee.", imageName: "shortbread-pexels-perfect-lens-13143701", type: .snack),
		CartItem(id: 8, name: "Grandma's Secret Scones", price: 7.50, description: "Freshly baked, served with jam and a dollop of cream—just like Grandma used to make!", imageName: "scone-pexels-karura-19790953", type: .snack),
		CartItem(id: 9, name: "Choc Chip Vanilla Muffin", price: 6.80, description: "Bursting with chocolate chips and vanilla essence, this muffin can sweeten your day.", imageName: "muffin-pexels-vitezslav-vylicil-3618407-5412341", type: .snack),
		CartItem(id: 10, name: "French Croissant", price: 9.25, description: "Made fresh daily, light, buttery, and flaky—perfect with a cup of espresso.", imageName: "croissant-pexels-elkady-3892469", type: .snack),

		CartItem(id: 11, name: "Puppatreats", price: 8.40, description: "Delicious treats that will make your pooch wag their tail with joy.", imageName: "puppatreats-pexels-rdne-7310213", type: .snack),
		CartItem(id: 12, name: "Babytreats", price: 12.20, description: "Safe and delightful treats specially designed for the two legged little ones.", imageName: "babytreats-pexels-annelies-brouw-976954-3065512", type: .snack),

		CartItem(id: 13, name: "Dutch Brownie", price: 24.00, description: "In honour of Max: Rich, fudgy, and topped with a hint of Dutch cocoa to create a luxurious chocolate experience.", imageName: "brownie-pexels-marta-dzedyshko-1042863-2067396", type: .snack)
	]
}

// Extends ProductManager with utility functions.
extension ProductManager {
	// Converts a CartItem representing a drink into a Drink object, preparing it for customisation.
	func convertToDrink(_ item: CartItem) -> Drink {
		// Converts CartItem to Drink assuming they share similar properties but Drink allows for customisation.
		return Drink(id: item.id, name: item.name, basePrice: item.price, imageName: item.imageName, sizeOptions: ["Small", "Regular", "Large"], selectedSize: "Regular", shotOptions: [1, 2, 3], selectedShots: 2, milkOptions: ["Full Cream", "Skinny", "Almond", "Oat", "Coconut"], selectedMilk: "Full Cream", isDecaf: false)
	}
}
