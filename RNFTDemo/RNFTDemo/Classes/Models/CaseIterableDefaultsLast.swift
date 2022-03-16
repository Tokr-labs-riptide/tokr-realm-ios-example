//
//  CaseIterableDefaultsLast.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import Foundation

protocol CaseIterableDefaultsLast: Decodable & CaseIterable & RawRepresentable

where RawValue: Decodable, AllCases: BidirectionalCollection { }

extension CaseIterableDefaultsLast {

    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases.last!
    }

}
