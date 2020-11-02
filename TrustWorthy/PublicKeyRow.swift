//
//  PublicKeyRow.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/24.
//

import SwiftUI

struct PublicKeyRow: View {
    @EnvironmentObject var userData: OBS
    @State var asPresented : Bool = false
    @State var sureToDelete : Bool = false
    var id: Int
    var label: String
    var key: String
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
                    Alert.Button.default(Text("Select")){
                        userData.data.selected = self.id
                        userData.data.selectedLabel = self.label
                        UserData.saveJson()
                        userData.makeYouRefresh.toggle()
                    },
                    Alert.Button.destructive(Text("Delete")){
                        self.sureToDelete.toggle()
                    }
                ]
            )
        })
        .alert(isPresented: $sureToDelete, content: {
            Alert(title: Text("Sure to delete?"), primaryButton: Alert.Button.cancel(), secondaryButton: Alert.Button.destructive(Text("Delete")){
                UserData.removePublicKey(id: self.id)
                if userData.data.selected == self.id {
                    userData.data.selected = nil
                    userData.data.selectedLabel = nil
                    UserData.saveJson()
                    
                }
                userData.makeYouRefresh.toggle()
            })
        })
    }
}

struct PublicKeyRow_Previews: PreviewProvider {
    static var previews: some View {
        PublicKeyRow(id: 1, label: "张亮", key: "asd")
    }
}
