//
//  TextAnalyse.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/27.
//

import Foundation
import CryptorECC
let pattern = #"^\[(.*?):(.*?):(.*?)\](.*)"#
func analyse(text: String, pubKeyId: Int?) -> String {
    do {
        let r = try NSRegularExpression(pattern: pattern)
        let result = r.firstMatch(in: text, options: [], range: NSRange(text.startIndex..., in: text))
        if let result = result {
            let one = String(text[Range(result.range(at: 1), in: text)!]) // keyword
            let two = String(text[Range(result.range(at: 2), in: text)!]) // id
            let three = String(text[Range(result.range(at: 3), in: text)!]) //label
            let four = String(text[Range(result.range(at: 4), in: text)!]) //publicKey or text

            if one == "TWPK", let theirId = Int(two) {
                do {
                    let key = try ECPublicKey(key: text)
                    UserData.addPublicKey(label: three, theirId: theirId, key: key.pemString)
                    return "Imported a public key successfully: \(three)"
                } catch {
                    return "Failed to import a public key"
                }
            }
            
            if one == "TWED", let id = Int(two) {
                let data = four
                for priKey in UserData.share.privateKeys {
                    if priKey.id == id {
                        return priKey.decryptData(raw: data)
                    }
                }
                return "No key found for this encryped data"
            }
        }
    } catch {
        return "Unknown Error Occured"
    }
    if let id = pubKeyId {
        for key in UserData.share.publicKeys {
            if key.id == id {
                return key.encryptData(raw: text)
            }
        }
        return "Public key not found, please select another"
    }
    return "Public key not selected"
}
