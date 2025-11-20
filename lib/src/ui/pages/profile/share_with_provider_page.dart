import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';
import '../care/provider_portal_view_page.dart';

/// Share with Provider Page
class ShareWithProviderPage extends StatefulWidget {
  const ShareWithProviderPage({super.key});

  @override
  State<ShareWithProviderPage> createState() => _ShareWithProviderPageState();
}

class _ShareWithProviderPageState extends State<ShareWithProviderPage> {
  String? _shareLink;
  bool _isGenerating = false;

  Future<void> _generateShareLink() async {
    setState(() {
      _isGenerating = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate mock share link
    const mockLink = 'https://share.vitalslink.app/s/xyz-123-abc';

    setState(() {
      _shareLink = mockLink;
      _isGenerating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/profile'),
        ),
        title: const Text('Share with My Doctor'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(StyleTokens.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: StyleTokens.spacing4),
              // Explanation Text
              GlassCard(
                padding: const EdgeInsets.all(StyleTokens.spacing5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.medical_services,
                          color: themeManager.currentTheme.primary,
                          size: 32,
                        ),
                        const SizedBox(width: StyleTokens.spacing3),
                        Expanded(
                          child: Text(
                            'Share Your Health Data',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: StyleTokens.spacing4),
                    Text(
                      'Share a live, secure view of your VitalsLink dashboard with your doctor or wellness provider. Your data is read-only and the link automatically expires in 72 hours.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: StyleTokens.getTextSecondaryStatic(
                                isDark: isDark),
                          ),
                    ),
                    const SizedBox(height: StyleTokens.spacing4),
                    Wrap(
                      spacing: StyleTokens.spacing4,
                      runSpacing: StyleTokens.spacing2,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lock,
                              size: 16,
                              color: themeManager.currentTheme.primary,
                            ),
                            const SizedBox(width: StyleTokens.spacing2),
                            Text(
                              'Secure & Encrypted',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: themeManager.currentTheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: themeManager.currentTheme.primary,
                            ),
                            const SizedBox(width: StyleTokens.spacing2),
                            Text(
                              'Expires in 72 hours',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: themeManager.currentTheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Generate Button
              ElevatedButton(
                onPressed: _isGenerating ? null : _generateShareLink,
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
                child: _isGenerating
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Generate Secure Share Link',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
              // Share Link Section
              if (_shareLink != null) ...[
                const SizedBox(height: StyleTokens.spacing6),
                GlassCard(
                  padding: const EdgeInsets.all(StyleTokens.spacing5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Share Link',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: StyleTokens.spacing4),
                      // QR Code Placeholder
                      Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color:
                                isDark ? const Color(0xFF1C1C1E) : Colors.white,
                            borderRadius:
                                BorderRadius.circular(StyleTokens.radiusMedium),
                            border: Border.all(
                              color: themeManager.currentTheme.primary
                                  .withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code,
                                size: 80,
                                color: themeManager.currentTheme.primary,
                              ),
                              const SizedBox(height: StyleTokens.spacing2),
                              Text(
                                'QR Code',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: StyleTokens.getTextSecondaryStatic(
                                          isDark: isDark),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: StyleTokens.spacing4),
                      // Share Link Text
                      Container(
                        padding: const EdgeInsets.all(StyleTokens.spacing4),
                        decoration: BoxDecoration(
                          color: themeManager.currentTheme.primary
                              .withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(StyleTokens.radiusSmall),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: SelectableText(
                                _shareLink!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: themeManager.currentTheme.primary,
                                      fontFamily: 'monospace',
                                    ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                // TODO: Copy to clipboard
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Link copied to clipboard'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: StyleTokens.spacing3),
                      // Info Text
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: StyleTokens.getTextSecondaryStatic(
                                isDark: isDark),
                          ),
                          const SizedBox(width: StyleTokens.spacing2),
                          Expanded(
                            child: Text(
                              'Share this link or QR code with your healthcare provider. They can view your dashboard data for 72 hours.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: StyleTokens.getTextSecondaryStatic(
                                        isDark: isDark),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: StyleTokens.spacing4),
                      // View Mock Provider Portal Button
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              themeManager.currentTheme.primary
                                  .withOpacity(0.1),
                              themeManager.currentTheme.primary
                                  .withOpacity(0.05),
                            ],
                          ),
                          borderRadius:
                              BorderRadius.circular(StyleTokens.radiusMedium),
                          border: Border.all(
                            color: themeManager.currentTheme.primary
                                .withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProviderPortalViewPage(),
                                ),
                              );
                            },
                            borderRadius:
                                BorderRadius.circular(StyleTokens.radiusMedium),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: StyleTokens.spacing4,
                                horizontal: StyleTokens.spacing4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    color: themeManager.currentTheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: StyleTokens.spacing2),
                                  Text(
                                    'View Mock Provider Portal',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color:
                                              themeManager.currentTheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
