//
//  EHDBTable.swift
//  WCDB-Demo
//
//  Created by 黄坤鹏 on 2020/6/14.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//

import Foundation
import WCDBSwift


/// 以下扩展给业务层使用
///
protocol TableProtocol {
    /// 表名
    var name: String {get}
    /// 表对应的数据库
    var dataBase: Database {get}
    
}

/// 数据库
protocol DataBaseProtocol {
    /// 数据库存放路径
    var path: String {get}
    /// 数据库tag 对应唯一数据库
    var tag: Int {get}
    /// 真实数据库
    var db: Database {get}
}

/// 表实体
enum EHTable:String,TableProtocol {
  
    ///医生列表
    case providerList = "EHProviderModel"
    
    ///最近聊天列表
    case recentChatList = "EHRecentChatList"
    
    // MARK: - 代理实现
    ///表名
    var name: String {
        return self.rawValue
    }
    
    ///表所在的数据库
    var dataBase: Database {
        switch self {
        case .providerList:
            return EHDataBase.provider.db
        case .recentChatList:
            return EHDataBase.chat.db
        }
    }
    

}

/// 数据库
enum EHDataBase: String, DataBaseProtocol {

    /// 目录名
    static let documentPath:String = FileManager.default.urls(for: .documentDirectory,
    in: .userDomainMask).last?.appendingPathComponent("EasyAtHome_DB").path ?? ""
    
    /// 医生模块
    case provider = "provider"
    /// 聊天模块
    case chat = "chat"
    
    // MARK: - 代理实现
    /// 数据库文件路径
    var path: String {
        switch self {
        case .provider,.chat:
            return EHDataBase.documentPath + "/" + self.rawValue
        }
        
    }

    /// 数据库标签
    var tag: Int {
        switch self {
        case .provider:
            return 1
        case .chat:
            return 2
        }
    }

    /// 真实数据库
    var db: Database {
        let db = Database(withPath: self.path)
        db.tag = tag
        return db
    }
}
