import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../utils/style_tokens.dart';
import 'glass_card.dart';

/// Medication Scanner Component (Camera Overlay)
class MedicationScanner extends StatefulWidget {
  final Function(MedicationData)? onScanComplete;

  const MedicationScanner({
    super.key,
    this.onScanComplete,
  });

  @override
  State<MedicationScanner> createState() => _MedicationScannerState();
}

class _MedicationScannerState extends State<MedicationScanner> {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(
          cameras[0],
          ResolutionPreset.medium,
        );
        await _controller!.initialize();
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      // Handle error - show mock scanner in development
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _scanBarcode() async {
    setState(() {
      _isScanning = true;
    });

    // Simulate scanning delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock medication data
    final mockData = MedicationData(
      name: 'Aspirin 81mg',
      dosage: '81mg',
      frequency: 'Once daily',
      instructions: 'Take with food',
    );

    setState(() {
      _isScanning = false;
    });

    widget.onScanComplete?.call(mockData);
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview or Mock
            if (_isInitialized && _controller != null)
              CameraPreview(_controller!)
            else
              Container(
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 64,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      const SizedBox(height: StyleTokens.spacing4),
                      Text(
                        'Camera Preview',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.6,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.all(StyleTokens.spacing4),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const Expanded(
                            child: Text(
                              'Scan Medication',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Scan Area
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeManager.currentTheme.primary,
                          width: 2,
                        ),
                        borderRadius:
                            BorderRadius.circular(StyleTokens.radiusMedium),
                      ),
                      child: Center(
                        child: _isScanning
                            ? CircularProgressIndicator(
                                color: themeManager.currentTheme.primary,
                              )
                            : Icon(
                                Icons.qr_code_scanner,
                                size: 64,
                                color: themeManager.currentTheme.primary,
                              ),
                      ),
                    ),
                    const Spacer(),
                    // Instructions
                    Padding(
                      padding: const EdgeInsets.all(StyleTokens.spacing4),
                      child: GlassCard(
                        padding: const EdgeInsets.all(StyleTokens.spacing4),
                        child: Column(
                          children: [
                            Text(
                              'Position barcode or label within the frame',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: StyleTokens.spacing4),
                            ElevatedButton(
                              onPressed: _isScanning ? null : _scanBarcode,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    themeManager.currentTheme.primary,
                                foregroundColor:
                                    themeManager.currentTheme.accentContrast,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: StyleTokens.spacing6,
                                  vertical: StyleTokens.spacing3,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      StyleTokens.radiusMedium),
                                ),
                              ),
                              child: const Text('Scan'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Medication Data Model
class MedicationData {
  final String name;
  final String dosage;
  final String frequency;
  final String instructions;

  MedicationData({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.instructions,
  });
}
