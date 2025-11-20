import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/style_tokens.dart';

/// Theme Selector Component with Live Preview
class ThemeSelector extends StatefulWidget {
  final ThemeVariant? initialTheme;
  final bool initialAutoMode;
  final Function(ThemeVariant) onThemeSelected;
  final Function(bool) onAutoModeChanged;

  const ThemeSelector({
    super.key,
    this.initialTheme,
    this.initialAutoMode = false,
    required this.onThemeSelected,
    required this.onAutoModeChanged,
  });

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  late ThemeVariant _selectedTheme;
  late bool _autoMode;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.initialTheme ?? ThemePresets.defaultBlue;
    _autoMode = widget.initialAutoMode;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Auto Mode Toggle
        _buildAutoModeToggle(isDark),
        const SizedBox(height: StyleTokens.spacing4),

        // Theme Options
        if (!_autoMode) ...[
          Text(
            'Choose Theme',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: StyleTokens.spacing3),
          _buildThemeGrid(isDark),
          const SizedBox(height: StyleTokens.spacing4),
        ],

        // Live Preview
        _buildPreview(isDark),
      ],
    );
  }

  Widget _buildAutoModeToggle(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(StyleTokens.spacing3),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
        border: Border.all(
          color: isDark ? const Color(0xFF38383A) : const Color(0xFFE5E5EA),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.brightness_auto,
            color: _selectedTheme.primary,
            size: 24,
          ),
          const SizedBox(width: StyleTokens.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Auto Theme',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'Changes based on time of day',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color:
                            StyleTokens.getTextSecondaryStatic(isDark: isDark),
                      ),
                ),
              ],
            ),
          ),
          Switch(
            value: _autoMode,
            onChanged: (value) {
              setState(() {
                _autoMode = value;
              });
              widget.onAutoModeChanged(value);
            },
            activeThumbColor: _selectedTheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeGrid(bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: StyleTokens.spacing3,
        mainAxisSpacing: StyleTokens.spacing3,
        childAspectRatio: 1.2,
      ),
      itemCount: ThemePresets.all.length,
      itemBuilder: (context, index) {
        final theme = ThemePresets.all[index];
        final isSelected = theme.id == _selectedTheme.id;

        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() {
              _selectedTheme = theme;
            });
            widget.onThemeSelected(theme);
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: theme.accentGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
              border: Border.all(
                color: isSelected ? Colors.white : Colors.transparent,
                width: isSelected ? 3 : 0,
              ),
            ),
            child: Stack(
              children: [
                // Theme preview
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: theme.accentContrast,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: StyleTokens.spacing2),
                      Text(
                        theme.name,
                        style: TextStyle(
                          color: theme.accentContrast,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Selection indicator
                if (isSelected)
                  Positioned(
                    top: StyleTokens.spacing2,
                    right: StyleTokens.spacing2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.accentContrast,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        size: 16,
                        color: theme.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreview(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _selectedTheme.accentGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(StyleTokens.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preview',
            style: TextStyle(
              color: _selectedTheme.accentContrast,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: StyleTokens.spacing3),
          Container(
            padding: const EdgeInsets.all(StyleTokens.spacing3),
            decoration: BoxDecoration(
              color: _selectedTheme.accentContrast.withOpacity(0.2),
              borderRadius: BorderRadius.circular(StyleTokens.radiusSmall),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _selectedTheme.accentContrast,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: StyleTokens.spacing3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12,
                        width: 100,
                        decoration: BoxDecoration(
                          color: _selectedTheme.accentContrast,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 8,
                        width: 60,
                        decoration: BoxDecoration(
                          color: _selectedTheme.accentContrast.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
