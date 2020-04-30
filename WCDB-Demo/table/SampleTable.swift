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

//class SampleTable: TableCodable {
//    var intValue: Int?
//    var stringValue: String?
//    var createDate: Date?
//    var occupantsIds:[Int64]?
//    enum CodingKeys: String, CodingTableKey {
//        typealias Root = SampleTable
//        static let objectRelationalMapping = TableBinding(CodingKeys.self)
//
//        case intValue
//        case stringValue
//        case createDate
//        case occupantsIds
//        static var columnConstraintBindings: [SampleTable.CodingKeys : ColumnConstraintBinding]? {
//            return [stringValue:ColumnConstraintBinding( defaultTo: "I am default"),createDate:ColumnConstraintBinding( orderBy: .descending)]
//        }
//    }
//
//    var isAutoIncrement: Bool = false // 用于定义是否使用自增的方式插入
//}

class SampleTable : TableCodable {
    
    
    /**
    The name of the Group dialog.
    
    @note If chat type is private, name will be nil.
    */
    var name:String?
    
    /**
    The type of the dialog.
    
    @see QBChatDialogType
     
     typedef NS_ENUM(NSUInteger, QBChatDialogType) {
         
         QBChatDialogTypePublicGroup = 1,
         QBChatDialogTypeGroup = 2,
         QBChatDialogTypePrivate = 3,
     };
     
    */
    var type:Int?
    /**
     The dialog ID.
     */
    var id:String?
    /**
     The date of the dialog creation.
     */
    var createdAt:Date?
    /**
     The Date of the last message in the dialog.
     */
    var lastMessageDate:Date?
    /// 后台自定义字段返回的
    var lastMessageDateSent:Int64?
    /**
     The last message ID
     */
    var lastMessageId:String?
    /**
     The Sender user ID of last message in current chat dialog.
     */
    var lastMessageUserId:Int64?
    
    //
    var occupantsIds:[Int64]?
    
    /**
     The date of the dialog update.
     */
    var updatedAt:Date?
    
    /**
     The user id of the dialog's owner.
     */
    var  userId:Int64?
    /**
     The Number of unread messages in the dialog.
     */
    var unreadMessagesCount:Int32?

    enum CodingKeys: String, CodingTableKey {
             typealias Root = SampleTable
             static let objectRelationalMapping = TableBinding(CodingKeys.self)
             
                case name
                case type
                case id
                case createdAt
                case lastMessageDate
                case lastMessageDateSent
                case lastMessageId
                case lastMessageUserId
                case occupantsIds
                case updatedAt
                case userId
                case unreadMessagesCount

         }
    
    static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
        return [
            .id: ColumnConstraintBinding(isPrimary: true),
        ]
    }

  
}

