import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ppkd_b6/day_35/models/auth_response.dart';
import 'package:ppkd_b6/day_35/models/profile_response.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: 'https://absensib1.mobileprojp.com')
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  // POST /api/register
  // Body: { "name": String, "email": String, "password": String }
  @POST('/api/register')
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  // POST /api/login
  // Body: { "email": String, "password": String }
  @POST('/api/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  // GET /api/profile
  // Requires Bearer Token (handled by DioClient interceptor)
  @GET('/api/profile')
  Future<ProfileResponse> getProfile();

  // PUT /api/profile
  // Body: { "name": String }
  // Requires Bearer Token (handled by DioClient interceptor)
  @PUT('/api/profile')
  Future<ProfileResponse> updateProfile(@Body() Map<String, dynamic> body);
}
