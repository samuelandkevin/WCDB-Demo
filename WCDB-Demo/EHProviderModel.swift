//
//  EHProviderModel.swift
//  EasyAtHome
//
//  Created by 黄坤鹏 on 2020/4/8.
//  Copyright © 2020 Easy Healthcare Corporation. All rights reserved.
//  医生model

import Foundation
import SwiftyJSON
import WCDBSwift

// 数据访问状态
enum EHDataStatus:String,ColumnJSONCodable {
    
    case CAN_NOT_ACCESS = "CAN_NOT_ACCESS"
    case CAN_ACCESS = "CAN_ACCESS"
}

// 咨询状态
enum EHConsultationStatus:String,ColumnJSONCodable {
    case NULL = "NULL"
    case HAS_CREATE = "HAS_CREATE"
    case HAS_REFUSE = "HAS_REFUSE"
    case HAS_ACCEPT = "HAS_ACCEPT"
    case HAS_END = "HAS_END"
}

// 咨询类型
enum EHConsultationType:String,ColumnJSONCodable {
    case NULL = "NULL"
    case CHAT = "CHAT"
    case PHONE_CALL = "PHONE_CALL"
    case VIDEO_CALL = "VIDEO_CALL"
}

/// 医生审核状态
enum EHDoctorVerifyStatus:String {
    /**
     * 未通过认证
     */
    case NOT_VERIFY = "NOT_VERIFY"
    /**
     * 已通过认证
     */
    case HAS_VERIFY = "HAS_VERIFY"
}



/// 医生model
class EHProviderModel: EHBaseModel,TableCodable {
    
    // MARK: - 服务器返回字段
    /// 医生的主键
    var doctorId:String?
    /// 医生登录的id
    var userId:Int?
    /// 医生名字
    var name:String?
    /// 机构名字
    var company:String?
    /// 专业介绍
    var specialty:String?
    /// 自我介绍
    var aboutMe:String?
    /// 医生类型
    var categoryId:String?
    /// 医生头像
    var avatar:String?
    /// 描述
    var des:String?
    /// 邮箱
    var email:String?
    /// 1：绑定，0：未绑定
    var status:Int?
    /// 数据访问状态,可用值:CAN_NOT_ACCESS,CAN_ACCESS
    var dataStatus:EHDataStatus?
    /// 咨询状态,可用值:NULL,HAS_CREATE,HAS_REFUSE,HAS_ACCEPT,HAS_END
    var consultationStatus:EHConsultationStatus?
    /// 咨询类型,可用值:NULL,CHAT,PHONE_CALL,VIDEO_CALL
    var consultationType:EHConsultationType?
    /// quickblox的用户id
    var quickBloxId:Int64?
    /// 审核状态
    var verifyStatus:EHDoctorVerifyStatus?
    /// 医生电话
    var tel:String?
    
    /// 咨询类型和单价信息
    var priceVos:[EHPriceVos]?
    /// 最低咨询价格
    var minPrice:Double?
    /// 0：平台不显示，1：平台显示
    var isShow:Int?
    /// 医生最近可预约的时间戳
    var availableTime:TimeInterval?
    /// 医生最近可预约的时间
    var consultationTime:String?
    
    /// 每个咨询类型的咨询数量
    var consulTypeInfos:[EHConsulTypeInfo]?
    
    /// 聊天顶部的咨询信息
    var consultInfo:[EHConsultInfoModel]?
    
    /// 预约已满
    var isTimeFull:Bool?
    
    /// 分类id
    var id:Int?
    
    /// 医生的主页网址
    var homeUrl:String?
    
    /// 医生自我介绍的图片url列表
    var aboutImages:[String]?
    

    
    // MARK: - 以下是自定义字段
    /// 是否展开
    var isExpand = false
    
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = EHProviderModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        /// 医生的主键
           case doctorId
           /// 医生登录的id
           case userId
           /// 医生名字
           case name
           /// 机构名字
           case company
           /// 专业介绍
           case specialty
           /// 自我介绍
           case aboutMe
           /// 医生类型
           case categoryId
           /// 医生头像
           case avatar
           /// 描述
           case des
           /// 邮箱
           case email
           case dataStatus
           case consultationStatus
           case consultationType
           /// quickblox的用户id
           case quickBloxId
         
           /// 医生电话
           case tel
    
           /// 预约已满
           case isTimeFull
           
           /// 医生的主页网址
           case homeUrl
           
           /// 医生自我介绍的图片url列表
           case aboutImages
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                .doctorId: ColumnConstraintBinding(isPrimary: true),
            ]
        }
        
    }

    
    
    public class func model(dict: JSON) -> EHProviderModel {
        let result = EHProviderModel()
        /// 医生的主键
        result.doctorId = dict["doctorId"].stringValue
        /// 医生登录的id
        result.userId = dict["userId"].intValue
        /// 医生名字
        result.name = dict["name"].stringValue
        /// 机构名字
        result.company = dict["company"].stringValue
        /// 专业介绍
        result.specialty = dict["specialty"].stringValue
        /// 自我介绍
        result.aboutMe = dict["aboutMe"].stringValue
        /// 医生类型
        result.categoryId = dict["categoryId"].stringValue
        /// 医生头像
        result.avatar = dict["avatar"].stringValue
        /// 描述
        result.des = dict["des"].stringValue
        /// 邮箱
        result.email = dict["email"].stringValue
        /// 1：绑定，0：未绑定
        result.status = dict["status"].intValue
        /// 数据访问状态,可用值:CAN_NOT_ACCESS,CAN_ACCESS
        result.dataStatus =  EHDataStatus(rawValue: dict["dataStatus"].stringValue)
        /// 咨询状态,可用值:NULL,HAS_CREATE,HAS_REFUSE,HAS_ACCEPT,HAS_END
        result.consultationStatus = EHConsultationStatus(rawValue:dict["consultationStatus"].stringValue)
        /// 咨询类型,可用值:NULL,CHAT,PHONE_CALL,VIDEO_CALL
        result.consultationType = EHConsultationType(rawValue:dict["consultationType"].stringValue)
        /// quickblox的用户id
        result.quickBloxId = dict["quickBloxId"].int64Value
        /// 审核状态
        result.verifyStatus = EHDoctorVerifyStatus(rawValue:dict["verifyStatus"].stringValue)
        /// 医生电话
        result.tel = dict["tel"].stringValue
        
        /// 咨询类型和单价信息
        var arr0 = [EHPriceVos]()
        for item in dict["priceVos"].arrayValue{
            arr0.append(EHPriceVos.model(dict: item))
        }
        
        result.priceVos = arr0
        /// 最低咨询价格
        result.minPrice = dict["minPrice"].doubleValue
        /// 0：平台不显示，1：平台显示
        result.isShow = dict["isShow"].intValue
        /// 医生最近可预约的时间戳
        result.availableTime = dict["availableTime"].doubleValue
        /// 医生最近可预约的时间
        result.consultationTime = dict["consultationTime"].stringValue
        
        /// 每个咨询类型的咨询数量
        var arr1 = [EHConsulTypeInfo]()
        for item in dict["consulTypeInfos"].arrayValue{
            arr1.append(EHConsulTypeInfo.model(dict: item))
        }
        
        result.consulTypeInfos = arr1
        
        /// 聊天顶部的咨询信息
        var arr2 = [EHConsultInfoModel]()
        for item in dict["consultInfo"].arrayValue{
            arr2.append(EHConsultInfoModel.model(dict: item))
        }
        result.consultInfo = arr2
        
        /// 预约已满
        result.isTimeFull = dict["isTimeFull"].boolValue
        
        result.id = dict["id"].intValue
        
        result.homeUrl = dict["homeUrl"].stringValue
        

        let arr3 = dict["aboutImages"].arrayObject as? [String]
        result.aboutImages = arr3
        
        return result
    }
    
    
    
    /// 是否可以预约
    func canBookAnAppointment()->Bool{
        
        /// 总的开关打开
        var isShow = true
        //是否未设置价格
        var noSettingPrice = false
        //服务关闭的数量
        var serviceCloseCount = 0
        /// 是否可以预约
        var canBookAnAppointment = true
        
        //1.------前置变量获取-------
        //医生是否关掉了总开关
        isShow = self.isShow == 1
        
        
        if let priceVos = self.priceVos,priceVos.count == 0 {
            //未设置价格(返回为空的)
            noSettingPrice = true
        }else{
            //统计服务关闭的数量
            for (_,item) in self.priceVos?.enumerated() ?? [EHPriceVos]().enumerated(){
                if item.isSwitch == 0 {
                    serviceCloseCount += 1
                }
            }
        }
        
        //2.-------对前置变量进行预约校验逻辑----
        //校验是否可以预约的逻辑
        //医生不可以预约(1-医生没有认证 2-医生关掉了总开关(预约排班的一个按钮开关) 3-或者三个服务都关了 4-返回的为空)
        
        if self.verifyStatus == .HAS_VERIFY{
            
            
            if self.isTimeFull == true {
                //预约已满
                canBookAnAppointment = false
            }else{
                //医生已经认证
                if isShow {
                    if noSettingPrice {
                        //返回的为空
                        canBookAnAppointment = false
                    }else if serviceCloseCount >= 3{
                        //三个服务都关了
                        canBookAnAppointment = false
                    }
                    
                }else{
                    //医生关掉了总开关
                    canBookAnAppointment = false
                }
            }
            
            
        }else{
            //医生没有认证
            canBookAnAppointment = false
        }
        
        return canBookAnAppointment
    }
    
    
    /// 获取当前咨询数量
    func getConsulTypeInfoCount() -> Int{
        //已经接受的咨询请求数量
        var totalAcceptedCount = 0
        if let consulTypeInfos = self.consulTypeInfos {
            //每个咨询类型的咨询数量 不为空
            for (_,item) in consulTypeInfos.enumerated(){
                if let c = item.count{
                    totalAcceptedCount += c
                }
            }
        }
        return totalAcceptedCount
        
    }
    
}

/// 咨询类型和单价信息model
class EHPriceVos:EHBaseModel{
    /// 咨询邀请类型,可用值:NULL,CHAT,PHONE_CALL,VIDEO_CALL
    var inviteType:EHConsultationType?
    /// 开关
    var isSwitch:Int?
    /// 价格
    var price:Double?
    
    /// 单价时间min
    var priceTime:Int?
    
    /// 单价/时间min 显示
    var priceTimeText:String?
    
    
    // MARK: - 以下是自定义字段
    /// 选择状态
    public enum SelectedStatus:Int {
        case unknown = 0
        case selected
        case unSelected
    }
    
    var selStatus:SelectedStatus = .unknown   // 0
    
    public class func model(dict: JSON) -> EHPriceVos {
        let result = EHPriceVos()
        result.inviteType = EHConsultationType(rawValue: dict["inviteType"].stringValue)
        result.isSwitch = dict["isSwitch"].intValue
        result.price = dict["price"].doubleValue
        result.priceTime = dict["priceTime"].intValue
        result.priceTimeText = dict["priceTimeText"].stringValue
        return result
    }
    
}

///每个咨询类型的咨询
class EHConsulTypeInfo:EHBaseModel{
    /// 已经接受的咨询请求数量
    var count:Int?
    /// 咨询请求类型,可用值:NULL,CHAT,PHONE_CALL,VIDEO_CALL
    var inviteType:EHConsultationType?
    
    
    public class func model(dict: JSON) -> EHConsulTypeInfo {
        let result = EHConsulTypeInfo()
        result.count = dict["count"].intValue
        result.inviteType = EHConsultationType(rawValue:dict["inviteType"].stringValue)
        return result
    }
}

/// 聊天顶部的咨询信息
class EHConsultInfoModel:EHBaseModel{
    
    /// 咨询时间
    var consultationTime:String?
    /// 咨询状态
    var statusName:String?
    /// 邀请的类型
    var typeName:String?
    
    public class func model(dict: JSON) -> EHConsultInfoModel {
        let result = EHConsultInfoModel()
        result.consultationTime = dict["consultationTime"].stringValue
        result.statusName = dict["statusName"].stringValue
        result.typeName = dict["typeName"].stringValue
        return result
    }
    
}
