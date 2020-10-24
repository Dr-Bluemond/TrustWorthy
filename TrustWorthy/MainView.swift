//
//  MainView.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/21.
//

import SwiftUI

struct MainView: View {
    @State private var textIn: String = ""
    @State private var textOut: String = ""
    func clone() {
        textOut = dealWithInput(textIn)
    }
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Text("Input")
                    .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
                TextEditor(text: $textIn)
                    .padding(.all)
                    .border(Color.gray, width: 1)
                HStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        Text("Paste")
                    }
                    Button(action: self.clone) {
                        Text("Enter")
                    }
                }
            }
            Divider()
            VStack(alignment: .center) {
                Text("Output")

                TextEditor(text: $textOut)
                    .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
                    .border(Color.gray, width: 1)
                HStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        Text("Copy")
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        Text("Paste")
                    }
                }.padding(.bottom)
            }
        
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
