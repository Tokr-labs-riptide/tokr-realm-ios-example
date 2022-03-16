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
        
        NavigationView {
            
            content()
                .padding()
                .alert(
                    viewModel.errorMessage,
                    isPresented: $viewModel.shouldShowErrorMessage
                ) {
                    Button("OK") {
                        // Handle acknowledgement
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            
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
            
        } else {
            
            Button {
                viewModel.login()
            } label: {
                Text("Login")
            }
            
        }
        
    }
    
    private func loggedInContent() -> some View {
       
        List(viewModel.rnfts) { rnft in
            NavigationLink {
                RnftView(rnft: rnft)
            } label: {
                Text(rnft.name)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(width: UIScreen.main.bounds.width)
        .listStyle(.plain)
        .toolbar {
            
            ToolbarItem(
                id: "logout",
                placement: .bottomBar,
                showsByDefault: true
            ) {
                
                Button {
                    viewModel.logout()
                } label: {
                    Text("Logout")
                }
                .tint(.red)
                
            }
            
        }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
