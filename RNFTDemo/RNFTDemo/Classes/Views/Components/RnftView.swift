//
//  RnftView.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import SwiftUI
import Solana

struct RnftView: View {
    
    var rnft: Rnft
    var publicKey: PublicKey?
    
    var body: some View {
        
        content()
            .frame(
                minWidth: 0,
                maxWidth: .infinity
            )
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.foreground)
            )
        
    }
    
    // ============================================================
    // === Private API ============================================
    // ============================================================
    
    // MARK: Private Properties
    
    // MARK: Private Methods
    
    private func content() -> some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            image()
            
            attributes()
            
            Spacer()
            
            footer()
            
        }
        
    }
    
    private func image() -> some View {
        
        VStack(spacing: 0) {
            
            AsyncImage(
                url: rnft.image,
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 250,
                            maxHeight: 250
                        )
                },
                placeholder: {
                    Color.black
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 250,
                            maxHeight: 250
                        )
                }
            )
            
            Divider()
                .frame(height: 2)
                .background(Color.foreground)
            
        }
        
        
    }
    
    private func attributes() -> some View {
        
        VStack(alignment: .leading, spacing: 24) {
            
            ForEach(rnft.attributes ?? []) { attribute in
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    if !attribute.value.isEmpty {
                        
                        Text(attribute.traitType.display)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .font(.monosopacedTitle)
                            .foregroundColor(.foreground)
                        
                        Text(AttributedString(attribute.value))
                            .frame(minWidth: 0, maxWidth:.infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .font(.monosopacedBody)
                            .foregroundColor(.foreground)
                        
                    }
                    
                }
                
            }
            
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 24)
        
    }
    
    private func footer() -> some View {
        
        Color.foreground
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 34,
                maxHeight: 34
            )
            .foregroundColor(.background)
            .overlay(link())
        
    }
    
    @ViewBuilder
    private func link() -> some View {
        
        if publicKey != nil {
            
            Button(action: {
                
                UIApplication.shared.open(URL(string: "https://explorer.solana.com/address/\(publicKey!)?cluster=devnet")!)
                
            }, label: {
                
                HStack {
                    
                    Text("Open In Solana Explore")
                        .font(.monosopacedCaption)
                    
                    Spacer()
                    
                    Image(systemName:"arrow.up.right.square")
                        .tint(Color("Background"))
                    
                }
                .padding(.horizontal)
                
            })
                .tint(Color("Background"))
            
        } else {
            
            EmptyView()
            
        }
        
    }
    
}

#if DEBUG
struct RnftView_Previews: PreviewProvider {
    static var previews: some View {
        
        ScrollView {
            RnftView(rnft: Rnft.preview())
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color("Background")
                )
        }
        
        ScrollView {
            RnftView(rnft: Rnft.preview(), publicKey: PublicKey(string: "7YQxLnTeE36kGKrnAVzNVDyZ6fcGE5CSascr2j41H8EN"))
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color("Background")
                )
        }
        
    }
}
#endif
