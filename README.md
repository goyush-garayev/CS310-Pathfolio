# PathFolio: Travel Planner

A Flutter mobile app that turns a traveler's destination, dates, interests, pace and budget into a personalized day-by-day travel plan.

## Description
PathFolio generates an itinerary with time slots, short descriptions and estimated costs. Users can remove or reorder activities, regenerate a single day, add custom activities and save plans on the device.

## Group Details
- Course: CS310 Mobile Application Development
- Group number: 16

| Member | Student ID |
|---|---|
| Jamal Hashimzada | 36091 |
| Goyush Garayev | 36132 |
| Miras Zeingabul | 36112 |
| Mehdi Gamarli | 36029 |

## Run the app

**Flutter version used:** Flutter 3.47.7 (stable), Dart 3.13.5

```bash
git clone https://github.com/goyush-garayev/CS310-Pathfolio.git
cd CS310-Pathfolio
flutter pub get
flutter run
```

Run it on an Android emulator or an iOS simulator (portrait mode).

To run the test and the analyzer:

```bash
flutter analyze
flutter test
```

## Step 2.2 – what is implemented
- **Screens (12):** Welcome, Sign up, Log in, Home (Explore), Preferences, Trip details, Generating, Itinerary, Activity details, Add activity, Saved trips, Account.
- **Navigation:** named routes (`lib/utils/app_routes.dart`, `onGenerateRoute` in `main.dart`) and a floating pill nav bar (Explore / Trips / Account).
- **Shared style files:** `lib/utils/app_colors.dart`, `app_text_styles.dart`, `app_spacing.dart`, `app_theme.dart`.
- **Reusable widgets:** `lib/widgets/` (buttons, text field, chips, segmented selector, cards, nav bar, headers).
- **Images:** local logo (`assets/images/logo.png`) and network city photos on Home.
- **Custom font:** Inter (app text) and Poppins (logo wordmark) in `assets/fonts/`.
- **Model objects in Cards with remove:** `Trip` and `Activity` models; Saved trips and Itinerary show them as `Card`s with a remove button (and Undo).
- **Form:** Add activity has 5 fields with inline validation errors and a confirmation dialog after a valid submit. Sign up / Log in also validate inline.
- **Responsive:** scrollable screens, `Expanded`/`Wrap`/`FittedBox`, text ellipsis, and a max content width for large phones.
- Login and sign up are UI only. Data is placeholder (`lib/data/sample_data.dart`); Firebase comes in Step 3.

## Project structure
```
lib/
  main.dart                 app + routes
  utils/                    colors, text styles, spacing, theme, routes, validators
  models/                   Trip, TripDay, Activity, City
  data/                     placeholder data + in-memory TripStore
  widgets/                  reusable widgets
  screens/
    auth/                   welcome, sign up, log in
    main/                   nav shell, home, saved trips, account
    plan/                   preferences, trip details, generating
    trip/                   itinerary, activity details, add activity
assets/
  images/                   logo.png
  fonts/                    Inter, Poppins
```

## Tech Stack (planned for next steps)
- Flutter / Dart
- Firebase (auth + storage) – Step 3
- Gemini API (via Firebase AI Logic) for itinerary generation
- Open-Meteo API (optional weather feature)
