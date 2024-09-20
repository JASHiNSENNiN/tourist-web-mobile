import 'package:mongo_dart/mongo_dart.dart';

class OtpService {
  final Db db;
  late DbCollection otpCollection;

  OtpService(this.db);

  Future<void> init() async {
    await db.open();
    otpCollection = db.collection('otps');
  }

  Future<void> storeOtp(String email, String otp) async {
    await otpCollection.update(
      {'email': email},
      {'\$set': {'otp': otp, 'createdAt': DateTime.now()}},
      upsert: true,
    );
  }

  Future<bool> verifyOtp(String email, String otp) async {
    final result = await otpCollection.findOne(
      where.eq('email', email)
        .and(where.eq('otp', otp))
        .and(where.gt('createdAt', DateTime.now().subtract(const Duration(minutes: 5)))),
    );

    return result != null;
  }
}
