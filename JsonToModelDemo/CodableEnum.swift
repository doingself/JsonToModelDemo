//
//  CodableEnum.swift
//  JsonToModelDemo
//
//  Created by syc on 2021/8/14.
//

import Foundation

/// 使用 CodableEnum 解决 Codeable 解析时, 类型不匹配
enum CodableEnum: Codable {
    case int(num: Int)
    case double(num: Double)
    case string(str: String)
    case dictionary(dict: [String: CodableEnum])
    case array(arr: [CodableEnum])
    
    var intValue: Int? {
        switch self {
        case .int(num: let num): return num
        case .double(num: let num): return Int(num)
        case .string(str: let str): return Int(str)
        case .dictionary(dict: _): return nil
        case .array(arr: _): return nil
        }
    }
    
    var doubleValue: Double? {
        switch self {
        case .int(num: let num): return Double(num)
        case .double(num: let num): return num
        case .string(str: let str): return Double(str)
        case .dictionary: return nil
        case .array: return nil
        }
    }
    
    var stringValue: String? {
        switch self {
        case .int(num: let num): return "\(num)"
        case .double(num: let num): return "\(num)"
        case .string(str: let str): return str
        case .dictionary: return nil
        case .array: return nil
        }
    }
    
    var arrarValue: [CodableEnum]? {
        switch self {
        case .int: return nil
        case .double: return nil
        case .string: return nil
        case .dictionary: return nil
        case .array(arr: let arr): return arr
        }
    }
    
    var dictValue: [String: CodableEnum]? {
        switch self {
        case .int: return nil
        case .double: return nil
        case .string: return nil
        case .dictionary(dict: let dict): return dict
        case .array: return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(Int.self) {
            self = CodableEnum.int(num: value)
            return
        }
        
        if let value = try? container.decode(Double.self) {
            self = CodableEnum.double(num: value)
            return
        }
        
        if let value = try? container.decode(String.self) {
            self = CodableEnum.string(str: value)
            return
        }
        
        if let value = try? container.decode([String: CodableEnum].self) {
            self = CodableEnum.dictionary(dict: value)
            return
        }
        
        if let value = try? container.decode([CodableEnum].self) {
            self = CodableEnum.array(arr: value)
            return
        }
        
        throw DecodingError.typeMismatch(CodableEnum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AnyTypeCodableEnum"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(num: let num):
            try container.encode(num)
        case .double(num: let num):
            try container.encode(num)
        case .string(str: let str):
            try container.encode(str)
        case .dictionary(dict: let dict):
            try container.encode(dict)
        case .array(arr: let arr):
            try container.encode(arr)
        }
    }
}
