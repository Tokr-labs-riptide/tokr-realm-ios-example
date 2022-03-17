//
//  TabsView.swift
//  RhoveBeta
//
//  Created by Eric on 3/16/22.
//

import Foundation
import SwiftUI

struct TabsView: View {
    
    // ============================================================
    // === Internal API ===========================================
    // ============================================================
    
    // MARK: Internal Properties
    
    @StateObject var viewModel = TabsViewModel()
    
    var body: some View {
        
        TabView(selection: $viewModel.selectedTab) {
            
            NavigationView {
                ContentView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Content")
            }
            .tag(Tab.content)
            
            NavigationView {
                RnftExampleView()
            }
            .tabItem {
                Image(systemName: "list.dash")
                Text("Example")
            }
            .tag(Tab.example)
            
        }
        .tint(.foreground)
        
    }
    
}

#if DEBUG
struct TabsView_Previews: PreviewProvider {
    
    static var previews: some View {
        TabsView(viewModel: TabsViewModel())
    }
    
}
#endif
