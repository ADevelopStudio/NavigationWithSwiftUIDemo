//
//  ContentView.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@MainActor
class ContentViewModel: NSObject, ObservableObject {
	enum FlowState {
		case unselected, ios16_without_coordinator, ios16_with_coordinator, ios15
	}
	@Published var flowState: FlowState = .unselected
}


struct ContentView: View {
	@StateObject fileprivate var viewModel = ContentViewModel()

    var body: some View {
		switch viewModel.flowState {
		case .unselected:
			VStack(spacing: 30) {
				Button("iOS 16 With Coordinator") { viewModel.flowState = .ios16_with_coordinator }
				Button("iOS 16  Without Coordinator") { viewModel.flowState = .ios16_without_coordinator }
				Button("iOS 15") { viewModel.flowState = .ios15 }
			}
		case .ios15:
			ContentView_V15()
		case .ios16_with_coordinator:
			if #available(iOS 16.0, *) {ContentView_V16C() }
		case .ios16_without_coordinator:
			if #available(iOS 16.0, *) { ContentView_V16() }
		}
    }
}

#Preview {
    ContentView()
}
