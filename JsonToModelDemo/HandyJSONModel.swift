//
//  HandyJSONModel.swift
//  JsonToModelDemo
//
//  Created by syc on 2021/8/12.
//

import Foundation
import HandyJSON

struct HandyJSONModel: HandyJSON {
    var code: Int?
    var message: String?
    var data: HandyJSONDataModel?
}

struct HandyJSONDataModel: HandyJSON {
    var dataId: Double?
    var name: String?
    var height: String?
    var weight: String?
    var birthday: String?
    var date: String?
    var url: String?
    var status: StatusEnum?
    var list: [String]?
    
    enum StatusEnum: Int, HandyJSONEnum {
        case ten = 10
        case twenty = 20
        case thirty = 30
        case forty = 40
    }
    
    mutating func mapping(mapper: HelpingMapper) {
        // 把dataId转换为json数据里的id
        mapper.specify(property: &dataId, name: "id")
    }
}
