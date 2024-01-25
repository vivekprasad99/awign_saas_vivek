enum AppFlavor {
  development,
  staging,
  production,
}

class FlavorConfig {
  final String appName;
  final AppFlavor appFlavor;
  final String bffBaseURL;
  final String mockyBaseURL;
  final String s3bucketName;
  final String s3FolderPath;

  FlavorConfig({
    required this.appName,
    required this.appFlavor,
    required this.bffBaseURL,
    required this.mockyBaseURL,
    required this.s3bucketName,
    required this.s3FolderPath,
  });
}
