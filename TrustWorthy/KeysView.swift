//
//  KeyView.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/21.
//

import SwiftUI


struct KeysView: View {
    @EnvironmentObject var userData: OBS
    @State var sheetShow: Bool = false
    @State var labelInput: String = ""
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                List {
                    Text("PrivateKeys:")
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                    ForEach(userData.data.privateKeys) {s in
                        PrivateKeyRow(id: s.id,label: s.label, publicKey: s.publicKeyContent)
                            .environmentObject(userData)
                    }
                }
                List {
                    Text("PublicKeys:")
                        .font(.headline)
                    ForEach(userData.data.publicKeys) {s in
                        PublicKeyRow(id: s.id, label: s.label, key: s.publicKeyContent)
                            .environmentObject(userData)
                    }
                
                }
            }
                .navigationBarItems(trailing: Button(action: {
                    self.labelInput = ""
                    self.sheetShow.toggle()

                }){
                    Image(systemName: "plus")
                    
                }
                .imageScale(.large)
                .sheet(isPresented: $sheetShow, content: {
                    List {
                        VStack(alignment: .leading){
                            Text("New key pair:")
                                .font(.largeTitle)
                                .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
                                
                            Text("Please name your new key pair")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
                        }
                        
                        TextField("Label name", text: $labelInput)
                            .padding(.leading)
                        Button("Confirm") {
                            PrivateKeyStruct.new(label: self.labelInput)
                            self.sheetShow.toggle()
                            userData.makeYouRefresh.toggle()
                        }
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(.leading)
                        Button("Cancel") {
                            self.sheetShow.toggle()
                        }
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(.leading)
                    }
                })
            )
        }
        
    }
}



struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeysView().environmentObject(OBS())
    }
}
