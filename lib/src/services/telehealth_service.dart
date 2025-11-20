/// Telehealth Service (Mock)
/// Handles teleconsult booking, provider listings, and prescriptions
class TelehealthService {
  static final TelehealthService _instance = TelehealthService._internal();
  factory TelehealthService() => _instance;
  TelehealthService._internal();

  List<Doctor> _doctors = [];
  List<Consultation> _consultations = [];
  List<Prescription> _prescriptions = [];

  /// Initialize and load mock data
  Future<void> initialize() async {
    await _loadMockDoctors();
    await _loadMockConsultations();
    await _loadMockPrescriptions();
  }

  /// Get all available doctors
  Future<List<Doctor>> getDoctors({String? specialty}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (specialty != null) {
      return _doctors.where((d) => d.specialty == specialty).toList();
    }
    return List.from(_doctors);
  }

  /// Get doctor by ID
  Future<Doctor?> getDoctor(String doctorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _doctors.firstWhere((d) => d.id == doctorId);
    } catch (e) {
      return null;
    }
  }

  /// Book a consultation
  Future<Consultation> bookConsultation({
    required String doctorId,
    required DateTime preferredTime,
    required String reason,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final doctor = await getDoctor(doctorId);
    if (doctor == null) {
      throw Exception('Doctor not found');
    }

    final consultation = Consultation(
      id: 'consult_${DateTime.now().millisecondsSinceEpoch}',
      doctorId: doctorId,
      doctorName: doctor.name,
      doctorSpecialty: doctor.specialty,
      scheduledTime: preferredTime,
      reason: reason,
      status: 'scheduled',
      createdAt: DateTime.now(),
    );

    _consultations.add(consultation);
    return consultation;
  }

  /// Get user's consultations
  Future<List<Consultation>> getConsultations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_consultations);
  }

  /// Get prescriptions
  Future<List<Prescription>> getPrescriptions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_prescriptions);
  }

  /// Get prescription by ID
  Future<Prescription?> getPrescription(String prescriptionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _prescriptions.firstWhere((p) => p.id == prescriptionId);
    } catch (e) {
      return null;
    }
  }

  /// Load mock doctors
  Future<void> _loadMockDoctors() async {
    _doctors = [
      Doctor(
        id: 'doctor_001',
        name: 'Dr. Sarah Johnson',
        specialty: 'General Practitioner',
        rating: 4.8,
        experience: 12,
        imageUrl: null,
        bio:
            'Board-certified family physician with expertise in preventive care.',
        availableSlots: ['09:00', '10:00', '14:00', '15:00'],
      ),
      Doctor(
        id: 'doctor_002',
        name: 'Dr. Michael Chen',
        specialty: 'Cardiologist',
        rating: 4.6,
        experience: 15,
        imageUrl: null,
        bio:
            'Cardiologist specializing in preventive cardiology and heart health.',
        availableSlots: ['10:00', '11:00', '13:00', '16:00'],
      ),
      Doctor(
        id: 'doctor_003',
        name: 'Dr. Emily Davis',
        specialty: 'Nutritionist',
        rating: 4.9,
        experience: 8,
        imageUrl: null,
        bio: 'Registered dietitian focused on personalized nutrition plans.',
        availableSlots: ['09:00', '12:00', '14:00', '17:00'],
      ),
      Doctor(
        id: 'doctor_004',
        name: 'Dr. James Wilson',
        specialty: 'Mental Health',
        rating: 4.7,
        experience: 10,
        imageUrl: null,
        bio:
            'Licensed therapist specializing in stress management and wellness.',
        availableSlots: ['10:00', '11:00', '15:00', '16:00'],
      ),
    ];
  }

  /// Load mock consultations
  Future<void> _loadMockConsultations() async {
    _consultations = [];
  }

  /// Load mock prescriptions
  Future<void> _loadMockPrescriptions() async {
    _prescriptions = [
      Prescription(
        id: 'presc_001',
        doctorId: 'doctor_001',
        doctorName: 'Dr. Sarah Johnson',
        medications: [
          Medication(
            name: 'Vitamin D3',
            dosage: '1000 IU',
            frequency: 'Once daily',
            duration: '30 days',
          ),
        ],
        issuedDate: DateTime.now().subtract(const Duration(days: 7)),
        notes: 'Take with food. Follow up in 4 weeks.',
      ),
    ];
  }
}

/// Doctor Model
class Doctor {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int experience;
  final String? imageUrl;
  final String bio;
  final List<String> availableSlots;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.experience,
    this.imageUrl,
    required this.bio,
    required this.availableSlots,
  });
}

/// Consultation Model
class Consultation {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final DateTime scheduledTime;
  final String reason;
  final String status; // scheduled, completed, cancelled
  final DateTime createdAt;

  Consultation({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.scheduledTime,
    required this.reason,
    required this.status,
    required this.createdAt,
  });
}

/// Prescription Model
class Prescription {
  final String id;
  final String doctorId;
  final String doctorName;
  final List<Medication> medications;
  final DateTime issuedDate;
  final String notes;

  Prescription({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.medications,
    required this.issuedDate,
    required this.notes,
  });
}

/// Medication Model
class Medication {
  final String name;
  final String dosage;
  final String frequency;
  final String duration;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
  });
}
