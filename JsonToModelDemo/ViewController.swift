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
        "id": 123,
        "name": "haha",
        "height": 123.456,
        "birthday": "2021-08-10",
        "date": 1628839481521.123,
        "url": "https://abc.def.com",
        "status": 30,
        "list": [1,2,3,4]
    ]
]

class ViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private let SwiftyJSONButton = UIButton()
    private let ObjectMapperButton = UIButton()
    private let HandyJSONButton = UIButton()
    private let JSONDecoderButton = UIButton()
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
        JSONDecoderButton.setTitle("JSONDecoderButton", for: UIControl.State.normal)
        
        SwiftyJSONButton.backgroundColor = UIColor.systemTeal
        ObjectMapperButton.backgroundColor = UIColor.systemTeal
        HandyJSONButton.backgroundColor = UIColor.systemTeal
        JSONDecoderButton.backgroundColor = UIColor.systemTeal
        
        SwiftyJSONButton.addTarget(self, action: #selector(SwiftyJSONButtonAction), for: UIControl.Event.touchUpInside)
        ObjectMapperButton.addTarget(self, action: #selector(ObjectMapperButtonAction), for: UIControl.Event.touchUpInside)
        HandyJSONButton.addTarget(self, action: #selector(HandyJSONButtonAction), for: UIControl.Event.touchUpInside)
        JSONDecoderButton.addTarget(self, action: #selector(JSONDecoderButtonAction), for: UIControl.Event.touchUpInside)
        
        infoLabel.numberOfLines = 0
        infoLabel.layer.borderWidth = 1
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(SwiftyJSONButton)
        scrollView.addSubview(ObjectMapperButton)
        scrollView.addSubview(HandyJSONButton)
        scrollView.addSubview(JSONDecoderButton)
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
        JSONDecoderButton.snp.makeConstraints { make in
            make.top.equalTo(HandyJSONButton.snp_bottomMargin).offset(20)
            make.left.equalToSuperview().inset(100)
            make.width.equalTo(width-200)
            make.height.equalTo(44)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(JSONDecoderButton.snp_bottomMargin).offset(50)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(100)
            make.width.equalTo(width-40)
            make.height.greaterThanOrEqualTo(400)
        }
    }
}

// MARK: JSONDecoder
extension ViewController {
    @objc func JSONDecoderButtonAction(){
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            // decode
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(JSONDecoderModel.self, from: data)
            
            // encode
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(model)
            let str = String(data: jsonData, encoding: String.Encoding.utf8)
            
            print("==== Codable ====")
            print(model.data?.birthday)
            print(model.data?.date)
            print(model.data?.weight)
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
            
            print("==== SwiftyJSON ====")
            print(model.data?.birthday)
            print(model.data?.date)
            print(model.data?.weight)
            print(model)
            infoLabel.text = "\(model)"
            
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
        let str = model?.toJSONString(prettyPrint: true) // ObjectMapper
        print("==== ObjectMapper ====")
        print(model?.data?.birthday)
        print(model?.data?.date)
        print(model?.data?.weight)
        print(str)
        infoLabel.text = str
    }
}

// MARK: HandyJSON
import HandyJSON
extension ViewController {
    @objc func HandyJSONButtonAction(){
        let model = HandyJSONModel.deserialize(from: jsonDict)
        
        let str = model?.toJSONString(prettyPrint: true) // HandyJSON
        
        print("==== HandyJSON ====")
        print(model?.data?.dataId)
        print(model?.data?.status)
        print(model?.data?.birthday)
        print(model?.data?.date)
        print(model?.data?.weight)
        print(str)
        infoLabel.text = str
    }
}
