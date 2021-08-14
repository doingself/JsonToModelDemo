//
//  ViewController.swift
//  JsonToModelDemo
//
//  Created by syc on 2021/8/12.
//

import UIKit
import SnapKit

let jsonDict: [String: Any] = [
    "code": 0,
    "message": "操作成功",
    "data": [
        "id": 789,
        "name": "haha",
        "height": 789.123,
        "birthday": "2021-08-10",
        "date": 1628839481521.123,
        "url": "https://abc.def.com",
        "status": 30,
        "list": [7,8,9]
    ]
]

class ViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private let SwiftyJSONButton = UIButton()
    private let ObjectMapperButton = UIButton()
    private let HandyJSONButton = UIButton()
    private let CodableButton = UIButton()
    private let CodableEnumButton = UIButton()
    private let infoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "json to model"
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .always
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        configUI()
        
        layoutUI()
        
    }
}

extension ViewController {
    func configUI() {
        
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        
        SwiftyJSONButton.setTitle("SwiftyJSONButton", for: UIControl.State.normal)
        ObjectMapperButton.setTitle("ObjectMapperButton", for: UIControl.State.normal)
        HandyJSONButton.setTitle("HandyJSONButton", for: UIControl.State.normal)
        CodableButton.setTitle("CodableButton", for: UIControl.State.normal)
        CodableEnumButton.setTitle("CodableEnumButton", for: UIControl.State.normal)
        
        SwiftyJSONButton.backgroundColor = UIColor.systemTeal
        ObjectMapperButton.backgroundColor = UIColor.systemTeal
        HandyJSONButton.backgroundColor = UIColor.systemTeal
        CodableButton.backgroundColor = UIColor.systemTeal
        CodableEnumButton.backgroundColor = UIColor.systemTeal
        
        SwiftyJSONButton.addTarget(self, action: #selector(SwiftyJSONButtonAction), for: UIControl.Event.touchUpInside)
        ObjectMapperButton.addTarget(self, action: #selector(ObjectMapperButtonAction), for: UIControl.Event.touchUpInside)
        HandyJSONButton.addTarget(self, action: #selector(HandyJSONButtonAction), for: UIControl.Event.touchUpInside)
        CodableButton.addTarget(self, action: #selector(CodableButtonAction), for: UIControl.Event.touchUpInside)
        CodableEnumButton.addTarget(self, action: #selector(CodableEnumButtonAction), for: UIControl.Event.touchUpInside)
        
        infoLabel.numberOfLines = 0
        infoLabel.layer.borderWidth = 1
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(SwiftyJSONButton)
        scrollView.addSubview(ObjectMapperButton)
        scrollView.addSubview(HandyJSONButton)
        scrollView.addSubview(CodableButton)
        scrollView.addSubview(CodableEnumButton)
        scrollView.addSubview(infoLabel)
    }
    func layoutUI(){
        let width = self.view.bounds.width
        scrollView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide)
                //make.bottom.equalTo(self.view.safeAreaLayoutGuide)
                make.bottom.equalToSuperview()
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            }
            make.width.equalTo(width)
        }
        SwiftyJSONButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview().inset(100)
            make.width.equalTo(width-200)
            make.height.equalTo(44)
        }
        ObjectMapperButton.snp.makeConstraints { make in
            make.top.equalTo(SwiftyJSONButton.snp_bottomMargin).offset(20)
            make.left.equalToSuperview().inset(100)
            make.width.equalTo(width-200)
            make.height.equalTo(44)
        }
        HandyJSONButton.snp.makeConstraints { make in
            make.top.equalTo(ObjectMapperButton.snp_bottomMargin).offset(20)
            make.left.equalToSuperview().inset(100)
            make.width.equalTo(width-200)
            make.height.equalTo(44)
        }
        CodableButton.snp.makeConstraints { make in
            make.top.equalTo(HandyJSONButton.snp_bottomMargin).offset(20)
            make.left.equalToSuperview().inset(100)
            make.width.equalTo(width-200)
            make.height.equalTo(44)
        }
        CodableEnumButton.snp.makeConstraints { make in
            make.top.equalTo(CodableButton.snp_bottomMargin).offset(20)
            make.left.equalToSuperview().inset(100)
            make.width.equalTo(width-200)
            make.height.equalTo(44)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(CodableEnumButton.snp_bottomMargin).offset(50)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(100)
            make.width.equalTo(width-40)
            make.height.greaterThanOrEqualTo(400)
        }
    }
}

// MARK: JSONDecoder
extension ViewController {
    @objc func CodableButtonAction(){
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            // decode
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(JSONDecoderModel.self, from: data)
            
            // encode
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(model)
            let encoderStr = String(data: jsonData, encoding: String.Encoding.utf8)
            var str = String()
            str += "==== Codable ==== code: Int? = \(model.code ?? -123) \n"
            str += "==== Codable ==== message: String? = \(model.message ?? "message") \n"
            str += "==== Codable ==== data.id: Int? = \(model.data?.id ?? -123) \n"
            str += "==== Codable ==== data.name: String? = \(model.data?.name ?? "name") \n"
            str += "==== Codable ==== data.height: Double? = \(model.data?.height ?? -123.456) \n"
            str += "==== Codable ==== data.weight: Double? = \(model.data?.weight ?? -123.456) \n"
            str += "==== Codable ==== data.birthday: String? = \(model.data?.birthday ?? "birthday") \n"
            str += "==== Codable ==== data.date: Double? = \(model.data?.date ?? -123.456) \n"
            str += "==== Codable ==== data.url: String? = \(model.data?.url ?? "url") \n"
            str += "==== Codable ==== data.status: Enum? = \(model.data?.status ?? .ten) \n"
            str += "==== Codable ==== data.list: [Int]? = \(model.data?.list ?? [-1,-2,-3]) \n\n"
            str += "==== Codable ==== encoderStr: String? = \(encoderStr ?? "encoderStr") \n\n"
            print(str)
            infoLabel.text = str
            
        } catch {
            print(error)
        }
    }
    
    @objc func CodableEnumButtonAction(){
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            // decode
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(CodableEnumModel.self, from: data)
            
            // encode
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(model)
            let encoderStr = String(data: jsonData, encoding: String.Encoding.utf8)
            var str = String()
            str += "==== Codable ==== code: CodableEnum?.Double = \(model.code?.doubleValue ?? -123.456) \n"
            str += "==== Codable ==== code: CodableEnum?.Int = \(model.code?.intValue ?? -123) \n"
            str += "==== Codable ==== code: CodableEnum?.String = \(model.code?.stringValue ?? "string") \n"
            str += "==== Codable ==== message: CodableEnum?.Double = \(model.message?.doubleValue ?? -123.456) \n"
            str += "==== Codable ==== message: CodableEnum?.Int = \(model.message?.intValue ?? -123) \n"
            str += "==== Codable ==== message: CodableEnum?.String = \(model.message?.stringValue ?? "string") \n"
            str += "==== Codable ==== data?.id: CodableEnum?.Double = \(model.data?.id?.doubleValue ?? -123.456) \n"
            str += "==== Codable ==== data?.id: CodableEnum?.Int = \(model.data?.id?.intValue ?? -123) \n"
            str += "==== Codable ==== data?.id: CodableEnum?.String = \(model.data?.id?.stringValue ?? "string") \n"
            str += "==== Codable ==== data?.name: CodableEnum?.Double = \(model.data?.name?.doubleValue ?? -123.456) \n"
            str += "==== Codable ==== data?.name: CodableEnum?.Int = \(model.data?.name?.intValue ?? -123) \n"
            str += "==== Codable ==== data?.name: CodableEnum?.String = \(model.data?.name?.stringValue ?? "string") \n"
            str += "==== Codable ==== data?.height: CodableEnum?.Double = \(model.data?.height?.doubleValue ?? -123.456) \n"
            str += "==== Codable ==== data?.height: CodableEnum?.Int = \(model.data?.height?.intValue ?? -123) \n"
            str += "==== Codable ==== data?.height: CodableEnum?.String = \(model.data?.height?.stringValue ?? "string") \n"
            str += "==== Codable ==== data?.weight: CodableEnum?.Double = \(model.data?.weight?.doubleValue ?? -123.456) \n"
            str += "==== Codable ==== data?.weight: CodableEnum?.Int = \(model.data?.weight?.intValue ?? -123) \n"
            str += "==== Codable ==== data?.weight: CodableEnum?.String = \(model.data?.weight?.stringValue ?? "string") \n"
            str += "==== Codable ==== data?.birthday: CodableEnum?.Double = \(model.data?.birthday?.doubleValue ?? -123.456) \n"
            str += "==== Codable ==== data?.birthday: CodableEnum?.Int = \(model.data?.birthday?.intValue ?? -123) \n"
            str += "==== Codable ==== data?.birthday: CodableEnum?.String = \(model.data?.birthday?.stringValue ?? "string") \n"
            str += "==== Codable ==== data?.date: CodableEnum?.Double = \(model.data?.date?.doubleValue ?? -123.456) \n"
            str += "==== Codable ==== data?.date: CodableEnum?.Int = \(model.data?.date?.intValue ?? -123) \n"
            str += "==== Codable ==== data?.date: CodableEnum?.String = \(model.data?.date?.stringValue ?? "string") \n"
            str += "==== Codable ==== data?.url: CodableEnum?.Double = \(model.data?.url?.doubleValue ?? -123.456) \n"
            str += "==== Codable ==== data?.url: CodableEnum?.Int = \(model.data?.url?.intValue ?? -123) \n"
            str += "==== Codable ==== data?.url: CodableEnum?.String = \(model.data?.url?.stringValue ?? "string") \n"
            str += "==== Codable ==== data?.status: Enum = \(model.data?.status ?? .ten) \n"
            str += "==== Codable ==== data?.list: CodableEnum?.Array = \(model.data?.list?.arrarValue ?? [.int(num: -10), .string(str: "string"), .double(num: -123.456)]) \n\n"
            str += "==== CodableEnum ==== encoderStr: String? = \(encoderStr ?? "string") \n\n"
            print(str)
            infoLabel.text = str
            
        } catch {
            print(error)
        }
    }
}

// MARK: SwiftyJSON
import SwiftyJSON
extension ViewController {
    @objc func SwiftyJSONButtonAction(){
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let json = try JSON(data: data)
            
            let model = SwiftyJSONModel(json: json)
            
            var str = String()
            str += "==== SwiftyJSON ==== code: Int? = \(model.code ?? -123) \n"
            str += "==== SwiftyJSON ==== message: String? = \(model.message ?? "message") \n"
            str += "==== SwiftyJSON ==== data.id: Int? = \(model.data?.id ?? -123) \n"
            str += "==== SwiftyJSON ==== data.name: String? = \(model.data?.name ?? "name") \n"
            str += "==== SwiftyJSON ==== data.height: Int? = \(model.data?.height ?? -123) \n"
            str += "==== SwiftyJSON ==== data.weight: Double? = \(model.data?.weight ?? -123.456) \n"
            str += "==== SwiftyJSON ==== data.birthday: String? = \(model.data?.birthday ?? "birthday") \n"
            str += "==== SwiftyJSON ==== data.date: Double? = \(model.data?.date ?? -123.456) \n"
            str += "==== SwiftyJSON ==== data.url: String? = \(model.data?.url ?? "url") \n"
            str += "==== SwiftyJSON ==== data.status: Enum? = \(model.data?.status ?? .ten) \n"
            str += "==== SwiftyJSON ==== data.list: [Int]? = \(model.data?.list ?? [-1,-2,-3]) \n\n"
            str += "==== SwiftyJSON ==== model: String? = \(model) \n\n"
            print(str)
            infoLabel.text = str
            
        } catch {
            print(error)
        }
    }
}

// MARK: ObjectMapper
import ObjectMapper
extension ViewController {
    @objc func ObjectMapperButtonAction(){
        let model = ObjectMapperModel(JSON: jsonDict)
        let jsonStr = model?.toJSONString(prettyPrint: true) // ObjectMapper
        
        var str = String()
        str += "==== ObjectMapper ==== code: Int? = \(model?.code ?? -123) \n"
        str += "==== ObjectMapper ==== message: String? = \(model?.message ?? "message") \n"
        str += "==== ObjectMapper ==== data.id: Int? = \(model?.data?.id ?? -123) \n"
        str += "==== ObjectMapper ==== data.name: String? = \(model?.data?.name ?? "name") \n"
        str += "==== ObjectMapper ==== data.height: Int? = \(model?.data?.height ?? -123) \n"
        str += "==== ObjectMapper ==== data.weight: Double? = \(model?.data?.weight ?? -123.456) \n"
        str += "==== ObjectMapper ==== data.birthday: Date? = \(model?.data?.birthday ?? Date()) \n"
        str += "==== ObjectMapper ==== data.date: Date? = \(model?.data?.date ?? Date()) \n"
        str += "==== ObjectMapper ==== data.url: String? = \(model?.data?.url ?? "url") \n"
        str += "==== ObjectMapper ==== data.status: Enum? = \(model?.data?.status ?? .ten) \n"
        str += "==== ObjectMapper ==== data.list: [Int]? = \(model?.data?.list ?? [-1,-2,-3]) \n\n"
        str += "==== ObjectMapper ==== jsonStr: String? = \(jsonStr ?? "jsonStr") \n\n"
        print(str)
        infoLabel.text = str
    }
}

// MARK: HandyJSON
import HandyJSON
extension ViewController {
    @objc func HandyJSONButtonAction(){
        let model = HandyJSONModel.deserialize(from: jsonDict)
        
        let jsonStr = model?.toJSONString(prettyPrint: true) // HandyJSON
        
        var str = String()
        str += "==== HandyJSON ==== code: Int? = \(model?.code ?? -123) \n"
        str += "==== HandyJSON ==== message: String? = \(model?.message ?? "message") \n"
        str += "==== HandyJSON ==== data.id: Double? = \(model?.data?.dataId ?? -123.456) \n"
        str += "==== HandyJSON ==== data.name: String? = \(model?.data?.name ?? "name") \n"
        str += "==== HandyJSON ==== data.height: String? = \(model?.data?.height ?? "height") \n"
        str += "==== HandyJSON ==== data.weight: String? = \(model?.data?.weight ?? "weight") \n"
        str += "==== HandyJSON ==== data.birthday: String? = \(model?.data?.birthday ?? "birthday") \n"
        str += "==== HandyJSON ==== data.date: String? = \(model?.data?.date ?? "date") \n"
        str += "==== HandyJSON ==== data.url: String? = \(model?.data?.url ?? "url") \n"
        str += "==== HandyJSON ==== data.status: Enum? = \(model?.data?.status ?? .ten) \n"
        str += "==== HandyJSON ==== data.list: [String]? = \(model?.data?.list ?? ["list", "list"]) \n\n"
        str += "==== HandyJSON ==== jsonStr: String? = \(jsonStr ?? "jsonStr") \n\n"
        print(str)
        infoLabel.text = str
    }
}
