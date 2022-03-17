//
//  TabsViewModel.swift
//  RhoveBeta
//
//  Created by Eric on 3/16/22.
//

import SwiftUI

enum Tab {
    
    case content
    case example
    
}

class TabsViewModel: ObservableObject {
    
    @Published var selectedTab: Tab = .example
    
}
