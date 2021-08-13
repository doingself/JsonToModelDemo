//
//  SwiftyJSONModel.swift
//  JsonToModelDemo
//
//  Created by syc on 2021/8/12.
//

import Foundation
import SwiftyJSON

struct SwiftyJSONModel {
    let code: Int?
    let message: String?
    let data: SwiftyJSONDataModel?
    
    init(json: JSON){
        let id = json["data"]["id"].intValue
        let name = json["data"]["name"].stringValue
        let height = json["data"]["height"].doubleValue
        let weight = json["data"]["weight"].doubleValue
        let birthday = json["data"]["birthday"].stringValue
        let date = json["data"]["date"].doubleValue
        let url = json["data"]["url"].stringValue
        let status = json["data"]["status"].intValue
        let list = json["data"]["list"].arrayValue.map { $0.intValue }
        
        let data = SwiftyJSONDataModel(id: id, name: name, height: height, weight: weight, birthday: birthday, date: date, url: url, status: SwiftyJSONDataModel.StatusEnum(rawValue: status), list: list)
        
        self.code = json["code"].intValue
        self.message = json["message"].stringValue
        self.data = data
    }
}

struct SwiftyJSONDataModel {
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
