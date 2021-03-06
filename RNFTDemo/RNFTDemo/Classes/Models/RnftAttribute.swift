//
//  RnftAttribute.swift
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
    case legal
    case unknown
    
    var display: String {
        
        switch self {
            case .name:
                return "Name"
            case .description:
                return "Description"
            case .propertyAddress:
                return "Property Address"
            case .latLong:
                return "Coordinates"
            case .acres:
                return "Acres"
            case .titleMethod:
                return "Title Method"
            case .titleHeldBy:
                return "Title Held By"
            case .einNumber:
                return "EIN Number"
            case .transferRestrictions:
                return "Transfer Restrictions"
            case .marketingName:
                return "Marketing Name"
            case .type:
                return "Type"
            case .sqFt:
                return "SQ FT"
            case .propertyLegalDescription:
                return "Legal Description"
            case .taxParcelNumbers:
                return "Tax Parcel Numbers"
            case .deed:
                return "Deed"
            case .titleInsurance:
                return "Title Insurance"
            case .purchaseContract:
                return "Purchase Contract"
            case .mortgage:
                return "Mortgage"
            case .laoArticlesOfOrganizationFromSecretaryOfState:
                return "LAO Articles Of Organization From Secretary Of State"
            case .spvArticlesOfOrganizationFromSecretaryOfState:
                return "SPV Articles Of Organization From Secretary Of State"
            case .spvOperatingAgreement:
                return "SPV Operating Agreement"
            case .einLetterFromIrs:
                return "EIN Letter From IRS"
            case .assignmentOfMembershipInterestsAgreement:
                return "Assignment Of Membership Interests Agreement"
            case .submittedByAuthorizedRepresentative:
                return "Submitted By Authorized Representative"
            case .legal:
                return "Legal"
            case .unknown:
                return ""
        }
        
    }
    
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
            case .legal:
                return "Fusce convallis enim ipsum, dignissim porttitor ipsum gravida vel. Ut pellentesque nibh in quam elementum porttitor. Curabitur mollis imperdiet purus eget lacinia. Vestibulum eu neque ex. Nunc diam eros, dapibus rhoncus magna vel, fermentum condimentum lacus. Proin congue nisi commodo, scelerisque sapien a, rhoncus erat. Sed consectetur purus vel ligula finibus, et ullamcorper urna rhoncus. Morbi gravida augue id elit faucibus volutpat. Curabitur sit amet metus ut felis malesuada gravida nec eget sapien. Etiam quis diam et dolor dignissim finibus vel sed est. Donec ut varius erat. In nec lectus quis quam vehicula malesuada vitae in metus. Maecenas in nunc ante. Duis quis massa ipsum. Duis elementum nulla vel augue luctus, eget semper felis ullamcorper. Nunc at ex venenatis, euismod libero sed, dapibus tortor."
            case .unknown:
                return ""
        }
      
    }
    #endif
    
}

struct RnftAttribute: Decodable, Identifiable {
    
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
    
    var id: String {
        return traitType.rawValue
    }
    var traitType: RnftTraitType
    var value: String
    
}

extension RnftAttribute {

    init() {
        traitType = .unknown
        value = ""
    }

    init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        traitType = try values.decodeIfPresent(RnftTraitType.self, forKey: .traitType) ?? .unknown
        value = try values.decodeIfPresent(String.self, forKey: .value) ?? ""

    }

    enum CodingKeys: String, CodingKey {

        case traitType = "trait_type"
        case value

    }

}
