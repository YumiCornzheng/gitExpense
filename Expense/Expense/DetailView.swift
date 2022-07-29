//
//  DetailView.swift
//  Expense
//
//  Created by yuming zheng on 7/28/22.
//

import SwiftUI

struct DetailView: View {
    enum Field : Hashable {case name,type,price}
    private let types = ["医疗","食品","健康","数据","智能"]
    @State private var name = ""
    @State private var type = "医疗"
    @State private var price = ""
    @Environment(\.dismiss) var dismiss
//    @Binding var expenseItems: [ExpenseItem]
    @FocusState private var isFocus: Field?
    
    @ObservedObject var expense: Expense
    
    var body: some View {
        Form{
            Section("账单名"){
                TextField("收入或支出来源", text: $name)
                    .focused($isFocus, equals: .name)
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            isFocus = .name
                        }
                        
                    }
            }
            Section("账单分类"){
                Picker("选择一个分类",selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
            }
            Section("账单金额") {
                TextField("输入或支出了多少", text: $price).keyboardType(.numberPad)
                    .focused($isFocus, equals: .price)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("添加账单")
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
                    expense.expenseItems.append(ExpenseItem(name: name, type: type, price: price))
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
