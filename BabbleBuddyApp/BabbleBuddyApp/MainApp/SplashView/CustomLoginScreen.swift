// This screen will be deleted, it was created for testing the navigation from the splashview and cognito configuration
import Foundation
import SwiftUI
import AuthLibrarySPM

struct CustomLoginScreen: BaseLoginView {

    @StateObject public var viewModel: LoginViewModel
    @State private var isPasswordVisible: Bool = false

    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var emailTextField: AnyView {
        AnyView(
            HStack {
                Image(systemName: "envelope.fill")
                    .foregroundColor(.gray)
                    .padding(.leading, 10)

                TextField("Enter your email", text: $viewModel.email)
                    .padding()
                    .background(Color("babyBlue").opacity(0.2))
                    .cornerRadius(12)
                    .keyboardType(.emailAddress)
            }
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .padding(.horizontal)
        )
    }

    var passwordTextField: AnyView {
        AnyView(
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(.gray)
                    .padding(.leading, 10)

                if isPasswordVisible {
                    TextField("Enter your password", text: $viewModel.password)
                } else {
                    SecureField("Enter your password", text: $viewModel.password)
                }

                Button(action: { isPasswordVisible.toggle() }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
            }
            .padding()
            .background(Color("babyPink").opacity(0.2))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .padding(.horizontal)
        )
    }

    // Custom Login Button
    var loginButton: AnyView {
        AnyView(
            Button(action: {
                Task {
                    await viewModel.login()
                }
            }) {
                HStack {
                    Image(systemName: "heart.fill") // Icono más seguro y amigable
                        .font(.title3)
                        .foregroundColor(.red)

                    Text("Log Me In!")
                        .fontWeight(.semibold)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color("babyPink"), Color("babyBlue")]),
                    startPoint: .leading,
                    endPoint: .trailing)
                )
                .foregroundColor(.gray)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal, 20)
        )
    }

    // Custom Face ID Toggle
    var faceIDToggle: AnyView {
        AnyView(
            Toggle(isOn: $viewModel.isFaceIDEnabled) {
                HStack {
                    Image(systemName: "faceid")
                        .font(.title3)
                        .foregroundColor(Color("babyBlue"))

                    Text("Enable Face ID")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color("babyPink").opacity(0.2))
            .cornerRadius(12)
            .padding(.horizontal, 20)
        )
    }

    // Custom Sign-Up Button
    var signUpButton: AnyView {
        AnyView(
            Button(action: {
                viewModel.signUp()
            }) {
                HStack {
                    Image(systemName: "person.fill.badge.plus")
                        .font(.title3)
                        .foregroundColor(.gray)

                    Text("Create a new account!")
                        .fontWeight(.bold)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color("babyPink"), Color("babyBlue")]),
                    startPoint: .leading,
                    endPoint: .trailing)
                )
                .foregroundColor(.gray)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal, 20)
        )
    }

    var errorMessageLabel: AnyView {
        AnyView (
            viewModel.authManager.errorTextView
        )
    }

    func clearErrorMessage() {
        viewModel.clearErrorMessage()
    }

    // Custom Body
    public var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("babyPink"), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 15) {
                VStack {
                    Image("BabbleBuddyLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .shadow(radius: 5)

                    Text("Welcome to BabbleBuddy!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("babyBlue"))
                }
                .padding(.bottom, 20)
                VStack(spacing: 15) {
                    emailTextField
                    passwordTextField
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(radius: 5)
                )
                .padding(.horizontal)
                loginButton
                    .scaleEffect(1.1)
                    .shadow(radius: 5)
                if let errorMessage = viewModel.authenticationError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
                VStack(spacing: 10) {
                    faceIDToggle
                    signUpButton
                }
                .padding(.top, 15)
            }
            .padding()
        }
        .onAppear {
            clearErrorMessage()
            Task { await viewModel.tryAutoLogin() }
        }
    }
}

