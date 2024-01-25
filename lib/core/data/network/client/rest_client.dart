import 'package:alice/alice.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../config/flavor_config.dart';
import '../../../exception/exception.dart';
import '../../../utils/app_log.dart';
import '../../../utils/helper.dart';
import '../../model/api_response.dart';
import '../helper/headers_utils.dart';

class RestClient {
  late Dio _dio;

  RestClient(String baseURL) {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: const Duration(minutes: 3),
    );
    options.headers.remove(Headers.contentLengthHeader);
    _dio = Dio(options);
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
      Alice alice = Alice(showNotification: true, showInspectorOnShake: true, navigatorKey: MRouter.globalNavigatorKey);
      _dio.interceptors.add(alice.getDioInterceptor());
    }
  }

  Future<Response> get(apiName,
      {body,Map<String, dynamic>? queryParams,Map<String, dynamic>? header, Options? option}) async {
    Map<String, dynamic> headers = await HeadersUtils.getHeaders();

    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "get");
      option.headers = headers;
    }

    try {
      Response response =
          await _dio.request(apiName,queryParameters: queryParams, data: body, options: option);

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      }
      return response;
    } catch (e) {
      if (e is DioError) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(0, 'server_error'.tr);
      }
    }
  }

  Future<Response> post(apiName,
      {body, Map<String, dynamic>? header, Options? option}) async {
    Map<String, dynamic> headers = await HeadersUtils.getHeaders();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "post");
      option.headers = headers;
    }

    try {
      Response response =
          await _dio.request(apiName, data: body, options: option);

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      }
      return response;
    } catch (e) {
      if (e is DioError) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(0, 'server_error'.tr);
      }
    }
  }

  Future<Response> patch(apiName,
      {body, Map<String, dynamic>? header, Options? option}) async {
    Map<String, dynamic> headers = await HeadersUtils.getHeaders();

    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "patch");
      option.headers = headers;
    }

    try {
      Response response =
          await _dio.request(apiName, data: body, options: option);

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      }
      return response;
    } catch (e) {
      if (e is DioError) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(0, 'server_error'.tr);
      }
    }
  }

  Future<Response> put(apiName,
      {body, Map<String, dynamic>? header, Options? option}) async {
    Map<String, dynamic> headers = await HeadersUtils.getHeaders();

    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "put");
      option.headers = headers;
    }

    try {
      Response response =
          await _dio.request(apiName, data: body, options: option);

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      }
      return response;
    } catch (e) {
      if (e is DioError) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(0, 'server_error'.tr);
      }
    }
  }

  Future<Response> delete(apiName,
      {body, Map<String, dynamic>? header, Options? option}) async {
    Map<String, dynamic> headers = await HeadersUtils.getHeaders();

    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "delete");
      option.headers = headers;
    }

    try {
      Response response =
          await _dio.request(apiName, data: body, options: option);

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      }
      return response;
    } catch (e) {
      if (e is DioError) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(0, 'server_error'.tr);
      }
    }
  }

  Future<ApiResponse> downloadFile(
      BuildContext context,
      String savePath,
      String url,
      Function(int received, int total) onReceiveProgressFunction) async {
    try {
      final response = await _dio.download(url, savePath,
          onReceiveProgress: onReceiveProgressFunction);
      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      } else if (response.statusCode == 200) {
        throw ServerException(response.statusCode, response.statusMessage);
      } else {
        throw ServerException(0, 'server_error'.tr);
      }
    } catch (e) {
      if (e is DioError) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(0, 'server_error'.tr);
      }
    }
  }

  void checkExceptionAndDoLogout(DioError e) {
    if (e.response != null &&
        e.response?.data != null) {
      Map<String, dynamic> json = e.response?.data as Map<String, dynamic>;
      if(json['reason'] == 'invalid token or token expired') {
        Helper.doLogout();
      }
    }
  }
}

late RestClient bffRestClient;
late RestClient mockyRestClient;

void init(FlavorConfig flavorConfig) {
  initBFFRestClient(flavorConfig);
  initMockyRestClient(flavorConfig);
}

void initBFFRestClient(FlavorConfig flavorConfig) {
  bffRestClient = RestClient(flavorConfig.bffBaseURL);
}

void initMockyRestClient(FlavorConfig flavorConfig) {
  mockyRestClient = RestClient(flavorConfig.mockyBaseURL);
}
