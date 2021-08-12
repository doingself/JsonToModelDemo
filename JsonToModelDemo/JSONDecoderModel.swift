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
    let birthday: String?
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
