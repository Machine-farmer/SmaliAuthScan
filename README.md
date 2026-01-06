# SmaliAuthScan

**Static Analysis Tool for Android Authentication Security**

A lightweight static analysis tool that detects authentication patterns and password leakage vulnerabilities in decompiled Android applications. Perfect for security researchers, penetration testers, and Android developers who want to audit their apps for authentication-related security issues.

## 🎯 Purpose

SmaliAuthScan analyzes Android apps (decompiled to smali format) to identify:
- Authentication methods and patterns in use
- Potential password leakage through `toString()` methods
- Security implications of different auth implementations
- OAuth/token-based authentication usage
- Biometric authentication support

## 🔍 What It Detects

### Authentication Patterns
1. **Traditional Username/Password** - Classic credential-based authentication
2. **Google Smart Lock/One Tap** - Google's credential management system
3. **Social Login** - Facebook, Google Sign-In, Apple Sign-In integration
4. **OAuth/Token-based** - Modern token-based authentication (Bearer tokens, access/refresh tokens)
5. **Biometric** - Fingerprint, face recognition authentication
6. **React Native** - Identifies React Native apps requiring additional JavaScript analysis

### Security Vulnerabilities
- **Critical: Password Leakage** - Detects passwords exposed in `toString()` methods (can leak to logs)
- **Warning: Insecure Storage** - Flags traditional password storage patterns for manual review

## 📋 Prerequisites

- **Zsh shell** (default on macOS, or modify shebang to `#!/bin/bash` for bash)
- **Decompiled Android APK** (smali format using apktool)
- Unix-like environment (Linux, macOS, WSL on Windows)

## 🚀 Installation & Usage

### 1. Decompile your Android APK
```bash
# Install apktool if you haven't already
# macOS: brew install apktool
# Linux: apt install apktool

# Decompile the APK
apktool d your-app.apk -o your-app
```

### 2. Run SmaliAuthScan
```bash
# Make the script executable
chmod +x smali-auth-scan.zsh

# Navigate to your decompiled app directory
cd your-app

# Run the scanner
../smali-auth-scan.zsh
```

## 📊 Sample Output

```
🔍 Authentication Patterns Analysis
===================================
App: com.example.myapp

📊 Authentication Patterns Found:

1. Traditional username/password: 15
2. Google Smart Lock/One Tap: 3
3. Social Login:
   • Facebook: 8
   • Google Sign-In: 12
   • Apple: 0
4. OAuth/Token-based: 25
5. Biometric: 5
6. React Native: 142

🔒 Security Implications:

⚠️  Uses traditional password storage - check for secure handling
✅ Uses Google Smart Lock (more secure password management)
✅ Supports social login (reduces password usage)
✅ Uses OAuth/token-based auth (better than passwords)
✅ Supports biometric authentication
ℹ️  React Native app - check JavaScript/TypeScript for auth logic

🚨 Vulnerability Check:
❌ VULNERABLE: Passwords in toString() methods detected
   Files with toString() passwords: 3
```

## 🛠️ Technical Details

### How It Works
SmaliAuthScan searches through decompiled smali bytecode for:
- Class and method declarations related to authentication
- String references to password fields
- OAuth/token management patterns
- Social SDK integrations (Facebook, Google, Apple)
- Biometric API usage
- Specific vulnerability patterns (toString() with password concatenation)

### The toString() Vulnerability
When password objects override `toString()` to include the password value, it can accidentally leak to:
- Android Logcat logs during debugging
- Error reporting services (Crashlytics, Sentry, etc.)
- System crash dumps
- Any code that calls `toString()` for logging/debugging

## ⚠️ Limitations

- **Static Analysis Only** - Cannot detect runtime behavior or dynamic password handling
- **False Positives Possible** - May flag legitimate debug/test code
- **React Native Apps** - Requires additional manual analysis of JavaScript/TypeScript code
- **Obfuscation Impact** - Heavily obfuscated code may hide patterns from detection
- **Code Coverage** - Only analyzes patterns in smali; native code (C/C++) not scanned

## 🔐 Ethical Use & Legal Notice

### ✅ Authorized Use Cases
- Security auditing of your own applications
- Penetration testing with proper written authorization
- Academic research and education
- Bug bounty programs where application analysis is permitted

### ❌ Prohibited Uses
This tool must **NOT** be used for:
- Unauthorized testing of third-party applications
- Malicious reverse engineering
- Intellectual property theft
- Any activity that violates applicable laws or terms of service

**Users are solely responsible for ensuring they have proper authorization before analyzing any application.**

---

## 🤝 Contributing & Contact

**SmaliAuthScan is actively under development!** 

If you:
- 🐛 Find bugs or issues
- 💡 Have feature suggestions
- 🔧 Want to contribute improvements
- ❓ Need help using the tool

**Please reach out!** You can find my contact details and connect with me through:

👉 **[PunchingBag-for-React2Shell](https://github.com/Machine-farmer/PunchingBag-for-React2Shell)** repository

- **Report Issues**: [GitHub Issues](https://github.com/Machine-farmer/SmaliAuthScan/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Machine-farmer/SmaliAuthScan/discussions)
- **Author**: Machine-farmer

### 🌟 Contribution Ideas

Help make SmaliAuthScan even better! Here are some areas where contributions would be valuable:

- [ ] Support for Kotlin-specific authentication patterns
- [ ] JWT token detection and validation
- [ ] API key and secret exposure checks
- [ ] Certificate pinning detection
- [ ] WebAuthn/FIDO2 support
- [ ] HTML report generation
- [ ] Integration with other security tools (MobSF, etc.)
- [ ] Database credential detection (SQLite, Realm, etc.)
- [ ] Hardcoded credential scanner
- [ ] Session token analysis
- [ ] Multi-language support (currently zsh only)

### How to Contribute

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

---

## 🔗 Related Tools & Resources

- **[apktool](https://ibotpeaches.github.io/Apktool/)** - The essential APK decompilation tool
- **[jadx](https://github.com/skylot/jadx)** - Dex to Java decompiler (easier to read than smali)
- **[MobSF](https://github.com/MobSF/Mobile-Security-Framework-MobSF)** - Comprehensive mobile security testing framework
- **[Frida](https://frida.re/)** - Dynamic instrumentation toolkit (complements static analysis)
- **[OWASP MASVS](https://github.com/OWASP/owasp-masvs)** - Mobile Application Security Verification Standard

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

Inspired by the need for lightweight, focused security tools that do one thing well. Built for the security community with ❤️ by someone who believes in making security testing accessible to everyone.

Special thanks to:
- The Android security research community
- Contributors to apktool, MobSF and related decompilation and analysis tools

---

## 🔄 Updates & Changelog

### Version 1.0.0 (January 2026)
- 🎉 Initial release
- ✅ Detection for 6 authentication patterns
- 🔍 Password leakage vulnerability scanner
- 📊 Detailed security implications reporting
- 🎨 Clean, colored terminal output

---

<div align="center">

*Remember: With great power comes great responsibility. Use your skills ethically.*

⭐ **If you find SmaliAuthScan useful, please star the repository!** ⭐

[Report Bug](https://github.com/Machine-farmer/SmaliAuthScan/issues) · [Request Feature](https://github.com/Machine-farmer/SmaliAuthScan/issues) · [View Other Projects](https://github.com/Machine-farmer)

</div>

