//
//  PaymentPreDetailsView.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct PaymentPreDetailsView: View {
	@StateObject fileprivate var viewModel: PaymentPreDetailsViewModel
	
	init(paymentId: String) {
		_viewModel = StateObject(wrappedValue: PaymentPreDetailsViewModel(paymentId: paymentId))
	}

    var body: some View {
		VStack {
			switch viewModel.loadingState {
			case .loading(let payment):
				if let payment {
					PaymentDetailsView(payment: payment)
				} else {
					ProgressView("Loading payment \(viewModel.paymentId)")
				}
			case .loaded(let payment):
				PaymentDetailsView(payment: payment)
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
    }
}

#Preview {
	PaymentPreDetailsView(paymentId: "123")
}
