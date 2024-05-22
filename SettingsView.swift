//
//  SettingsView.swift
//  NeppatsrevCoffee
//
//  Created by Ryan Mackintosh on 3/5/2024.
//

import SwiftUI

// No functionality. Hardcoded for display purposes.
struct SettingsView: View {
	var body: some View {
		NavigationView {
			List {
				Section(header: Text("General")) {
					Text("Update Profile")
					Text("FAQ's")
					Text("Customer Service")
					Text("Terms & Conditions")
					Text("Privacy")
					Text("Logout")
				}

				Section {
					HStack {
						VStack(alignment: .leading) {
							Text("Member No.")
								.font(.caption)
								.foregroundColor(.secondary)
							Text("NCVIP00001")
								.fontWeight(.bold)
						}
						Spacer() // This pushes the two VStacks to the opposite ends of the HStack
						VStack(alignment: .trailing) {
							Text("App Version")
								.font(.caption)
								.foregroundColor(.secondary)
							Text("1.0.0")
						}
					}
				}
			}
			.navigationTitle("Settings")
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
			.environmentObject(ProductManager())
			.environmentObject(CartManager())
	}
}
