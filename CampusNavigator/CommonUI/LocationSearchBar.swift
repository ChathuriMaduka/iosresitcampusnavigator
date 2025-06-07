//
//  LocationSearchBar.swift
//  CampusNavigator
//
//  Created by Malsha Bopage on 2025-06-07.
//

import SwiftUI

struct LocationSearchBar: View {
    @Binding var searchText: String
    let onSearch: (String) -> Void
    let placeholder: String
    
    init(searchText: Binding<String>, placeholder: String = "Enter Your Location...", onSearch: @escaping (String) -> Void) {
        self._searchText = searchText
        self.placeholder = placeholder
        self.onSearch = onSearch
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.appPrimaryBlue)
                .font(.appBodyRegular)
            
            TextField(placeholder, text: $searchText)
                .font(.appInputField)
                .foregroundColor(.appPrimaryBlue)
                .onSubmit {
                    onSearch(searchText)
                }
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.appTextGray)
                        .font(.appBodyRegular)
                }
            }
            
            Button(action: {}) {
                Image(systemName: "")
                    .foregroundColor(.appPrimaryBlue)
                    .font(.appBodyRegular)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.appWhite)
        .cornerRadius(15)
        .shadow(color: Color.appPrimaryBlue.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}
