//
//  Test1.swift
//  WCDB-Demo
//
//  Created by 黄坤鹏 on 2020/6/13.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//

import Foundation
import WCDBSwift

func test1() {
    print("Sample-table Begin")
    
    do {
        //Get table
        //Insert/Update/Select/Delete using table
        
        
        EHDBManager.openDB(EHTable.providerList,cls: EHProviderModel.self)
        
        // 查找数据
        let result:[EHProviderModel]? =  EHDBManager.select(EHTable.providerList, aClass: EHProviderModel.self, errorClosure: {(error) in
            if let error = error {
                print(error.description)
            }
            
        })
        debugPrint("找到result,数量为：\(String(describing: result?.count))")
        
        
        
        // 创建实体数据
        let updateObj1 = EHProviderModel()
        updateObj1.doctorId = "1"
        updateObj1.name = "医生1"
        updateObj1.aboutImages = ["wwww","cccc","dddd"]
        updateObj1.dataStatus = EHDataStatus(rawValue: "CAN_NOT_ACCESS")
        updateObj1.consultationType = EHConsultationType(rawValue: "PHONE_CALL")
        
        
        let updateObj2 = EHProviderModel()
        updateObj2.doctorId = "2"
        updateObj2.name = "医生2"
        updateObj2.aboutImages = ["a","b","c"]
        updateObj2.dataStatus = EHDataStatus(rawValue: "CAN_ACCESS")
        updateObj2.consultationType = EHConsultationType(rawValue: "VIDEO_CALL")
        
        do {
            
            //批量插入更新
//            try EHDBManager.insertOrReplace(EHTable.EHProviderModel, objects: [updateObj1,updateObj2])
         
            
            //指定更新
            updateObj1.name = "11"
            try EHDBManager.update(EHTable.providerList, object: updateObj1, propertys: [EHProviderModel.Properties.name],condition: EHProviderModel.Properties.doctorId == "1")
            
        }catch let error{
            print(error)
        }
        
        
        do{
            //            let findObj:EHProviderModel? =  try table?.getObject(where: EHProviderModel.Properties.doctorId == "1") as? EHProviderModel
            //            if findObj?.consultationType == .PHONE_CALL{
            //                debugPrint("ddd")
            //            }
            
        }catch let error {
            
        }
        
        print("Sample-table End")
    }
}
