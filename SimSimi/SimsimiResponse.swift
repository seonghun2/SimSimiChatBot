//
//  SimsimaResponse.swift
//  SimSimi
//
//  Created by user on 2023/02/08.
//

import Foundation

struct SimsimiResponse: Codable {
    let status: Int?
    let statusMessage, atext, lang, utext: String?
    let qtext, country: String?
    let atextBadProb: Int?
    let atextBadType, registDate: String?

    enum CodingKeys: String, CodingKey {
        case status, statusMessage, atext, lang, utext, qtext, country
        case atextBadProb = "atext_bad_prob"
        case atextBadType = "atext_bad_type"
        case registDate = "regist_date"
    }
}
