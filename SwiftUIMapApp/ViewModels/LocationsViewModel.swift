//
//  LocationsViewModel.swift
//  SwiftUIMapApp
//
//  Created by Arqam Owais on 18/09/2023.
//

import Foundation
import SwiftUI
import MapKit

final class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current Location on Map
    @Published var mapLocation: Location {
        didSet {
             updateMapRegion(location: mapLocation)
        }
    }
    
    // Current Region on Map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of all locations
    @Published var showLocationsList: Bool = false
    
    @Published var sheetLocation: Location? = nil

    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonTapped() {
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            return
        }
        
        let nextIndex: Int = currentIndex + 1
        
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first else {
                return
            }
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation: Location = locations[nextIndex]
        showNextLocation(location: nextLocation)

    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) { [weak self] in
            guard let self else {
                return
            }
            self.mapRegion = MKCoordinateRegion(center: location.coordinates, span: self.mapSpan) 
        }
    }
    
}
