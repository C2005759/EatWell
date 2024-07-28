//
//  File.swift
//  EatWell_V2
//
//  Created by Shilin Li on 31/05/2024.
//

import SwiftUI

struct AddFoodItemView: View {
    @Binding var isPresented: Bool
    @StateObject var viewModel: FoodItemViewModel

    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var unit: String = ""
    @State private var isOpened: Bool = false
    @State private var expirationDate: Date = Date()
    @State private var categoryTag: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Quantity", text: $quantity)
                    .keyboardType(.decimalPad)
                TextField("Unit", text: $unit)
                Toggle("Opened", isOn: $isOpened)
                DatePicker("Expiration Date", selection: $expirationDate, displayedComponents: .date)
                TextField("Category Tag", text: $categoryTag)
            }
            .navigationTitle("Add Food Item")
            .navigationBarItems(leading: Button("Cancel") {
                isPresented = false
            }, trailing: Button("Save") {
                if let quantity = Double(quantity) {
                    viewModel.addFoodItem(
                        name: name,
                        quantity: quantity,
                        unit: unit,
                        isOpened: isOpened,
                        expirationDate: expirationDate,
                        categoryTag: categoryTag
                    )
                    isPresented = false
                }
            })
        }
    }
}
