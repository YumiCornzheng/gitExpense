//
//  ExpenseItem.swift
//  Expense
//
//  Created by yuming zheng on 7/28/22.
//

import Foundation

struct ExpenseItem: Identifiable{
    let id = UUID()
    var name : String
    var type : String
    var price : String
}


