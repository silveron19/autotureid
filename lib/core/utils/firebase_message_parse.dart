class FirebaseMessageParse {
  static String parseSignUpError(String error) {
    switch (error) {
      case 'email-already-in-use':
        return 'Email telah digunakan';
      case 'invalid-email':
        return 'Email tidak valid';
      case 'operation-not-allowed':
        return 'Tidak bisa membuat akun dengan email';
      case 'weak-password':
        return 'Kata sandi terlalu lemah';
      default:
        return 'Tidak dapat terhubung ke server';
    }
  }

  static String parseSignInError(String error) {
    switch (error) {
      case 'invalid-email':
        return 'Email tidak valid';
      case 'user-disabled':
        return 'Email telah dinonaktifkan';
      case 'user-not-found':
        return 'Email dan/atau kata sandi salah';
      case 'wrong-password':
        return 'Email dan/atau kata sandi salah';
      case 'invalid-credential':
        return 'Email dan/atau kata sandi salah';
      default:
        return 'Tidak dapat terhubung ke server';
    }
  }

  static String parseForgetPasswordError(String error) {
    switch (error) {
      case 'auth/invalid-email':
        return 'Alamat email tidak valid';
      case 'auth/missing-android-pkg-name':
        return 'Tidak dapat terhubung ke server';
      case 'auth/missing-continue-uri':
        return 'Tidak dapat terhubung ke server';
      case 'auth/missing-ios-bundle-id':
        return 'Tidak dapat terhubung ke server';
      case 'auth/invalid-continue-uri':
        return 'Terjadi kesalahan';
      case 'auth/unauthorized-continue-uri':
        return 'Tidak dapat terhubung ke server';
      case 'auth/user-not-found':
        return 'User tidak ditemukan';
      default:
        return 'Tidak dapat terhubung ke server';
    }
  }

  static String parseUpdateEmailError(String error) {
    switch (error) {
      case 'email-already-in-use':
        return 'Email telah digunakan';
      case 'invalid-email':
        return 'Email tidak valid';
      case 'operation-not-allowed':
        return 'Tidak bisa mengubah email';
      case 'requires-recent-login':
        return 'Silahkan login kembali';
      default:
        return 'Tidak dapat terhubung ke server';
    }
  }
}
