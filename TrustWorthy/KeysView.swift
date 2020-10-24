//
//  KeyView.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/21.
//

import SwiftUI


struct KeysView: View {
    @State var myTrue: Bool = false
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                List {
                    Text("PrivateKeys:")
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                    PrivateKeyRow(label: "马云", publicKey: "asdghjghjgjghjjgjhghjgjhghjhjghghf")
                    PrivateKeyRow(label: "朱绍铭", publicKey: "asdf")
                }
                List {
                    Text("PublicKeys:")
                        .font(.headline)
                    NavigationLink (
                        destination: Text("Destination"),
                        label: {
                            Text("Navigate")
                        })
                
                }
            }.navigationBarItems(trailing: Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){Image(systemName: "plus").imageScale(.large)}
                                    
                                    
            )
        }
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeysView()
    }
}
