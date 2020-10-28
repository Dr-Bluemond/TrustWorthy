//
//  File.swift
//  TrustWorthy
//
//  Created by bluemond on 2020/10/26.
//

import Foundation

// 由于SwiftUI我还弄不懂的刷新机制，照葫芦画瓢弄了这个，makeYouRefresh项没有任何意义，只是告诉EnvironmentObject它刷新了

final class OBS: ObservableObject {
    @Published var data = UserData.share
    @Published var makeYouRefresh = false
}

