import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/style_tokens.dart';
import 'glass_card.dart';

/// Food OCR Stub Component (Photo-to-Log with Mock Nutrition)
class FoodOCRStub extends StatefulWidget {
  final Function(NutritionData)? onNutritionDetected;

  const FoodOCRStub({
    super.key,
    this.onNutritionDetected,
  });

  @override
  State<FoodOCRStub> createState() => _FoodOCRStubState();
}

class _FoodOCRStubState extends State<FoodOCRStub> {
  final ImagePicker _picker = ImagePicker();
  bool _isProcessing = false;

  Future<void> _pickImage() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _isProcessing = true;
        });

        // Simulate OCR processing
        await Future.delayed(const Duration(seconds: 2));

        // Mock nutrition data
        final mockNutrition = NutritionData(
          foodName: 'Grilled Chicken Salad',
          calories: 320,
          protein: 35,
          carbs: 12,
          fat: 12,
          confidence: 0.85,
        );

        setState(() {
          _isProcessing = false;
        });

        widget.onNutritionDetected?.call(mockNutrition);
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      // Show error
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(StyleTokens.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: StyleTokens.spacing4),
              // Header
              Text(
                'Log Food',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: StyleTokens.spacing2),
              Text(
                'Take a photo of your meal to automatically log nutrition',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: StyleTokens.spacing8),
              // Camera Button
              GlassCard(
                padding: const EdgeInsets.all(StyleTokens.spacing6),
                onTap: _isProcessing ? null : _pickImage,
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color:
                            themeManager.currentTheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: _isProcessing
                          ? CircularProgressIndicator(
                              color: themeManager.currentTheme.primary,
                            )
                          : Icon(
                              Icons.camera_alt,
                              size: 48,
                              color: themeManager.currentTheme.primary,
                            ),
                    ),
                    const SizedBox(height: StyleTokens.spacing4),
                    Text(
                      _isProcessing ? 'Processing...' : 'Take Photo',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: StyleTokens.spacing2),
                    Text(
                      'AI will detect food and nutrition',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: StyleTokens.getTextSecondaryStatic(
                                isDark: isDark),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Info Card
              GlassCard(
                padding: const EdgeInsets.all(StyleTokens.spacing4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: themeManager.currentTheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: StyleTokens.spacing2),
                        Text(
                          'How it works',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: StyleTokens.spacing3),
                    Text(
                      'Our AI analyzes your food photo to identify items and estimate nutrition. Results are approximate and should be verified.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: StyleTokens.getTextSecondaryStatic(
                                isDark: isDark),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Nutrition Data Model
class NutritionData {
  final String foodName;
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final double confidence;

  NutritionData({
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.confidence,
  });
}
