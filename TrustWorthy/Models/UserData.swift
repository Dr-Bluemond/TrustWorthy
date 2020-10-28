//
//  UserData.swift
//  TestiOS
//
//  Created by bluemond on 2020/10/25.
//

import Foundation



class DataStruct: Codable{
    var publicKeys: [PublicKeyStruct]
    var privateKeys: [PrivateKeyStruct]
    var selected: Int?
    var selectedLabel: String?
    var maxPID: Int
    init() {
        publicKeys = []
        privateKeys = []
        selected = nil
        maxPID = 0
    }
}

class UserData {
    static let filesManager : FilesManager = FilesManager()
    static var share : DataStruct = UserData.readJson()
    
    static func addPrivateKey(label: String,  privateKey: String, publicKey: String) {
        let newID: Int = UserData.share.maxPID
        UserData.share.maxPID += 1
        UserData.share.privateKeys.append(PrivateKeyStruct(id: newID, label: label, privateKey: privateKey, publicKey: publicKey))
        UserData.saveJson()
    }
    
    static func removePrivateKey(id: Int) {
        UserData.share.privateKeys.removeAll(where: {pk in
            pk.id == id
        })
        UserData.saveJson()
    }
    
    static func getPrivateKey(id: Int) -> PrivateKeyStruct? {
        return UserData.share.privateKeys.first(where: {pk in
            pk.id == id
        })
        
    }
    
    static func removeAllPrivateKeys() {
        UserData.share.privateKeys.removeAll()
        UserData.saveJson()
    }
    
    static func addPublicKey(label: String, theirId: Int, key: String) {
        var newID: Int
        let maxIdKey = UserData.share.publicKeys.max(by: {x,y in x.id < y.id})
        if  maxIdKey == nil {
           newID = 0
        } else {
            newID = maxIdKey!.id + 1
        }
        UserData.share.publicKeys.append(PublicKeyStruct(id: newID, theirId: theirId, label: label, key: key))
        UserData.share.selected = newID
        UserData.share.selectedLabel = label
        UserData.saveJson()
    }
    
    static func removePublicKey(id: Int) {
        UserData.share.publicKeys.removeAll(where: {pk in
            pk.id == id
        })
        UserData.saveJson()
    }
    
    static func getPublicKey(id: Int) -> PublicKeyStruct?{
        return UserData.share.publicKeys.first(where: {pk in
            pk.id == id
        })
    }
    
    static func removeAllPublicKeys() {

        UserData.share.publicKeys.removeAll()
        UserData.saveJson()
    }
    
    static func readJson() -> DataStruct {
        do {
            let data = try UserData.filesManager.read(fileNamed: "myData.json")
            let decoder = JSONDecoder()
            return try decoder.decode(DataStruct.self, from: data)
        } catch {
            return DataStruct()
        }
    }
    
    static func saveJson(){
        do {
            let data: DataStruct = UserData.share
            let encoder = JSONEncoder()
            let json = try encoder.encode(data)
            try UserData.filesManager.save(fileNamed: "myData.json", data: json)
            return
        } catch{
        }
    }
    
    static func saveString(str: String) -> String{
        do {
            let data = Data(str.utf8)
            try UserData.filesManager.save(fileNamed: "text.txt", data: data)
            return "Success"
        } catch let err as NSError {
            return err.description
        }
    }
    static func readString() -> String? {
        do {
            let data = try UserData.filesManager.read(fileNamed: "text.txt")
            return String(data: data, encoding: .utf8)
        } catch let err as NSError {
            return err.description
        }
    }
}
