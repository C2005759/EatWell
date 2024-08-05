//
//  ContentView.swift
//  EatWell_V2
//
//  Created by Shilin Li on 24/05/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var foodItemViewModel = FoodItemViewModel()
    @State private var isShowingAddFoodItemView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(foodItemViewModel.foodItems) { foodItem in
                    VStack(alignment: .leading) {
                        Text(foodItem.name ?? "Unknown Food")
                            .font(.headline)
                        Text("Quantity: \(foodItem.quantity, specifier: "%.2f") \(foodItem.unit ?? "")")
                        Text("Category: \(foodItem.categoryTag ?? "None")")
                    }
                }
                .onDelete(perform: deleteFoodItem)
            }
            .navigationTitle("Food Items")
            .navigationBarItems(trailing: Button(action: {
                isShowingAddFoodItemView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isShowingAddFoodItemView) {
                AddFoodItemView(isPresented: $isShowingAddFoodItemView, viewModel: foodItemViewModel)
            }
        }
    }

    private func deleteFoodItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let foodItem = foodItemViewModel.foodItems[index]
            foodItemViewModel.deleteFoodItem(item: foodItem)
        }
    }
}
