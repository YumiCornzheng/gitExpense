//
//  DetailView.swift
//  Expense
//
//  Created by yuming zheng on 7/28/22.
//

import SwiftUI

struct DetailView: View {
    //private
    enum Field : Hashable {case name,type,price}
    private let types = ["医疗","食品","健康","数据","智能"]
    @State private var name = ""
    @State private var type = "医疗"
    @State private var price = ""
    @Environment(\.dismiss) var dismiss
//    @Binding var expenseItems: [ExpenseItem]
    @FocusState private var isFocus: Field?
    
    //可以被传过来的数据
    @ObservedObject var expense: Expense//传值就用ObservedObject
    var expenseItem: ExpenseItem?
    
    //计算属性
    var isAddingPage : Bool{expenseItem == nil}
    var expenseitemIndex : Int?{
        expense.expenseItems.firstIndex {$0.id == expenseItem?.id}//firstIndex返回匹配到数据的数组下标
    }
    var body: some View {
        Form{
            Section("账单名"){
                TextField("收入或支出来源", text: isAddingPage ? $name : $expense.expenseItems[expenseitemIndex!].name)
                    .focused($isFocus, equals: .name)
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            isFocus = .name
                        }
                        
                    }
            }
            Section("账单分类"){
                Picker("选择一个分类",selection: isAddingPage ? $type : $expense.expenseItems[expenseitemIndex!].type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
            }
            Section("账单金额") {
                TextField("输入或支出了多少", text: isAddingPage ? $price : $expense.expenseItems[expenseitemIndex!].price).keyboardType(.numberPad)
                    .focused($isFocus, equals: .price)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(isAddingPage ? "添加账单" : "编辑账单")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left").foregroundColor(.primary)
                }
                .padding(.horizontal)

            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if isAddingPage{
                        expense.addItem(item: ExpenseItem(name: name, type: type, price: price))
                    }else{
                        
                    }
                    dismiss()
                } label: {
                    Text("保存").foregroundColor(.primary)
                }
                .padding(.horizontal)
            }
        }

    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
