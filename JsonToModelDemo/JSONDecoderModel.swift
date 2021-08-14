//
//  JSONDecoderModel.swift
//  JsonToModelDemo
//
//  Created by syc on 2021/8/12.
//

import Foundation

struct JSONDecoderModel: Codable {
    let code: Int?
    let message: String?
    let data: JSONDecoderDataModel?
}

struct JSONDecoderDataModel: Codable {
    let id: Int?
    let name: String?
    let height: Double?
    let weight: Double?
    let birthday: String?
    let date: Double?
    let url: String?
    let status: StatusEnum?
    let list: [Int]?
    
    enum StatusEnum: Int, Codable {
        case ten = 10
        case twenty = 20
        case thirty = 30
        case forty = 40
    }
}


struct CodableEnumModel: Codable {
    let code: CodableEnum?
    let message: CodableEnum?
    let data: CodableEnumDataModel?
}

struct CodableEnumDataModel: Codable {
    let id: CodableEnum?
    let name: CodableEnum?
    let height: CodableEnum?
    let weight: CodableEnum?
    let birthday: CodableEnum?
    let date: CodableEnum?
    let url: CodableEnum?
    let status: StatusEnum?
    let list: CodableEnum?
    
    enum StatusEnum: Int, Codable {
        case ten = 10
        case twenty = 20
        case thirty = 30
        case forty = 40
    }
}
