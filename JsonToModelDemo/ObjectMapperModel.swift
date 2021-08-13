//
//  ObjectMapperModel.swift
//  JsonToModelDemo
//
//  Created by syc on 2021/8/12.
//

import Foundation
import ObjectMapper

struct ObjectMapperModel: Mappable {
    
    var code: Int?
    var message: String?
    var data: ObjectMapperDataModel?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
}

struct ObjectMapperDataModel: Mappable {
    var id: Int?
    var name: String?
    var height: Int?
    var weight: Double?
    var birthday: Date?
    var date: Date?
    var url: String?
    var status: StatusEnum?
    var list: [Int]?
    
    enum StatusEnum: Int, Codable {
        case ten = 10
        case twenty = 20
        case thirty = 30
        case forty = 40
    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        id <- map["id"]
        name <- map["name"]
        height <- (map["height"], IntTransform())
        weight <- map["weight"]
        birthday <- (map["birthday"], DateFormatterTransform(dateFormatter: dateFormatter))
        date <- (map["birthday"], DateTransform())
        url <- map["url"]
        status <- map["status"]
        list <- map["list"]
        
    }
}

public class IntTransform: TransformType {
    public typealias Object = Int
    public typealias JSON = Any?
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Int? {
        var result: Int?
        guard let json = value else {
            return result
        }
        // 如果是数值类型，小数等，需要用NSNumber
        if let num = json as? NSNumber {
            result = num.intValue
        } else if let num = json as? Int {
            result = num
        } else if let str = json as? String {
            result = Int(str)
        }
        
        return result
    }

    public func transformToJSON(_ value: Int?) -> Any?? {
        guard let object = value else {
            return nil
        }
        return String(object)
    }
}
