import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/dashboard/domain/domain.dart';
import 'package:klanetmarketers/features/shared/infrastructure/services/s3_service_impl.dart';
import '../mappers/mappers.dart';

class DashboardDatasourceImpl extends DashboardDatasource {
  late final Dio dio;
  final String accessToken;
  final s3Service = S3ServiceImpl();

  DashboardDatasourceImpl({required this.accessToken})
    : dio = Dio(
        BaseOptions(
          baseUrl: Environment.baseUrlMarket,
          headers: {
            'x-api-key': Environment.fireclubKey,
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
  @override
  Future<Balance> getTimeZones() async {
    try {
      final response = await dio.get('/dispersiones/saldo');
      final balance = BalanceMapper.jsonToEntity(response.data);
      return balance;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        throw Exception('Error al obtener las zonas horarias');
      }
      throw Exception('Error al obtener las zonas horarias');
    } catch (e) {
      // print('Error no controlado: $e');
      throw Exception(e.toString());
    }
  }

  @override
  Future<MarketerProfile> getMarketerProfile() async {
    try {
      final response = await dio.get('/dashboard/mkt-profile');
      final marketerProfile = MarketerProfileMapper.jsonToEntity(response.data);
      return marketerProfile;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        throw Exception('Error al obtener el perfil del marketer');
      }
      throw Exception('Error al obtener el perfil del marketer');
    } catch (e) {
      // print('Error no controlado: $e');
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<String>> getBanners() async {
    try {
      final response = await dio.get('/marketers-banners/list');
      final banners = List<Banner>.from(
        response.data['data']['banners'].map(
          (x) => BannerMapper.jsonToEntity(x),
        ),
      );

      final urls = <String>[];
      for (final banner in banners) {
        final signedUrl = await s3Service.requestSignedUrl({
          'method': 'GET',
          'bucket': 'MKT_BANNERS',
          'key': banner.archivoImagen,
          'ttl': 102400,
        });
        urls.add(signedUrl);
      }
      return urls;
    } catch (e, s) {
      print('Error loading banners: $e');
      print('Error loading banners: $s');
      return [];
    }
  }
}
