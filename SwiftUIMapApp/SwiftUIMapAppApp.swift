//
//  SwiftUIMapAppApp.swift
//  SwiftUIMapApp
//
//  Created by Arqam Owais on 17/09/2023.
//

import SwiftUI

@main
struct SwiftUIMapAppApp: App {
    
    @StateObject private var vm: LocationsViewModel = LocationsViewModel()

    
    var body: some Scene {
        WindowGroup {
            LocationsView().environmentObject(vm)
        }
    }
}
