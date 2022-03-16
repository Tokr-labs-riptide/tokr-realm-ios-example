//
//  RnftView.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import SwiftUI

struct RnftView: View {
    
    var rnft: Rnft
    
    var body: some View {
        
        VStack(alignment: .center) {
            
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
              
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(rnft.attributes ?? []) { attribute in
                        if !attribute.value.isEmpty {
                            
                            Text(attribute.traitType.display)
                                .multilineTextAlignment(.leading)
                                .font(.headline)
                                .foregroundColor(Color("Foreground"))
                                .frame(minWidth: 0, maxWidth:.infinity)

                            Text(attribute.value)
                                .multilineTextAlignment(.leading)
                                .font(.body)
                                .foregroundColor(Color("Foreground"))
                                .frame(minWidth: 0, maxWidth:.infinity)

                        }
                    }
                }
                
            }
            
            Spacer()
            
            Color("Foreground")
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 34,
                    maxHeight: 34
                )
                .foregroundColor(Color("Background"))
                .overlay(
                    
                    Button(action: {
                        UIApplication.shared.open(URL(string: "https://explorer.solana.com/address/\("")?cluster=devnet")!)
                    }, label: {
                        
                        HStack {
                            
                            Text("Open In Solana Explore")
                                .font(.footnote)
                            
                            Spacer()
                            
                            Image(systemName:"arrow.up.right.square")
                                .font(.footnote)
                                .tint(Color("Background"))

                        }
                        .padding(.horizontal)
                        
                    })
                    .tint(Color("Background"))
                    
                )
                
            
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity
        )
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 2)
                .foregroundColor(Color("Foreground"))
        )
        
        
        
    }
}

struct RnftView_Previews: PreviewProvider {
    static var previews: some View {
        RnftView(rnft: Rnft.preview())
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("Background")
            )
    }
}
