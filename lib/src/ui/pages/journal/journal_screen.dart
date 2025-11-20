import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';

/// Journal Screen with AI Summary
class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _textController = TextEditingController();
  int _selectedMood = 0;
  String? _aiSummary;
  bool _isGeneratingSummary = false;

  List<MoodOption> _getMoods(AppLocalizations l10n) {
    return [
      MoodOption(emoji: '😊', label: l10n.great),
      MoodOption(emoji: '🙂', label: l10n.good),
      MoodOption(emoji: '😐', label: l10n.okay),
      MoodOption(emoji: '😔', label: l10n.notGreat),
      MoodOption(emoji: '😢', label: l10n.bad),
    ];
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _generateSummary() async {
    if (_textController.text.trim().isEmpty) return;

    setState(() {
      _isGeneratingSummary = true;
    });

    try {
      // Mock summary generation
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _aiSummary =
            'Based on your journal entry, you\'re experiencing positive trends in your mood and energy levels. Your sleep quality has improved, and you\'re maintaining good activity levels. Consider continuing your current routine.';
        _isGeneratingSummary = false;
      });
    } catch (e) {
      setState(() {
        _isGeneratingSummary = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final moods = _getMoods(l10n);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
        title: Text(l10n.journal),
        actions: [
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {
              // Voice-to-text placeholder
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.voiceToTextComingSoon)),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(StyleTokens.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mood Selection
              Text(
                l10n.howAreYouFeeling,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: StyleTokens.spacing3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(moods.length, (index) {
                  final mood = moods[index];
                  final isSelected = _selectedMood == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMood = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(StyleTokens.spacing3),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? themeManager.currentTheme.primary.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius:
                            BorderRadius.circular(StyleTokens.radiusMedium),
                        border: Border.all(
                          color: isSelected
                              ? themeManager.currentTheme.primary
                              : Colors.transparent,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(mood.emoji,
                              style: const TextStyle(fontSize: 32)),
                          const SizedBox(height: StyleTokens.spacing1),
                          Text(
                            mood.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? themeManager.currentTheme.primary
                                  : StyleTokens.getTextSecondaryStatic(
                                      isDark: isDark),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Journal Entry
              Text(
                l10n.journalEntry,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: StyleTokens.spacing3),
              GlassCard(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: _textController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: l10n.writeAboutYourDay,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(StyleTokens.spacing4),
                  ),
                ),
              ),
              const SizedBox(height: StyleTokens.spacing4),
              // Generate Summary Button
              ElevatedButton.icon(
                onPressed: _isGeneratingSummary ? null : _generateSummary,
                icon: _isGeneratingSummary
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.auto_awesome),
                label: Text(_isGeneratingSummary
                    ? l10n.generating
                    : l10n.generateAISummary),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeManager.currentTheme.primary,
                  foregroundColor: themeManager.currentTheme.accentContrast,
                  padding: const EdgeInsets.symmetric(
                      vertical: StyleTokens.spacing4),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(StyleTokens.radiusMedium),
                  ),
                ),
              ),
              // AI Summary
              if (_aiSummary != null) ...[
                const SizedBox(height: StyleTokens.spacing6),
                GlassCard(
                  padding: const EdgeInsets.all(StyleTokens.spacing4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: themeManager.currentTheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: StyleTokens.spacing2),
                          Text(
                            l10n.aiSummary,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: themeManager.currentTheme.primary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: StyleTokens.spacing3),
                      Text(
                        _aiSummary!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class MoodOption {
  final String emoji;
  final String label;

  MoodOption({required this.emoji, required this.label});
}
