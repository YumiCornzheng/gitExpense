//
//  ContentView.swift
//  Expense
//
//  Created by yuming zheng on 7/28/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expense = Expense()//实例化了就需要用到StateObject

    var body: some View {
        NavigationView {
            List{
                ForEach(expense.expenseItems){ expenseItems in
                    NavigationLink {
                        DetailView(expense: expense, expenseItem: expenseItems)
                    } label: {
                        HStack{
                            VStack(alignment: .leading,spacing: 4){
                                Text(expenseItems.name).font(.headline)
                                Text(expenseItems.type)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(expenseItems.price)
                        }
                    }
                    
                }
                .onDelete {
                    expense.deleteItem(indexSet: $0)
                }

            }
            .navigationTitle("账单")
            
            .toolbar {
                NavigationLink {
                    DetailView( expense: expense)
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.secondary)
                }.padding(.horizontal)



            }
        }
        .navigationViewStyle(.stack)
//        .fullScreenCover(isPresented: $showDetailView) {DetailView()}
//        .sheet(isPresented: $showDetailView) {DetailView()}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
