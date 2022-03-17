//
//  RnftExampleView.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import SwiftUI

struct RnftExampleView: View {
    
    // ============================================================
    // === Internal API ===========================================
    // ============================================================
    
    // MARK: Internal Properties
    
    @StateObject var viewModel = RnftExampleViewModel()
    
    // MARK: Internal Methods
    
    var body: some View {
        
        content()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    // ============================================================
    // === Private API ============================================
    // ============================================================
    
    // MARK: Private Properties
    
    // MARK: Private Methods
    
    @ViewBuilder
    private func content() -> some View {

        if viewModel.rnft != nil {
            
            ScrollView {
                
                RnftView(
                    rnft: viewModel.rnft!,
                    publicKey: viewModel.publicKey
                )
                
            }
            
            
        } else {
            
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.foreground)
            
        }
            
    }
    
}

#if DEBUG
struct RnftExampleView_Previews: PreviewProvider {
    
    static var previews: some View {
        RnftExampleView()
    }
    
}
#endif
