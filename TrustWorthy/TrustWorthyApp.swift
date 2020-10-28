//
//  TrustWorthyApp.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/19.
//

import SwiftUI

@main
struct TrustWorthyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(OBS())
        }
    }
}
