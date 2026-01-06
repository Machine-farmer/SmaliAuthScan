#!/usr/bin/env zsh

# Android Authentication Pattern Analyzer
# Analyzes decompiled Android apps (smali) for authentication patterns and security issues
# Version: 1.0.0

echo "🔍 Authentication Patterns Analysis"
echo "==================================="
echo "App: $(basename "$(pwd)")"
echo ""

# Count various patterns
echo "📊 Authentication Patterns Found:"
echo ""

# 1. Traditional username/password
TRADITIONAL=$(find smali* -name "*.smali" -type f -exec grep -l "password:Ljava/lang/String;" {} \; 2>/dev/null | wc -l)
echo "1. Traditional username/password: $TRADITIONAL"

# 2. Google Smart Lock
GOOGLE_SMART=$(find smali* -name "*.smali" -type f -exec grep -l "SavePasswordRequest\|GetSignInIntent\|GetPhoneNumberHintIntent" {} \; 2>/dev/null | wc -l)
echo "2. Google Smart Lock/One Tap: $GOOGLE_SMART"

# 3. Social login
FACEBOOK=$(find smali* -name "*.smali" -type f -exec grep -l "com.facebook.login\|FacebookLogin" {} \; 2>/dev/null | wc -l)
GOOGLE_SIGNIN=$(find smali* -name "*.smali" -type f -exec grep -l "GoogleSignIn\|google.signin" {} \; 2>/dev/null | wc -l)
APPLE=$(find smali* -name "*.smali" -type f -exec grep -l "RNAppleAuthentication\|SignInWithApple" {} \; 2>/dev/null | wc -l)
echo "3. Social Login:"
echo "   • Facebook: $FACEBOOK"
echo "   • Google Sign-In: $GOOGLE_SIGNIN"
echo "   • Apple: $APPLE"

# 4. OAuth/Token based
OAUTH=$(find smali* -name "*.smali" -type f -exec grep -l "OAuth\|oauth\|Bearer\|access_token\|refresh_token" {} \; 2>/dev/null | wc -l)
echo "4. OAuth/Token-based: $OAUTH"

# 5. Biometric
BIOMETRIC=$(find smali* -name "*.smali" -type f -exec grep -l "BiometricPrompt\|FingerprintManager\|FaceManager" {} \; 2>/dev/null | wc -l)
echo "5. Biometric: $BIOMETRIC"

# 6. React Native
REACT_NATIVE=$(find smali* -name "*.smali" -type f -exec grep -l "ReactNative\|reactnative" {} \; 2>/dev/null | wc -l)
echo "6. React Native: $REACT_NATIVE"

echo ""
echo "🔒 Security Implications:"
echo ""

if [[ $TRADITIONAL -gt 0 ]]; then
    echo "⚠️  Uses traditional password storage - check for secure handling"
fi

if [[ $GOOGLE_SMART -gt 0 ]]; then
    echo "✅ Uses Google Smart Lock (more secure password management)"
fi

if [[ $FACEBOOK -gt 0 || $GOOGLE_SIGNIN -gt 0 || $APPLE -gt 0 ]]; then
    echo "✅ Supports social login (reduces password usage)"
fi

if [[ $OAUTH -gt 0 ]]; then
    echo "✅ Uses OAuth/token-based auth (better than passwords)"
fi

if [[ $BIOMETRIC -gt 0 ]]; then
    echo "✅ Supports biometric authentication"
fi

if [[ $REACT_NATIVE -gt 0 ]]; then
    echo "ℹ️  React Native app - check JavaScript/TypeScript for auth logic"
fi

# Check for the specific vulnerability
echo ""
echo "🚨 Vulnerability Check:"
if [[ $TRADITIONAL -gt 0 ]]; then
    # Check if vulnerable toString() exists
    VULN_COUNT=$(find smali* -name "*.smali" -type f -exec grep -l '\", password=\"' {} \; 2>/dev/null | wc -l)
    if [[ $VULN_COUNT -gt 0 ]]; then
        echo "❌ VULNERABLE: Passwords in toString() methods detected"
        echo "   Files with toString() passwords: $VULN_COUNT"
    else
        echo "⚠️  Traditional passwords used but no toString() exposure found"
    fi
else
    echo "✅ No traditional password storage detected"
fi
