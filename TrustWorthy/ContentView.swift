//
//  ContentView.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/19.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: OBS
    var body: some View {
        TabView() {
            MainView().tabItem {
                Image(systemName: "house.fill")
                Text("Main")
                
            }.tag(1)
            KeysView().tabItem {
                Image(systemName: "lock.fill")
                Text("Keys")
            }.tag(2)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(OBS())
    }
}
