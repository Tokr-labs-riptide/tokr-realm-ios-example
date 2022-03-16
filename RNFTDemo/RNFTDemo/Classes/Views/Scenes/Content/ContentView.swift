//
//  ContentView.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
            
        
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color("Background")
                )
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
                .tint(Color("Foreground"))
            
        } else {
            
            Button {
                viewModel.login()
            } label: {
                Text("Login")
            }
            .frame(width: 150, height: 44)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color("Foreground"))
            )
            
        }
        
    }
    
    private func loggedInContent() -> some View {
        
        VStack {
            
            if viewModel.isLoading {
                
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(Color("Foreground"))
                
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
        .frame(width: UIScreen.main.bounds.width)
        .listStyle(.plain)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
