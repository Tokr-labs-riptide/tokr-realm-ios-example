//
//  Rnft.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import Foundation

struct Rnft: Decodable, Identifiable {

    // ============================================================
    // === Internal Static API ====================================
    // ============================================================

    // MARK: Internal Static Methods

    #if DEBUG

    static func preview() -> Rnft {

        return Rnft(
            id: UUID().uuidString,
            name: "0 High St",
            symbol: "TOKR-0HighSt",
            description: "0 High St is the first property Tokrized on the Solana Blockchain. This lot is composed of two parcels of land located in Brinkhaven, OH. This is a vacant lot situated in the Village of Brinkhaven, County of Knox in the State of Ohio. More particularly, the lot is described as follows - Beginning at a point on the East line of High Street in the Village of Gann, now Brinkhaven. Being Lots Nos. 7 & 8 of the L. Gardner Sub-Division.",
            image: URL(string: "https://www.fillmurray.com/g/1125/750"),
            attributes: RnftAttribute.preview()
        )

    }

    #endif

    // ============================================================
    // === Internal API ===========================================
    // ============================================================

    // MARK: Internal Properties

    var id: String
    var name: String
    var symbol: String
    var description: String
    var image: URL?
    var attributes: [RnftAttribute]?
    

}

extension Rnft {

    init() {
        id = UUID().uuidString
        name = ""
        symbol = ""
        description = ""
    }

    init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = UUID().uuidString
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol) ?? ""
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        image = try? values.decode(URL.self, forKey: .image)
        attributes = try? values.decode([RnftAttribute]?.self, forKey: .attributes)
        
    }

    enum CodingKeys: String, CodingKey {

        case name
        case symbol
        case description
        case image
        case attributes

    }

}
