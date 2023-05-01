import UIKit


final class LoginView: UIControl {
    private let stackView = UIStackView()
    
    
    let loginField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    let passwordField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    
    let loginButton = UIButton()
    let registerButton = UIButton()
    let skipButton = UIButton()
    let forgotButton = UIButton()

    var viewControllerDelegate: PreferencesDelegate?

    
    init() {
        super.init(frame: .zero)
        
//        viewControllerDelegate?.changeColor(self)
        setupLoginStackView()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLoginStackView() {
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
//        stackView.distribution =
        stackView.backgroundColor = .systemGray5
        stackView.layer.cornerRadius = 12
        stackView.spacing = 8
        
        let segmentedControl = createLoginSegmentedControl()
        
        stackView.addArrangedSubview(segmentedControl)
        
        loginField.placeholder = "Email"
        passwordField.placeholder = "Пароль"

        passwordField.isSecureTextEntry = true
        
        for field in [loginField, passwordField] {
            field.backgroundColor = .white
            field.font = UIFont.systemFont(ofSize: 15)
//            field.borderStyle = UITextField.BorderStyle.roundedRect
//            field.borderStyle = UITextField.BorderStyle.line
//            field.layer.borderColor = UIColor.black
            
            field.autocorrectionType = UITextAutocorrectionType.no
            field.keyboardType = UIKeyboardType.default
            field.returnKeyType = UIReturnKeyType.done
            field.clearButtonMode = UITextField.ViewMode.whileEditing
            field.textAlignment = .left
            field.setLeftPaddingPoints(10)
            field.setRightPaddingPoints(10)
//            field.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            field.delegate = self
            field.layer.cornerRadius = 8
//            field.layer.applyShadow(2.0)
            field.setHeight(48)
            stackView.addArrangedSubview(field)
        }
        
        
        forgotButton.setTitle("Забыли пароль?", for: .normal)
        loginButton.setTitle("Вход", for: .normal)
        registerButton.setTitle("Регистрация", for: .normal)
        skipButton.setTitle("Пропустить", for: .normal)
        
        forgotButton.addTarget(self, action: #selector(forgotPasswordPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        
        registerButton.isHidden = true
        
        for button in [forgotButton, loginButton, registerButton, skipButton] {
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 8
            button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
            button.setHeight(48)
            button.setWidth(48)
            button.startAnimatingPressActions()
            stackView.addArrangedSubview(button)
        }
        
        for button in [loginButton, registerButton, skipButton] {
            button.layer.applyShadow(2.0)
        }
        
        forgotButton.setTitleColor(.darkGray, for: .normal)
        forgotButton.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .light)
        
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.backgroundColor = .systemBlue
        
        stackView.setCustomSpacing(32.0, after: segmentedControl)
        stackView.setCustomSpacing(0, after: passwordField)
        stackView.setCustomSpacing(0, after: forgotButton)
        stackView.setCustomSpacing(16, after: loginButton)
        stackView.setCustomSpacing(16, after: registerButton)
        
        addSubview(stackView)
        stackView.pin(to: self, [.left, .right, .top, .bottom])
    }
    
    @objc
    private func forgotPasswordPressed() {
        print("Forgor pressed")
    }
    
    @objc
    private func loginButtonPressed() {
        print("Login pressed")
    }
    
    @objc
    private func registerButtonPressed() {
        print("Register pressed")
    }
    
    @objc
    private func skipButtonPressed() {
        print("Skip pressed")
        switchToPreferences()
    }
    
    private func switchToPreferences() {
        print("Switch to preferences invoked")
        viewControllerDelegate?.loggedIn()
    }
    
    private func createLoginSegmentedControl() -> UISegmentedControl {
        let items = ["Вход", "Регистрация"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(controlDidChange(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setHeight(48)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = .white
        
        return segmentedControl
    }
    
    @objc
    private func controlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            registerButton.isHidden = true
            loginButton.isHidden = false
        case 1:
            registerButton.isHidden = false
            loginButton.isHidden = true
        default:
            break
        }
    }
}

// MARK:- UITextFieldDelegate

extension LoginView: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        textField.resignFirstResponder()
        return true
    }

}
