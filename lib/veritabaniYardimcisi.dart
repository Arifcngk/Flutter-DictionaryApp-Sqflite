import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeriTabaniYardimcisi {
  static final String veritabaniAdi = "kelimeler.sqlite";
  static Future<Database> veritabaniErisim() async {
    String veritabaniYolu = join(await getDatabasesPath(), veritabaniAdi);
    if (await databaseExists(veritabaniYolu)) {
      //veritabanı var mı yok mu kontrolü
      print("Veritabanı zaten var. Kopyalamaya gerek yok ");
    } else {
      //assetsen veritabanı alınması
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi");
      //veritabanının alınması için byte dönüştürülmesi
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes, flush: true);
      //veritabanı kopyalanması
      print("Veritabanı Kopyalandı");
    }
    //veritabanını açıyoruz
    return openDatabase(veritabaniYolu);
  }
}
