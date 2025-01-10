class Profile {
  final String uid;
  final bool type;
  final String fullName;
  final String phoneNumber;
  final String bio;
  final String address;
  final String education;
  final String extraInfo;
  final String image;
  final String exam;
  final List<String> subject; // Assuming subject is a list of Strings
  final double price;

  Profile({
    required this.uid,
    required this.type,
    required this.fullName,
    required this.phoneNumber,
    required this.bio,
    required this.address,
    required this.education,
    required this.extraInfo,
    required this.image,
    required this.exam,
    required this.subject,
    required this.price,
  });

  @override
  String toString() {
    return 'Profile(uid: $uid, type: $type, fullName: $fullName, phoneNumber: $phoneNumber, bio: $bio, address: $address, education: $education, extraInfo: $extraInfo, image: $image, exam: $exam, subject: $subject, price: $price)';
  }
}
