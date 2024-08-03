//
//  MainView.swift
//  EatWell_V2
//
//  Created by Shilin Li on 28/07/2024.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Food Items", systemImage: "list.bullet")
                }
            
            RecipeView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            
            DailyPlanView()
                .tabItem {
                    Label("Daily Plan", systemImage: "calendar")
                }
            
            ShoppingListView()
                .tabItem {
                    Label("Shopping List", systemImage: "cart")
                }
        }
    }
}
