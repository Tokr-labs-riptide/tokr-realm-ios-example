//
//  RNFTDemoApp.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import SwiftUI

@main
struct RNFTDemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TabsView()
        }
    }
    
}
