# 🔐 Biometric Authentication App – Flutter

## 📱 What It Does
A Flutter-based mobile app that uses device-level biometric authentication to protect access.

When launched, it automatically prompts the user to authenticate using:
- ✅ Fingerprint
- ✅ Face recognition (if supported)
- ✅ Fallback to device PIN, pattern, or password

Upon successful authentication, it navigates to a secure welcome screen.  
Users can return to the authentication screen via a back arrow.

---

## 🔐 Security Details

### ✅ Biometric Authentication
- Uses Flutter’s `local_auth` plugin to access secure platform APIs.
- App never stores or accesses raw fingerprint or facial data.
- Biometric credentials are verified securely inside the OS:
  - Android: Trusted Execution Environment (TEE)
  - iOS: Secure Enclave

### ✅ Fallback Authentication
- If biometrics are unavailable or not enrolled:
  - System-controlled fallback screen is shown
  - Allows user to authenticate with their PIN, pattern, or password
- This fallback screen is fully secure and handled by the OS

### 🔒 Encrypted & Zero-Trust
- The app **never receives** biometric data — only a success/failure result.
- Full authentication is performed by the OS.
- No sensitive data is stored or transmitted by the app.

---

## 📦 Technologies & Packages
- Flutter
- local_auth (biometric authentication)

## 📹 Demo Video
project-demo: https://drive.google.com/file/d/1sLcIjziP5_kc6rPT6K5OeUzsxs9EBuSf/view?usp=drive_link

---

## 🛠 How to Set Up
1. Clone the repo
2. Run `flutter pub get`
3. Run `flutter run` on a real device with biometrics enabled

---

## ⚠️ Limitations / Assumptions
- Works only on devices with biometric hardware and enrolled biometrics
- Tested on Android fingerprint and PIN fallback
- No token or session storage implemented (for demo purposes only)
