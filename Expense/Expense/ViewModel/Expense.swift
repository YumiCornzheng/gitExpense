//
//  Expense.swift
//  Expense
//
//  Created by yuming zheng on 7/28/22.
//

import Foundation


//MMVM模式的viewModel必须是class而不是struct
class Expense: ObservableObject{
    @Published
    var expenseItems = [
        ExpenseItem(name: "aitmed大苹果", type: "医疗水果", price: "$23"),
        ExpenseItem(name: "aitmed测温枪", type: "医疗设备", price: "$78"),
        ExpenseItem(name: "aitmed体重秤", type: "生活用品", price: "$123")
    ]
    
    func addItem(item: ExpenseItem){
        expenseItems.append( item )
    }
    
    func deleteItem(indexSet: IndexSet){
        expenseItems.remove(atOffsets: indexSet)
    }
    
}
