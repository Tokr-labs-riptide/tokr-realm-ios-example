//
//  AppDelegate.swift
//  Rhove
//
//  Created by Eric on 8/30/21.
//

import Foundation
import UIKit
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // ============================================================
    // === Internal API ===========================================
    // ============================================================
    
    // MARK: Internal Properties
    
    // MARK: Internal Methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        let backButtonConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        let backButton = UIImage(systemName: "arrow.backward", withConfiguration: backButtonConfiguration)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(Color.background)
        navBarAppearance.shadowColor = UIColor(.clear)
        navBarAppearance.setBackIndicatorImage(backButton, transitionMaskImage: backButton)
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(Color.foreground),
            NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        ]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().compactScrollEdgeAppearance = navBarAppearance
        } else {
            // Fallback on earlier versions
        }
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(Color.background)
        tabBarAppearance.configureWithOpaqueBackground()
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance.backgroundColor = UIColor(Color.background)
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().tintColor = UIColor(Color.background)
        } else {
            // Fallback on earlier versions
        }
        
        return true
        
    }
    
}
