//
//  Keys.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/23.
//

import Foundation
import CryptorECC
struct PrivateKey: Hashable, Codable, Identifiable {
    var id: Int
    fileprivate var privateKeyString: String

}
extension PrivateKey {
    var key: ECPrivateKey? {
        do {
            let key = try ECPrivateKey(key: privateKeyString)
            return key
        } catch {
            return nil
        }
    }
}

struct PublicKey: Hashable, Codable, Identifiable {
    var id: Int
    fileprivate var publicKeyString: String

}
extension PublicKey {
    var key: ECPublicKey? {
        do {
            let key = try ECPublicKey(key: publicKeyString)
            return key
        }catch {
            return nil
        }
    }
}
