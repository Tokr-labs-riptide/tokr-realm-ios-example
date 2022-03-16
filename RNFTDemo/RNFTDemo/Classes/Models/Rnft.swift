//
//  Rnft.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import Foundation

enum RnftTraitType: String, Codable, CaseIterableDefaultsLast {
    
    case name
    case description
    case propertyAddress = "property_address"
    case latLong = "lat_long"
    case acres
    case titleMethod = "title_method"
    case titleHeldBy = "title_held_by"
    case einNumber = "ein_number"
    case transferRestrictions = "transfer_restrictions"
    case marketingName = "marketing_name"
    case type
    case sqFt = "sq_ft"
    case propertyLegalDescription = "property_legal_description"
    case taxParcelNumbers = "tax_parcel_numbers"
    case deed
    case titleInsurance = "title_insurance"
    case purchaseContract = "purchase_contract"
    case mortgage
    case laoArticlesOfOrganizationFromSecretaryOfState = "lao_articles_of_organization_from_secretary_of_state"
    case spvArticlesOfOrganizationFromSecretaryOfState = "spv_articles_of_organization_from_secretary_of_state"
    case spvOperatingAgreement = "spv_operating_agreement"
    case einLetterFromIrs = "ein_letter_from_irs"
    case assignmentOfMembershipInterestsAgreement = "assignment_of_membership_interests_agreement"
    case submittedByAuthorizedRepresentative = "submitted_by_authorized_representative"
    case unknown
    
    #if DEBUG
    var preview: String {

        switch self {
            case .name:
                return "0 High St"
            case .description:
                return "0 High St is the first property Tokrized on the Solana Blockchain. This lot is composed of two parcels of land located in Brinkhaven, OH. This is a vacant lot situated in the Village of Brinkhaven, County of Knox in the State of Ohio."
            case .propertyAddress:
                return "0 High Street, Brinkhaven, Ohio 43006"
            case .latLong:
                return "40.4687361, -82.1924952"
            case .acres:
                return "0.2"
            case .titleMethod:
                return "Sole ownership"
            case .titleHeldBy:
                return "Real Fake Lot LLC, an Ohio limited liability company"
            case .einNumber:
                return "881082701"
            case .transferRestrictions:
                return "None"
            case .marketingName:
                return "0 High"
            case .type:
                return "Lot"
            case .sqFt:
                return "8,712"
            case .propertyLegalDescription:
                return "Situated in the Village of Brinkhaven, County of Knox and State of Ohio and being more particularly described as follows: Beginning at a point on the East line of High Street in the Village of Gann, now Brinkhaven. Being Lots Nos. 7 & 8 of the L. Gardner Sub-Division."
            case .taxParcelNumbers:
                return "62-00106.000 and 62-00107.000."
            case .deed:
                return "https://rhove.box.com/s/f8xjhbi9zgb3euvc2r8k681jzxflxn4e"
            case .titleInsurance:
                return "https://rhove.box.com/s/vn33yggvf5dkt3umzwu8ophh702ssjah"
            case .purchaseContract:
                return "https://rhove.box.com/s/9sjxoazw7kmmq3e9s1oj8a1anz8cnmv5"
            case .mortgage:
                return "n/a"
            case .laoArticlesOfOrganizationFromSecretaryOfState:
                return "https://rhove.box.com/s/8mqd9cdacoyvld0o4jaq1la70bx70wg8"
            case .spvArticlesOfOrganizationFromSecretaryOfState:
                return "https://rhove.box.com/s/ofy7hgb9swljt8wn2d3hdm2es26rorat"
            case .spvOperatingAgreement:
                return "https://rhove.box.com/s/8zngttfljzhixs4e7zqyp64a4ubre7i5"
            case .einLetterFromIrs:
                return "https://rhove.box.com/s/idt0iolz1m3getgpljupj0dbbhsgvyxv"
            case .assignmentOfMembershipInterestsAgreement:
                return "https://rhove.box.com/s/rw3eg3zen69pslyjlpn4cblpa8q02ymv"
            case .submittedByAuthorizedRepresentative:
                return "Calvin Cooper"
            case .unknown:
                return ""
        }
      
    }
    #endif
    
}

struct RnftAttribute: Decodable {
    
    // ============================================================
    // === Internal Static API ====================================
    // ============================================================

    // MARK: Internal Static Methods

    #if DEBUG

    static func preview() -> [RnftAttribute] {

        return RnftTraitType.allCases.map({
            RnftAttribute(traitType: $0, value: $0.preview)
        })
      
    }

    #endif

    // ============================================================
    // === Internal API ===========================================
    // ============================================================

    // MARK: Internal Properties
    
    var traitType: RnftTraitType
    var value: String
}

struct Rnft: Decodable, Identifiable {

    // ============================================================
    // === Internal Static API ====================================
    // ============================================================

    // MARK: Internal Static Methods

    #if DEBUG

    static func preview() -> Rnft {

        return Rnft(
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

    var id: String {
        return symbol
    }
    
    var name: String
    var symbol: String
    var description: String
    var image: URL?
    var attributes: [RnftAttribute]?
    

}

extension Rnft {

    init() {
        name = ""
        symbol = ""
        description = ""
    }

    init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

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
