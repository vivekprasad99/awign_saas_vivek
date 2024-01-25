import 'core/config/flavor_config.dart';
import 'core/utils/constants.dart';
import 'main_common.dart';

const mockyBaseURL = 'https://09ba8a6d-4f26-474e-9ef8-574eeea3f400.mock.pstmn.io/';
const bffBaseURL = 'https://bff-api.awign.com/';
const s3bucketName = 'awign-saas-public';
const s3FolderPath = 'hrms';

void main() {
  FlavorConfig flavorConfig = FlavorConfig(
    appName: Constants.appName,
    appFlavor: AppFlavor.production,
    bffBaseURL: bffBaseURL,
    mockyBaseURL: mockyBaseURL,
    s3bucketName: s3bucketName,
    s3FolderPath: s3FolderPath,
  );
  mainCommon(flavorConfig);
}
