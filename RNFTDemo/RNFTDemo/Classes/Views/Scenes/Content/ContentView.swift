//
//  ContentView.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import SwiftUI
import Solana

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        
        content()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .alert(
                viewModel.errorMessage,
                isPresented: $viewModel.shouldShowErrorMessage
            ) {
                
                Button("OK") {
                    // Handle acknowledgement
                }
                
            }
        
    }
    
    @ViewBuilder
    private func content() -> some View {
        
        if viewModel.isLoggedIn {
            loggedInContent()
        } else {
            loggedOutContent()
        }
        
    }
    
    @ViewBuilder
    private func loggedOutContent() -> some View {
        
        if viewModel.isLoggingIn {
            
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.foreground)
            
        } else {
            
            Button {
                
                viewModel.login()
                
            } label: {
                
                Text("Login")
                    .frame(width: 150, height: 44)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.foreground)
                    )
                
            }
            
            
            
        }
        
    }
    
    private func loggedInContent() -> some View {
        
        VStack {
            
            if viewModel.isLoading {
                
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.foreground)
                
            } else {
                
                ScrollView {
                    
                    VStack(spacing: 16) {
                        ForEach(viewModel.rnfts) {
                            RnftView(rnft: $0)
                        }
                    }
                    .padding(.top, 24)
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                    
                }
                
            }
            
        }
        .navigationTitle(viewModel.solanaPublicKeyShortString)
        .frame(width: UIScreen.main.bounds.width)
        .listStyle(.plain)
        .toolbar {
            
            ToolbarItem(
                id: "open-solana-explore",
                placement: .navigationBarTrailing,
                showsByDefault: true
            ) {
                
                Button {
                    
                    UIApplication.shared.open(
                        URL(string:"https://explorer.solana.com/address/\(viewModel.solanaPublicKeyString)?cluster=devnet")!
                    )
                    
                } label: {
                    
                    Image(systemName: "arrow.up.forward.square")
                        .foregroundColor(.foreground)
                    
                }

                
            }
            
        }
        
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    
    static var loggedOutViewModel: ContentViewModel {
        
        let model = ContentViewModel()
        
        model.isLoggedIn = false

        return model
        
    }
    
    static var loggedInViewModel: ContentViewModel {
        
        let model = ContentViewModel()
        
        model.isLoggingIn = false
        model.isLoggedIn = true
        model.solanaPublicKey = PublicKey(string: "7YQxLnTeE36kGKrnAVzNVDyZ6fcGE5CSascr2j41H8EN")
        model.rnfts = [Rnft.preview()]
        
        return model
        
    }
    
    static var previews: some View {
        
        NavigationView {
            ContentView(viewModel: loggedInViewModel)
        }
        
        NavigationView {
            ContentView(viewModel: loggedOutViewModel)
        }
        
    }
    
}
#endif
