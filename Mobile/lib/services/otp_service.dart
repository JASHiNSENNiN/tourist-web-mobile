import 'package:mongo_dart/mongo_dart.dart';
import '../model/otp_model.dart'; // Adjust the import path based on your directory structure

class OtpService {
  final Db _db;
  late final DbCollection _otpCollection;

  OtpService(this._db);

  Future<void> init() async {
    await _db.open();
    _otpCollection = _db.collection('otps');
  }

  Future<void> storeOtp(String email, String otp) async {
    final now = DateTime.now();
    /*final otpDoc = Otp(
      email: email,
      otp: otp,
      createdAt: now,
    );*/

    //FLawait _otpCollection.insertOne(otpDoc.toMap());
  }

  Future<bool> verifyOtp(String email, String otp) async {
    final otpDoc = await _otpCollection.findOne(
      where.eq('email', email).eq('otp', otp),
    );

    if (otpDoc == null) {
      return false;
    }

    final createdAt = otpDoc['createdAt'].toDate();
    final now = DateTime.now();
    final expirationTime = const Duration(minutes: 10);

    return now.isBefore(createdAt.add(expirationTime));
  }
}