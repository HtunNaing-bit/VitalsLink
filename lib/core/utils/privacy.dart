class PrivacyUtils {
  static String vaultStatus({
    required bool encrypted,
    required bool consentActive,
  }) {
    if (encrypted && consentActive) {
      return 'Vault Locked · Consent Active';
    }
    if (!encrypted && consentActive) {
      return 'Vault Unencrypted · Consent Active';
    }
    if (encrypted && !consentActive) {
      return 'Vault Locked · Consent Required';
    }
    return 'Vault Unsecured';
  }

  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final name = parts.first;
    final domain = parts.last;
    final maskedName =
        name.length <= 2 ? '${name[0]}*' : '${name.substring(0, 2)}***';
    return '$maskedName@$domain';
  }
}
