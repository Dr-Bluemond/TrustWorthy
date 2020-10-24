//
//  PubKeyRow.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/22.
//

import SwiftUI

struct PrivateKeyRow: View {
    @State var asPresented : Bool = false
    var label :String
    var publicKey:String
    var body: some View {
        Button(action: {self.asPresented = true}, label: {
            /*@START_MENU_TOKEN@*/HStack {
                Text("[")
                Text(label)
                    .frame(width: 100.0)
                    .lineLimit(1)
                Text("]")
                Text(publicKey)
                    .lineLimit(1)
            }/*@END_MENU_TOKEN@*/
        })
        .actionSheet(isPresented: $asPresented, content: {
            ActionSheet(title: Text("PrivateKey"), message:
                Text("Label: " + label), buttons: [
                    Alert.Button.cancel(),
                    Alert.Button.default(Text("Copy Public Key to Clipboard")),
                    Alert.Button.destructive(Text("Copy Private Key to Clipboard")),
                    Alert.Button.destructive(Text("Delete"))
                ]
            )
        })
    }
}

struct PrivateKeyRow_Previews: PreviewProvider {
    static var previews: some View {
        PrivateKeyRow(label: "张亮", publicKey: "agjghjghjghjghjghghjgjhghjgjghgjhgjsdf")
    }
}
