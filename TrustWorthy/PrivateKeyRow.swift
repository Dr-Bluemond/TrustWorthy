//
//  PubKeyRow.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/22.
//

import SwiftUI

struct PrivateKeyRow: View {
    @EnvironmentObject var userData: OBS
    @State var asPresented : Bool = false
    var id: Int
    var label: String
    var publicKey: String
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
                    Alert.Button.default(Text("Copy Public Key to Clipboard")){
                        if let publicKey = UserData.getPrivateKey(id: id)?.publicKeyToSend {
                            UIPasteboard.general.string = publicKey
                        }
                    },
                    Alert.Button.destructive(Text("Copy Private Key to Clipboard")){
                        if let privateKey = UserData.getPrivateKey(id: id)?.privateKey {
                            UIPasteboard.general.string = privateKey
                        }
                    },
                    Alert.Button.destructive(Text("Delete")){
                        UserData.removePrivateKey(id: self.id)
                        userData.makeYouRefresh.toggle()
                        
                    }
                ]
            )
        })
    }
}

struct PrivateKeyRow_Previews: PreviewProvider {
    static var previews: some View {
        PrivateKeyRow(id: 1, label: "张亮", publicKey: "agjghjghjghjghjghghjgjhghjgjghgjhgjsdf")
    }
}
