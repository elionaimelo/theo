class JsonUtils {
  static int? getCountInput(dynamic jsonCount) {
    try {
      if (jsonCount == null) return null;

      return (jsonCount as List<dynamic>).first['count'];
    } catch (err) {
      print('JsonUtils.getCountInput - $err');
      rethrow;
    }
  }
}
