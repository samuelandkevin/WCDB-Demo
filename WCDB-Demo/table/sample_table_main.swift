/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation
import WCDBSwift

func sample_table_main(baseDirectory: String) {
    print("Sample-table Begin")

    let className = String(describing: SampleTable.self)
    let path = URL(fileURLWithPath: baseDirectory).appendingPathComponent(className).path
    let tableName = className

    let database = Database(withPath: path)

//    database.close(onClosed: {
//        try? database.removeFiles()
//    })
    

    //Create table and indexes from WCTTableCoding class
    do {
        try database.create(table: tableName, of: SampleTable.self)
    } catch let error {
        print("creat table error: \(error)")
    }

    //Drop table
//    do {
//        try database.drop(table: tableName)
//    } catch let error {
//        print("drop table error: \(error)")
//    }

    //Create table from column def
//    do {
//        let intValueDef = SampleTable.Properties.intValue.asDef(with: .integer32)
//        let stringValueDef = SampleTable.Properties.stringValue.asDef(with: .text)
//        try database.create(table: tableName,
//                            with: intValueDef, stringValueDef)
//    } catch let error {
//        print("create table from column def error: \(error)")
//    }

    //Create index from column index
//    let indexSubfix = "_index"
//    let indexName = tableName + indexSubfix
//    do {
//        try database.create(index: indexName,
//                            with: SampleTable.Properties.stringValue.asIndex(orderBy: .ascending),
//                            forTable: tableName)
//    } catch let error {
//        print("create index error: \(error)")
//    }

    //Drop index
//    do {
//        try database.drop(index: indexName)
//    } catch let error {
//        print("drop index error: \(error)")
//    }

    //Add column
//    do {
//        let tableName2 = tableName + "2"
//        try database.create(table: tableName2, with: (SampleTable.Properties.intValue).asDef(with: .integer32) )
//        try database.addColumn(with: (SampleTable.Properties.stringValue).asDef(with: .text), forTable: tableName2)
//    } catch let error {
//        print("add column error: \(error)")
//    }

    do {
        //Get table
        let table: Table<SampleTable>? = try database.getTable(named: tableName)
        //Insert/Update/Select/Delete using table
        

       
        //当个插入
//        let object = SampleTable()
//        object.intValue = 123232
//        object.stringValue = "\(100 + 12131312)"
//        object.createDate = Date().addingTimeInterval(TimeInterval(12131312))
//        object.occupantsIds = [13,12]
//        try table?.insert(objects: object)
        
        //插入更新
//        let object = SampleTable()
//        object.intValue = 123232
//        object.stringValue = "\(100 + 12131312)"
//        object.createDate = Date().addingTimeInterval(TimeInterval(12131312))
//        object.occupantsIds = [13,12]
//        try database.insertOrReplace(objects: object, intoTable: tableName) // 插入成功，且 description 的内容会被替换为 "insertOrReplace"

        
        // 批量插入
        //        var arrobject = [SampleTable]()
        //        for (index,item) in (0..<100).enumerated() {
        //            let object = SampleTable()
        //            object.intValue = Int(index)
        //            object.stringValue = "\(100 + index)"
        //            object.createDate = Date().addingTimeInterval(TimeInterval(index))
        //            arrobject.append(object)
        //        }
        
//        try database.run(transaction: {
//            try database.insert(objects: arrobject, intoTable: tableName)
//        })
        
        
        // 删除
        // 删除 sampleTable 中 identifier 降序排列后的前 2 行数据
        

        // 更新
        let updateObj = SampleTable()
        updateObj.id = "888"
        updateObj.name = "jhof"
        updateObj.lastMessageId = "1234567890"
        
        //成功 insertOrReplace
        do {
            try table?.delete(where: SampleTable.Properties.id == "777")
            try table?.insertOrReplace(objects: updateObj)
//            try table?.insertOrReplace(objects: updateObj)
//            try table?.insertOrReplace(objects: updateObj)
        }catch let error{
            print(error)
        }
        
         
        //
        
        
//        try table?.update(on: SampleTable.Properties.stringValue, with: updateObj,where:SampleTable.Properties.intValue > 1 &&  SampleTable.Properties.intValue < 10)
        
        
//        // 获取所有内容
//        let allRows = try database.getRows(fromTable: tableName)
//        print(allRows[row: 3, column: 0].int32Value)
        
        
        
        
        
        // 返回 sampleTable 中的所有数据
//        let allObjects: [SampleTable] = try database.getObjects(fromTable: tableName)
//        let occupantsIds = allObjects[0].occupantsIds
//        print(occupantsIds?[0])
//
//
//        // 获取第二行
//        let secondRow = try database.getRow(fromTable: tableName, offset: 1)
//        print(secondRow[0].int32Value)
//
//
//        // 获取不重复的 description 列的值
//        let distinctDescriptionColumn = try database.getDistinctValue(on: SampleTable.Properties.createDate, fromTable: tableName)
//        print(distinctDescriptionColumn.stringValue) //
//
//
//        let maxIdentifier = try database.getValue(on: SampleTable.Properties.intValue.max(), fromTable: tableName)
//        print(maxIdentifier.int32Value) //
    
    } catch let error {
        print("get table error: \(error)")
    }

    print("Sample-table End")
}
