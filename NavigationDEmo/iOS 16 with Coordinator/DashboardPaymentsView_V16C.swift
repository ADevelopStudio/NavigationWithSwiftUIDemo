//
//  DashboardPayments_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct DashboardPaymentsView_V16C: View {
	@EnvironmentObject var coordinator: Coordinator
	@StateObject fileprivate var viewModel = DashboardPaymentsViewModel()

    var body: some View {
		VStack {
			switch viewModel.loadingState {
			case .loading(let payment):
				if let payment {
					makeBoby(payment)
				} else {
					ProgressView()
						.frame(height: 50)
				}
			case .loaded(let payment):
				makeBoby(payment)
			case .error(let error):
				ErrorView(error: error)
					.frame(height: 50)
			}
		}
		.animation(.easeInOut, value: viewModel.loadingState.index)
		.task {
			await viewModel.load()
		}
	}
	
	private func makeBoby(_ payment: Payment) -> some View {
		GroupBox("Last payment:") {
			GroupBox {
				Button {
					coordinator.open(.payment(payment))
				} label: {
					PaymentsCardView(payment: payment)
				}
				.tint(.primary)
			}
			GroupBox {
				Button {
					coordinator.switchTo(.payments)
				} label: {
					HStack {
						Text("See  all")
						Spacer()
					}
				}
				.tint(.primary)
			}
		}
		.transition(.move(edge: .top).combined(with: .opacity).combined(with: .scale))
	}
}

#Preview {
	if #available(iOS 16.0, *) {
		DashboardPaymentsView_V16C()
	}
}
