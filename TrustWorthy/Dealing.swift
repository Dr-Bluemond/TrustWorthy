//
//  Dealing.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/21.
//

import Foundation
import CryptorECC

func dealWithInput(_ input:String) -> String {
    do{
        let text = "hello, world"
        let eccPrivateKey = try ECPrivateKey.make(for: .prime256v1)
        
        let eccPublicKey = try eccPrivateKey.extractPublicKey()
        
        let encryptedData = try text.encrypt(with: eccPublicKey)
        let decryptedData = try encryptedData.decrypt(with: eccPrivateKey)
        
        return String(data: decryptedData, encoding: .utf8)!
    } catch {
        print("Unknown Error")
    }
  
    return "failed"
}




