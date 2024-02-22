String getLoginErrorMessage(String errorMessage) {
  switch (errorMessage) {
    case 'user-not-found':
      return "ユーザーが見つかりません。";
    case 'wrong-password':
      return "パスワードが間違っています。";
    case 'user-disabled':
      return "このユーザーは無効です。";
    case 'too-many-requests':
      return "リクエストが多すぎます。後でもう一度試してください。";
    case 'operation-not-allowed':
      return "ログイン操作が許可されていません。";
    default:
      return "未知のエラーが発生しました。";
  }
}

String getSignUpErrorMessage(String errorMessage) {
  switch (errorMessage) {
    case 'email-already-in-use':
      return "このメールアドレスは既に使用されています。";
    case 'invalid-email':
      return "メールアドレスの形式が正しくありません。";
    case 'operation-not-allowed':
      return "サインアップ操作が許可されていません。";
    case 'weak-password':
      return "パスワードが弱すぎます。";
    default:
      return "サインアップ失敗: 未知のエラーが発生しました。";
  }
}

String getFirestoreErrorMessage(String errorMessage) {
  switch (errorMessage) {
    case 'permission-denied':
      return "アクセス権限がありません。";
    case 'unavailable':
      return "Firestoreが利用できません。";
    default:
      return "未知のエラーが発生しました。";
  }
}
