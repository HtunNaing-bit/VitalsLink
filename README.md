# HELIOS — AI-Powered Health & Wellness OS

**Production-ready, investor-grade Flutter application**

**Mission:** Build a premium, trustworthy AI Health OS that unifies fragmented personal health data, proactively prevents illness, and connects users to care.

---

## 🚀 Quick Start

### Prerequisites

- Flutter 3.24.0 or higher
- Dart 3.3.0 or higher
- iOS 12.0+ / Android API 21+
- Xcode 14+ (for iOS)

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/your-org/helios.git
cd helios
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Generate localization files:**
```bash
flutter gen-l10n
```

4. **Run the app:**
```bash
flutter run
```

---

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── app_router.dart             # Navigation routes
├── src/                        # New modular structure
│   ├── utils/
│   │   └── style_tokens.dart   # Theme tokens & ThemeManager
│   ├── services/
│   │   ├── ai_service.dart     # AI service (mock → production)
│   │   ├── health_sync.dart    # Health sync abstraction
│   │   ├── payment_service.dart # Stripe / IAP stub
│   │   └── ...                 # Other services
│   ├── ui/
│   │   ├── components/
│   │   │   ├── glass_card.dart
│   │   │   ├── theme_selector.dart
│   │   │   ├── progress_stepper.dart
│   │   │   ├── medication_scanner.dart
│   │   │   └── food_ocr_stub.dart
│   │   └── screens/
│   │       ├── onboarding/
│   │       │   ├── onb_welcome.dart
│   │       │   ├── onb_goals.dart
│   │       │   ├── onb_theme_select.dart
│   │       │   ├── onb_connect.dart
│   │       │   ├── onb_permissions.dart
│   │       │   └── onb_summary.dart
│   │       └── ...             # Other screens
│   └── models/                 # Data models
├── core/                       # Legacy core (being migrated)
└── features/                   # Legacy features (being migrated)
mocks/
├── ai/
│   ├── insights.json
│   └── chat_responses.json
└── health/
    └── sample_profile.json
```

---

## 🎨 Theming System

### Theme Variants

HELIOS supports 4 theme variants:

1. **Default Blue** (#007AFF) - Apple-style primary
2. **Teal Gradient** (#5EE6C4 → #A3F3FF) - Fresh, energetic
3. **Deep Indigo** (#3B3BFF → #7A5CFF) - Calm, focused
4. **Auto** - Changes based on time of day

### Changing Themes

**In Code:**
```dart
import 'package:helios/src/utils/style_tokens.dart';

final themeManager = ThemeManager();
await themeManager.setTheme(ThemePresets.tealGradient);
await themeManager.setAutoMode(true);
```

**Theme Tokens Location:**
- `lib/src/utils/style_tokens.dart` - All theme tokens and ThemeManager

**Theme Selector Component:**
- `lib/src/ui/components/theme_selector.dart` - Live preview component

---

## 🔧 Mock Services

### Enabling/Disabling Mocks

**AI Service:**
```dart
// lib/src/services/ai_service.dart
final aiService = AIService();
aiService.useMocks = true;  // Use mock JSON
aiService.useMocks = false; // Use real API
aiService.baseUrl = 'https://api.helios.com'; // Set API URL
```

**Mock JSON Files:**
- `mocks/ai/insights.json` - Daily insights
- `mocks/ai/chat_responses.json` - Chat responses
- `mocks/health/sample_profile.json` - Sample health data

### Replacing Mocks with Real Services

1. **Set `useMocks = false`** in the service
2. **Set `baseUrl`** to your API endpoint
3. **Update API endpoints** to match your backend
4. **Handle authentication** (add tokens/headers)

---

## 🏗️ Features

### Core Features (MVP)

- ✅ **Apple-Style Design System** - Minimalist, glassmorphic UI
- ✅ **Theme Selection** - 4 variants with auto mode
- ✅ **Onboarding Flow** - Welcome → Goals → Theme → Connect → Permissions → Summary
- ✅ **Daily Health Dashboard** - Sleep, Heart Rate, Energy, Mood, Steps
- ✅ **AI Insights** - Personalized recommendations with confidence scores
- ✅ **Journal & Mood Tracker** - Quick mood logging with AI summaries
- ✅ **"Ask HELIOS" Chat** - Conversational AI health coaching
- ✅ **Health Data Sync** - HealthKit/Google Fit abstraction layer
- ✅ **Telehealth Booking** - Provider marketplace
- ✅ **Subscription Management** - Freemium with premium tiers
- ✅ **Security & Compliance** - HIPAA-ready patterns, GDPR-compliant

### New Features (Scaffolded)

- ✅ **Universal Data Hub** - EMR/EHR, Lab, Genetic imports (stubs)
- ✅ **Family & Shared Accounts** - Invite family, role-based sharing (stubs)
- ✅ **Clinician Tools** - PDF/FHIR export, summaries, RBAC (stubs)
- ✅ **Medication Management** - Scanner, schedule, adherence (stubs)
- ✅ **Nutrition OCR** - Photo-to-log with mock nutrition (stubs)
- ✅ **Smart Scheduling** - AI-scheduled restorative breaks (stubs)
- ✅ **Emergency Mode** - Shareable health snapshot (stubs)
- ✅ **Privacy Modes** - Family/Employer toggles, data residency (stubs)

---

## 🔐 Security & Compliance

### HIPAA Checklist

- ✅ **Consent Flows** - Onboarding includes consent management
- ✅ **Audit Logs** - `SecurityService.logDataAccess()`
- ✅ **Data Encryption** - Encryption patterns in `SecurityService`
- ✅ **Data Export/Erase** - GDPR compliance implemented
- ⚠️ **Data Residency** - Regional toggle (stub)
- ⚠️ **TLS Everywhere** - Ready for production

### Privacy Settings

- **Privacy Center** - Access in Profile → Privacy
- **Consent Management** - Revoke permissions anytime
- **Data Export** - Export all data in Profile → Privacy
- **Data Deletion** - Delete account and all data

---

## 🧪 Testing

### Run Tests

```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widget/

# Integration tests
flutter test integration_test/
```

### Mock Server (Optional)

For local development with mock API:

```bash
# Using Dart Shelf
dart run mocks/server.dart

# Or using Node.js
node mocks/server.js
```

---

## 📱 Platform Support

- **iOS** - 12.0+
- **Android** - API 21+ (Android 5.0+)
- **Web** - Architecture ready (not yet implemented)

---

## 🔄 Porting to React Native + TypeScript

### Theme Tokens

- Keep `style_tokens.dart` as JSON export
- Use same token structure in TypeScript
- Map Flutter colors to React Native ColorValue

### Components Mapping

- `GlassCard` → `react-native-blur` + styled-components
- `ChartStrip` → `react-native-svg` sparklines
- `AIChat` → `react-native-gifted-chat` or custom
- `ThemeSelector` → React Context + styled-components

### Services

- Keep same REST endpoints `/api/*`
- Use `fetch` or `axios` instead of `http`
- Same mock JSON structure

---

## 📊 Analytics & Growth

### Event Tracking

- **DAU/WAU/MAU** - Daily/Weekly/Monthly active users
- **Funnels** - Onboarding, subscription, feature adoption
- **Retention** - Day 1, Day 7, Day 30 retention
- **Referrals** - In-app and clinician referrals

### Success Metrics (MVP)

- Day 1 retention ≥ 40%
- 30-day retention ≥ 15%
- Conversion to premium ≥ 3% (first 90 days)
- NPS ≥ 40 post-trial

---

## 🚢 Deployment

### Environment Separation

- **Dev** - Local development with mocks
- **Staging** - Staging API endpoints
- **Prod** - Production API endpoints

### CI/CD

- **GitHub Actions** - `.github/workflows/ci.yml`
- **Build Checks** - `flutter analyze`, `flutter test`, `flutter build`

---

## 📚 Documentation

- **Product Spec** - `PRODUCT_SPEC.md`
- **12-Month Roadmap** - `ROADMAP_12_MONTHS.md`
- **Go-to-Market** - `GO_TO_MARKET_PLAYBOOK.md`
- **Investor Pitch** - `INVESTOR_PITCH.md`

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and linting
5. Submit a pull request

---

## 📄 License

[Your License Here]

---

## 🆘 Support

For issues, questions, or contributions, please open an issue on GitHub.

---

**Last Updated:** 2024  
**Version:** 1.0.0  
**Status:** MVP Ready for Development
# VitalsLink
# VitalsLink
