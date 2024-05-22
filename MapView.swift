//
//  StoreLocaterView.swift
//  NeppatsrevCoffee
//
//  Created by Ryan Mackitosh on 3/5/2024.
//

import SwiftUI
import MapKit

// No functionality here. Just 4 pins for 4 locations.
struct MapView: View {
	@State private var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(latitude: -31.9953, longitude: 115.7618), // Centering on Cottesloe
		span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
	)

	let stores: [Store] = [
		Store(id: 1, name: "Cottesloe", location: CLLocationCoordinate2D(latitude: -31.9953, longitude: 115.7618)),
		Store(id: 2, name: "Swanbourne", location: CLLocationCoordinate2D(latitude: -31.9806, longitude: 115.7602)),
		Store(id: 3, name: "Claremont", location: CLLocationCoordinate2D(latitude: -31.9833, longitude: 115.7796)),
		Store(id: 4, name: "Claremont 2", location: CLLocationCoordinate2D(latitude: -31.9865, longitude: 115.7820))
	]

	var body: some View {
		Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: stores) { store in
			MapPin(coordinate: store.location, tint: .blue)
		}
		.navigationTitle("Store Locator")
	}
}

struct Store: Identifiable {
	let id: Int
	let name: String
	let location: CLLocationCoordinate2D
}

struct MapView_Previews: PreviewProvider {
	static var previews: some View {
		MapView()
	}
}
