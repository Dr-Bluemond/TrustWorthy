//
//  Keys.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/23.
//

import Foundation
import CryptorECC


struct PublicKeyStruct: Hashable, Codable, Identifiable {
    var id: Int
    var theirId: Int
    var label: String
    var key: String
}

struct PrivateKeyStruct: Hashable, Codable, Identifiable {
    var id: Int
    var label: String
    var privateKey: String
    var publicKey: String
}


extension PublicKeyStruct {
    var publicKeyObject: ECPublicKey? {
        do {
            let key = try ECPublicKey(key: self.key)
            return key
        } catch {
            return nil
        }
    }
    var publicKeyContent: String {
        let strippedKey = String(self.key.filter { !" \n\t\r".contains($0) })
        let pemComponents = strippedKey.components(separatedBy: "-----")
        
        let full = pemComponents[2]
        let short = "..." + full[full.index(full.endIndex, offsetBy: -15)..<full.endIndex]
        return short
    }
    
    var publicKeyToSend: String {
        return "[TWPK:\(self.id):\(self.label)]\n\(self.key)"
    }
    
    func encryptData(raw: String) -> String{
        do {
            if let publicKeyObject = self.publicKeyObject {
                let encryptedData = try raw.encrypt(with: publicKeyObject)
                let encryptedString = encryptedData.base64EncodedString()
                return "[TWED:\(self.theirId):\(self.label)]\(encryptedString)"
            }
        } catch {
            return "Failed to encrypt"
        }
        return "Failed to encrypt"
    }

}


extension PrivateKeyStruct {
    var privateKeyObject: ECPrivateKey? {
        do {
            let key = try ECPrivateKey(key: self.privateKey)
            return key
        }catch {
            return nil
        }
    }
    var publicKeyObject: ECPublicKey? {
        do {
            let key = try ECPublicKey(key: self.publicKey)
            return key
        } catch {
            return nil
        }
    }
    
    var publicKeyContent: String {
        let strippedKey = String(self.publicKey.filter { !" \n\t\r".contains($0) })
        let pemComponents = strippedKey.components(separatedBy: "-----")
        
        let full = pemComponents[2]
        let short = "..." + full[full.index(full.endIndex, offsetBy: -15)..<full.endIndex]
        return short
    }
    
    static func new(label: String) {
        do {
            let privateKey = try ECPrivateKey.make(for: .prime256v1)
            let publicKey = try privateKey.extractPublicKey()
            UserData.addPrivateKey(label: label, privateKey: privateKey.pemString, publicKey: publicKey.pemString)
        } catch {
            //pass
        }
    }
    var publicKeyToSend: String {
        return "[TWPK:\(self.id):\(self.label)]\n\(self.publicKey)"
    }
    
    func decryptData(raw: String) -> String {
        do {
            if let data = Data(base64Encoded: raw), let privateKeyObject = self.privateKeyObject{
                let decryptedData = try data.decrypt(with: privateKeyObject)
                let decryptedString = String(data: decryptedData, encoding: .utf8)
                return decryptedString!
            }
            return "Failed to decrypt"
        } catch {
            return "Failed to decrypt"
        }

    }
}
