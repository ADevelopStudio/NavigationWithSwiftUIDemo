//
//  PaymentsViewV2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct PaymentsView_V16C: View {
	@EnvironmentObject var coordinator: Coordinator
	@StateObject fileprivate var viewModel = PaymentsViewModel()

	var body: some View {
		VStack {
			switch viewModel.loadingState {
			case .loading(let data):
				if let data {
					makeList(data: data)
				} else {
					ProgressView()
				}
			case .loaded(let data):
				makeList(data: data)
			case .error(let error):
				ErrorView(error: error)
				Button("Refresh") {
					Task { await viewModel.load(forceLoad: true) }
				}
			}
		}
		.task {
			await viewModel.load()
		}
		.navigationTitle("Payments")
	}
	
	private func makeList(data: [Payment]) -> some View {
		List(data) { payment in
			Button {
				coordinator.open(.payment(payment))
			} label: {
				PaymentsCardView(payment: payment)
			}
			.tint(.primary)
		}
		.refreshable {
			Task { await viewModel.load(forceLoad: true) }
		}
	}
}


@available(iOS 16.0, *)
fileprivate struct PaymentsView_V2Wrapper: View {
	@StateObject var coordinator = Coordinator()

	var body: some View {
		NavigationStack(path: $coordinator.homeNavigationPath) {
			PaymentsView_V16C()
				.addNavigationDestinations()
		}
		.environmentObject(coordinator)
	}
}


#Preview {
	if #available(iOS 16.0, *) {
		PaymentsView_V2Wrapper()
	}
}

