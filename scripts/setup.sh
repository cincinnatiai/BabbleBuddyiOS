#!/bin/bash

echo "🔧 Setting up shared Git hooks..."

# Step 1: Configure Git to use versioned hooks
git config core.hooksPath scripts/git-hooks

# Step 2: Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "⚠️ Homebrew is not installed."

  read -p "Do you want to install Homebrew? (y/n): " install_brew
  if [[ "$install_brew" == "y" ]]; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ $? -eq 0 ]; then
      echo "✅ Homebrew installed successfully."
      export PATH="/opt/homebrew/bin:$PATH"
    else
      echo "❌ Failed to install Homebrew. Please install it manually and rerun this script."
      exit 1
    fi
  else
    echo "🚫 Homebrew was not installed. Cannot proceed with SwiftLint installation."
    exit 1
  fi
else
  echo "✅ Homebrew is already installed."
fi

# Step 3: Check if SwiftLint is installed
if ! command -v swiftlint &> /dev/null; then
  echo "⚠️ SwiftLint is not installed."

  read -p "Do you want to install SwiftLint using Homebrew? (y/n): " install_swiftlint
  if [[ "$install_swiftlint" == "y" ]]; then
    echo "🍺 Installing SwiftLint..."
    brew install swiftlint

    if [ $? -eq 0 ]; then
      echo "✅ SwiftLint installed successfully."
    else
      echo "❌ Failed to install SwiftLint. Please install it manually and rerun this script."
      exit 1
    fi
  else
    echo "🚫 SwiftLint was not installed. The pre-commit hook will not function properly."
  fi
else
  echo "✅ SwiftLint is already installed."
fi

# Step 4: Check if .swiftlint.yml exists
if [ ! -f ".swiftlint.yml" ]; then
  echo "❌ .swiftlint.yml not found in the root directory."
  echo "Please add a SwiftLint config file before using the pre-commit hook."
  exit 1
else
  echo "✅ Found .swiftlint.yml"
fi

# Step 5: Validate that the config has at least one valid rule (like identifier_name)
if ! grep -q "identifier_name" .swiftlint.yml; then
  echo "⚠️ Warning: .swiftlint.yml does not contain a known rule like 'identifier_name'."
  echo "Please ensure your config is not empty or misconfigured."
else
  echo "✅ .swiftlint.yml appears to have valid rules configured."
fi

echo "🎉 Setup complete. You're ready to commit with SwiftLint enforced!"
