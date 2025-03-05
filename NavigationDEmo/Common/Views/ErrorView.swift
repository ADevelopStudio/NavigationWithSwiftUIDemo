//
//  ErrorView.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct ErrorView: View {
	var error: Error

	var body: some View {
		VStack {
			Image(systemName: "icloud.slash")
				.imageScale(.large)
			Text(error.localizedDescription)
		}
		.padding()
	}
}
