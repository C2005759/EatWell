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
            VStack(spacing: 20) {
                Group {
                    HStack {
                        Text("Name:")
                            .fontWeight(.semibold)
                        TextField("Enter name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Text("Quantity:")
                            .fontWeight(.semibold)
                        TextField("Enter quantity", text: $quantity)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Text("Unit:")
                            .fontWeight(.semibold)
                        TextField("Enter unit", text: $unit)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Toggle("Opened", isOn: $isOpened)
                        .padding(.vertical, 10)
                    DatePicker("Expiration Date", selection: $expirationDate, displayedComponents: .date)
                        .padding(.vertical, 10)
                    HStack {
                        Text("Category Tag:")
                            .fontWeight(.semibold)
                        TextField("Enter category tag", text: $categoryTag)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancel")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
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
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .navigationTitle("Add Food Item")
        }
    }
}
