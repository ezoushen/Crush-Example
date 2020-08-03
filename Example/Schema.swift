//
//  Schema.swift
//  Crush_Example
//
//  Created by 沈昱佐 on 2020/1/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Crush
import Foundation

class V1: SchemaOrigin {
    override var entities: [Entity.Type] {
        [
            V1.TodoList.self,
            V1.Todo.self
        ]
    }
    
    class Record: EntityObject {
        @Value.String
        var name: String! = ""
    }
    
    class Todo: Record {
        @Value.String
        var content: String!
        
        @Value.Bool
        var isFinished: Bool! = false
        
        @Optional.Value.Date
        var dueDate: Date?
        
        @Optional.Value.String
        var memo: String?
        
        override func awakeFromInsert() {
            dueDate = Date()
        }
    }
    
    class TodoList: Record {
        
    }
}

typealias CurrentSchema = V1

typealias Todo = CurrentSchema.Todo
typealias TodoList = CurrentSchema.TodoList
typealias Record = CurrentSchema.Record

extension Record {
    class Constraint: NSObject, ConstraintSet {
        @FetchIndex
        var name = AscendingIndex(\Record.$name)
    }
}

extension Todo {
    class Constraint: NSObject, ConstraintSet {
        @FetchIndex
        var memo = AscendingIndex(\Todo.$memo)
    }
}
