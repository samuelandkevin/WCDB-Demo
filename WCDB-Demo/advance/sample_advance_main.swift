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

func sample_advance_main(baseDirectory: String) {
    print("Sample-advance Begin")

    let className = String(describing: SampleAdvance.self)
    let path = URL(fileURLWithPath: baseDirectory).appendingPathComponent(className).path
    let database = Database(withPath: path)
    let tableName = className
    let tableName2 = String(describing: SampleAdvanceMulti.self)
    database.close(onClosed: {
        try? database.removeFiles()
    })

    //cipher
    do {
        let key: Data = "password".data(using: .ascii)!
        database.setCipher(key: key)
    }

    //prepare
    do {
        try database.create(table: tableName, of: SampleAdvance.self)
        let advance = SampleAdvance()
        advance.intValue = 1
        try database.insert(objects: advance, intoTable: tableName)

        try database.create(table: tableName2, of: SampleAdvanceMulti.self)
        let advanceMulti = SampleAdvanceMulti()
        advanceMulti.intValue = 1
        try database.insert(objects: advanceMulti, intoTable: tableName2)
    } catch let error {
        print("prepare error: \(error)")
    }

    //Using [as] to redirect selection
    do {
        let property = SampleAdvance.Properties.any.as(SampleAdvance.Properties.intValue)
        let object: SampleAdvance = (try database.getObject(on: property, fromTable: tableName))!
        print("Count: \(object.intValue!)")
    } catch let error {
        print("redirect selection error: \(error)")
    }

    //Multi select
    do {
        let property1 = (SampleAdvance.Properties.intValue).in(table: tableName)
        let property2 = (SampleAdvanceMulti.Properties.intValue).in(table: tableName2)
        let properties = [property1, property2]
        let condition = property1 == property2
        let tables = [tableName, tableName2]
        let select = try database.prepareMultiSelect(on: properties, fromTables: tables).where(condition)
        let multiObjects = select.allMultiObjects
    } catch let error {
        print("multi select error: \(error)")
    }

    //Column coding
    do {
        let object: SampleAdvance? = try database.getObject(fromTable: tableName)
        let value: Float? = object?.columnCoding?.floatValue
    } catch let error {
        print("column coding error: \(error)")
    }

    print("Sample-advance End")
}
