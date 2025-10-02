abstract class S3Service {
  Future<String> requestSignedUrl(Map<String, dynamic> params);
  Future<void> uploadFile(String url, List<int> bytes, String mime);
}
