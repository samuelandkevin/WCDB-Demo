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

class SampleFTSOrigin: TableCodable {
    var localID: Int?
    var name: String?
    var content: String?
    enum CodingKeys: String, CodingTableKey {
        typealias Root = SampleFTSOrigin
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case localID
        case name
        case content
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                .localID: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true)
            ]
        }
    }

    var isAutoIncrement: Bool = false
    var lastInsertedRowID: Int64 = 0
}
