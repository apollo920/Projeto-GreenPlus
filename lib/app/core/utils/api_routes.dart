// ignore_for_file: non_constant_identifier_names

import 'package:greenplus/app/features/eventos/models/eventos.dart';
import '../../features/qrcode/models/qrcode.dart';

class ApiRoutes {
  static String LOGIN({required String username, required String password}) => "/auth";
  static String PERIODO({required String idCurso, required String idPeriodo}) => "/periodos/$idCurso/$idPeriodo";
  static String PERIODOS_BY_CURSO(String idCurso) => "/periodos/$idCurso";
  static String CURSOS = "/cursos";
  static String MENU = "/menu/all";
  static String GETQRCODES({required String idCurso, required String idPeriodo}) => "/qrcodes/$idCurso/$idPeriodo";
  static String ADDQRCODES({required String idCurso, required String idPeriodo, required QrCodeModel qrCodeModel}) => "/qrcodes/register/$idCurso/$idPeriodo";
  static String DELETEQRCODES({required String idCurso, required String idPeriodo,required int idQrcode}) => "/qrcodes/$idCurso/$idPeriodo";
  static String GETEVENTOS({required String idCurso}) => "/eventos/$idCurso";
  static String GETALLEVENTOS = "/eventos/all";
  static String ADDEVENTOS({required String idCurso, required EventoModel eventoModel}) => "/eventos/register/$idCurso";
  static String DELETEEVENTOS({required String idCurso, required int idEvento}) => "/eventos/delete/$idCurso/$idEvento";
  static String GETHORARIOS({required String idCurso}) => "/horarios/$idCurso";
  static String CHANGEHORARIOS({required String idCurso, required String base64}) => "/horarios/$idCurso";
}