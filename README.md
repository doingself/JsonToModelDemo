# JsonToModelDemo

JSON Model 相互转换
个人比较喜欢 HandyJSON

## [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

方便 json 读取, 兼容类型不匹配

```
import SwiftyJSON

// 初始化
let json = try JSON(dict)

// 自带类型转换
let status = json["data"]["status"].stringValue
let status = json["data"]["status"].intValue

// 多层级直接读取
let list = json["data"]["list"].arrayValue.map { $0.intValue }
```

## [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)

侵入性太强, 需要解析每个属性, 兼容类型不匹配

```
import ObjectMapper

// 定义
struct ObjectMapperModel: Mappable {
    var code: Int?
    var message: String?

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        code <- (map["code"], IntTransform())
        message <- map["message"]
    }
}

// json 转 model
let model = ObjectMapperModel(JSON: dict)

// model 转 json
let jsonStr = model?.toJSONString()
```

## [HandyJSON](https://github.com/alibaba/HandyJSON)

只需要实现 `HandyJSON` 协议即可, 兼容类型不匹配

```
import HandyJSON
// 定义
struct HandyJSONModel: HandyJSON {
    var code: Int?
    var message: String?
}

// json 转 model
let model = HandyJSONModel.deserialize(from: dict)

// model 转 json
let jsonStr = model?.toJSONString() 
```

## Codable

系统自带, 如果类型不匹配, 则解析失败

```
// 定义
struct JSONDecoderModel: Codable {
    let code: Int?
    let message: String?
}

// decode (json -> data -> model)
let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
let model = try decoder.decode(JSONDecoderModel.self, from: data)

// encode (model -> data -> json)
let encoder = JSONEncoder()
let jsonData = try encoder.encode(model)
let encoderStr = String(data: jsonData, encoding: String.Encoding.utf8)
```

## 扩展一下 Codable

定义自定义枚举 (也可以是其他类型)

```
/// 使用 CodableEnum 解决 Codeable 解析时, 类型不匹配
enum CodableEnum: Codable {
    case int(num: Int)
    case double(num: Double)
    case string(str: String)
    
    var intValue: Int? {
        switch self {
        case .int(num: let num): return num
        case .double(num: let num): return Int(num)
        case .string(str: let str): return Int(str)
        }
    }
    
    var doubleValue: Double? { ... }
    
    var stringValue: String? { ... }
    
    init(from decoder: Decoder) throws { ... }
}
```

所有属性使用都使用 `CodableEnum` 类型

```
struct CodableEnumDataModel: Codable {
    let id: CodableEnum?
    let name: CodableEnum?
}
```

使用

```
model.name.intValue
model.name.doubleValue
model.name.stringValue
```
