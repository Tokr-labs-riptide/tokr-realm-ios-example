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
        Text("Hello, World!")
    }
}

struct RnftView_Previews: PreviewProvider {
    static var previews: some View {
        RnftView(rnft: Rnft.preview())
    }
}
