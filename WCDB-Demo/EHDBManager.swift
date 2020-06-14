//
//  EHDBManager.swift
//  WCDB-Demo
//
//  Created by 黄坤鹏 on 2020/6/14.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//

import Foundation
import WCDBSwift


// MARK: - 通用sql语句
class EHDBManager{
    
    typealias ErrorType = (WCDBSwift.Error?)->Void
    

    /// 打开数据库
    class func openDB<Root: TableDecodable>(_ table: TableProtocol,cls:Root.Type)  {
        do {
            let database  = Database(withPath: table.dataBase.path)
            if database.isOpened == false{
                try database.create(table:table.name, of: cls )
                debugPrint("打开数据库\(table.name)成功，数据库路径：\(table.dataBase.path)")
            }
        }catch {
            debugPrint("打开数据库\(table.name)失败")
        }
    }
    
    /// 插入或插入更新
    class func insertOrReplace<Object>(_ table: TableProtocol, objects: [Object]) -> WCDBSwift.Error? where Object : TableEncodable {
        do {
            try table.dataBase.insertOrReplace(objects: objects, intoTable: table.name)
            return nil
        } catch {
            let errorValue = error as? WCDBSwift.Error
            return errorValue
        }
    }
    
    /// 插入
    class func insert<Object>(_ table: TableProtocol, objects: [Object]) -> WCDBSwift.Error? where Object: TableEncodable {
        do {
            try table.dataBase.insert(objects: objects, intoTable: table.name)
            return nil
        } catch {
            let errorValue = error as? WCDBSwift.Error
            return errorValue
        }
    }
    
    /// 更新
    class func update<Object>(_ table: TableProtocol, object: Object, propertys: [PropertyConvertible], condition: Condition? = nil, orderBy: [OrderBy]? = nil, limit: Limit? = nil, offset: Offset? = nil) -> WCDBSwift.Error? where Object: TableEncodable {
        do {
            try table.dataBase.update(table: table.name, on: propertys, with: object, where: condition, orderBy: orderBy, limit: limit, offset: offset)
            return nil
        } catch {
            let errorValue = error as? WCDBSwift.Error
            return errorValue
        }
    }

    /// 查找
    class func select<Object,Root>(_ table: TableProtocol,aClass:Root.Type, condition: Condition? = nil,limit: Limit? = nil,orderBy:[OrderBy]? = nil, isDistinct: Bool? = nil,errorClosure: ErrorType?) -> [Object]? where Object: TableEncodable,Root:TableDecodable  {
        do {
            let select: Select = try table.dataBase.prepareSelect(of: aClass.self, fromTable:table.name ,isDistinct:isDistinct ?? true)
            if let condition = condition {
                select.where(condition)
            }
            if let limit = limit {
                select.limit(limit)
            }
            if let orderBy = orderBy {
                select.order(by: orderBy)
            }
            let objects: [Object]? = try select.allObjects() as? [Object]
            return objects
        } catch {
            let errorValue = error as? WCDBSwift.Error
            errorClosure?(errorValue)
            return nil
        }
    }
    
    /// 删除
    class func delete(_ table: TableProtocol, condition: Condition?, orderBy: [OrderBy]? = nil, limit: Limit? = nil, offset: Offset? = nil) -> WCDBSwift.Error? {
        do {
            try table.dataBase.delete(fromTable: table.name, where: condition, orderBy: orderBy, limit: limit, offset: offset)
            return nil
        } catch {
            let errorValue = error as? WCDBSwift.Error
            return errorValue
        }
    }

    
  
    
    
}

// MARK: - 特殊sql语句
extension EHDBManager {
    
    /// 获取select语句
    class func select<Root: TableDecodable>(_ table: TableProtocol,aClass:Root.Type) -> Select? {
        do {
            let select: Select = try table.dataBase.prepareSelect(of: aClass.self, fromTable:table.name)
            return select
        } catch {
            return nil
        }
    }
}
