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
      case 'invalid-credential':
      return 'Kata sandi salah';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Coba lagi nanti';
      default:
        return 'Tidak dapat terhubung ke server';
    }
  }

  static String parseForgotPasswordError(String error) {
    switch (error) {
      case 'user-not-found':
        return 'User tidak ditemukan';
      case 'invalid-email':
        return 'Email tidak valid';
      case 'invalid-verification-code':
        return 'Kode verifikasi tidak valid';
      case 'invalid-verification-id':
        return 'ID verifikasi tidak valid';
      case 'missing-verification-code':
        return 'Kode verifikasi tidak ditemukan';
      case 'missing-verification-id':
        return 'ID verifikasi tidak ditemukan';
      case 'session-expired':
        return 'Sesi telah berakhir';
      default:
        return 'Tidak dapat terhubung ke server';
    }
  }
}
