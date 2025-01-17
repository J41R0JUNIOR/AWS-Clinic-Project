//
//  SignUp_Presenter.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 17/01/25.
//

import Foundation

protocol SignUp_Presenter_Protocol {
    
}

class SignUp_Presenter: SignUp_Presenter_Protocol {
    weak var viewModel: SignUp_ViewModel?
    
    init(viewModel: SignUp_ViewModel) {
        self.viewModel = viewModel
    }
}
