abstract class IVersion {
  int get major;
  int get minor;
  int get patch;
  int get build;

  String getStoreVersion();
  String getBuildNumber();
}
