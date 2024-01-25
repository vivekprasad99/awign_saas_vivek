import 'core/config/flavor_config.dart';
import 'core/utils/constants.dart';
import 'main_common.dart';

const bffBaseURL = 'https://bff-api.awigndev.com/';
const mockyBaseURL = 'https://09ba8a6d-4f26-474e-9ef8-574eeea3f400.mock.pstmn.io/';
const s3bucketName = 'awign-staging';
const s3FolderPath = 'hrms';

void main() {
  FlavorConfig flavorConfig = FlavorConfig(
    appName: '${Constants.appName} Dev',
    appFlavor: AppFlavor.development,
    bffBaseURL: bffBaseURL,
    mockyBaseURL: mockyBaseURL,
    s3bucketName: s3bucketName,
    s3FolderPath: s3FolderPath,
  );
  mainCommon(flavorConfig);
}
