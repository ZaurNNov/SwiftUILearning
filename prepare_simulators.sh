#!/bin/bash

set -e

# === НАСТРОЙКИ ПО УМОЛЧАНИЮ ===
DEVICE_NAME=${1:-"iPhone 16e"}
OS_VERSION=${2:-"18.4"}
LANGUAGE=${3:-"en"}
LOCALE=${4:-"en_US"}
SCHEME_NAME=${5:-"SwiftUILearning"} # Поменяй на нужную схему, если будет другая

# === НАЙТИ UDID СИМУЛЯТОРА (игнорируя регистр, с кавычками) ===
UDID=$(xcrun simctl list devices available \
  | grep -i "$DEVICE_NAME (" \
  | sed -E 's/.*\(([-A-F0-9]+)\).*/\1/' \
  | head -n 1)

if [ -z "$UDID" ]; then
  echo "❌ Не найден симулятор \"$DEVICE_NAME\" ($OS_VERSION)"
  echo "📋 Доступные устройства:"
  xcrun simctl list devices available | grep -i "$DEVICE_NAME"
  exit 1
fi

# === ПЕРЕЗАПУСК СИМУЛЯТОРА ===
echo "🔁 Перезапуск симулятора $DEVICE_NAME ($LANGUAGE / $LOCALE)"
xcrun simctl shutdown "$UDID"

# === УСТАНОВКА ЯЗЫКА И РЕГИОНА ===
defaults write com.apple.iphonesimulator AppleLanguages -array "$LANGUAGE"
defaults write com.apple.iphonesimulator AppleLocale "$LOCALE"

xcrun simctl boot "$UDID"
sleep 5

# === ЗАПУСК ТЕСТОВ ===
echo "🚀 Запуск тестов на $DEVICE_NAME ($LANGUAGE / $LOCALE)"
xcodebuild \
  -scheme "$SCHEME_NAME" \
  -destination "platform=iOS Simulator,id=$UDID" \
  SIMCTL_CHILD_APPLE_LANGUAGE=$LANGUAGE \
  SIMCTL_CHILD_APPLE_LOCALE=$LOCALE \
  test
