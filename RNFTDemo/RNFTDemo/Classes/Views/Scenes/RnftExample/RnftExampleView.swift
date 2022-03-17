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
            .onAppear {
                viewModel.getExampleRnft()
            }
        
    }
    
    // ============================================================
    // === Private API ============================================
    // ============================================================
    
    // MARK: Private Properties
    
    // MARK: Private Methods
    
    private func content() -> some View {
        
        VStack {
            
            if viewModel.rnft != nil, !viewModel.isLoading {
                
                ScrollView {
                    
                    RnftView(
                        rnft: viewModel.rnft!,
                        publicKey: viewModel.publicKey
                    )
                        .padding(.top, 24)
                        .padding(.horizontal)
                        .padding(.bottom, 32)
                    
                }
                
                
            } else {
                
                if viewModel.isLoading {
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.foreground)
                    
                }
                
            }
            
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
