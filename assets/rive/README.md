# Rive Animation Files

This directory should contain Rive animation files (.riv).

## Required Files

1. **hero.riv** - Hero animation
   - States: idle, tapped
   - Used in: Onboarding, Welcome screens

2. **avatar.riv** - AI Coach avatar
   - States: idle, speak, listen
   - Used in: AI Coach screen, Onboarding

3. **checkmark.riv** - Checkmark animation
   - Action: draw
   - Used in: Goal completion, Success states

## Placeholder

For now, the app will use a fallback icon when Rive files are not found.
To add animations:
1. Create animations in Rive (https://rive.app)
2. Export as .riv files
3. Place them in this directory
4. Update the asset paths in the code if needed

