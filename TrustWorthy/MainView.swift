//
//  MainView.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var userData: OBS
    @State private var textIn: String = ""
    @State private var textOut: String = ""

    func enter() {
        self.textOut = analyse(text: self.textIn, pubKeyId: userData.data.selected)
        userData.makeYouRefresh.toggle()
    }
    var body: some View {
        
        VStack {
            VStack(alignment: .center) {
                Text("Input:")
                    .padding([.top, .leading, .trailing])
                    .font(.headline)
                TextEditor(text: $textIn)
                    .border(Color.gray, width: 1)
                    .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 2)
                HStack {
                    Button(action: {self.textIn = ""}) {
                        Text("Clear")
                    }
                    Button(action: {
                        self.textIn = UIPasteboard.general.string ?? self.textIn
                    }){
                        Text("Paste")
                    }
                    Button(action: self.enter) {
                        Text("Enter")
                    }
                }
            }
            Divider()
            Text("Selected Public Key: \(userData.data.selectedLabel ?? "not selected")")
            Divider()
            VStack(alignment: .center) {
                Text("Output:")
                    .font(.headline)
                TextEditor(text: $textOut)
                    .border(Color.gray, width: 1)
                    .padding([.leading, .trailing])
                    .shadow(radius: 2)
                HStack {
                    Button(action: {
                        UIPasteboard.general.string = textOut
                    }){
                        Text("Copy")
                    }
                }.padding(.bottom)
            }
        
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(OBS())
    }
}
