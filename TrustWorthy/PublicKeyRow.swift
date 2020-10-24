//
//  PublicKeyRow.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/24.
//

import SwiftUI

struct PublicKeyRow: View {
    @State var asPresented : Bool = false
    var label :String
    var key:String
    var body: some View {
        Button(action: {self.asPresented = true}, label: {
            /*@START_MENU_TOKEN@*/HStack {
                Text("[")
                Text(label)
                    .frame(width: 100.0)
                    .lineLimit(1)
                Text("]")
                Text(key)
                    .lineLimit(1)
            }/*@END_MENU_TOKEN@*/
        })
        .actionSheet(isPresented: $asPresented, content: {
            ActionSheet(title: Text("PublicKey"), message:
                Text("Label: " + label), buttons: [
                    Alert.Button.cancel(),
                    Alert.Button.destructive(Text("Delete"))
                ]
            )
        })
    }
}

struct PublicKeyRow_Previews: PreviewProvider {
    static var previews: some View {
        PublicKeyRow(label: "张亮", key: "asd")
    }
}
