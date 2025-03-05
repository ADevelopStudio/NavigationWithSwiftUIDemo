//
//  PaymentsView.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct PaymentsView_V15: View {
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
			NavigationLink {
				PaymentDetailsView(payment: payment)
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


#Preview {
	NavigationView {
		PaymentsView_V15()
	}
}
