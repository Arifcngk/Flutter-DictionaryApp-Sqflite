import 'package:sozluk_app_sqlite/veritabaniYardimcisi.dart';

import 'Kelimeler.dart';

class Kelimelerdao {
  Future<List<Kelimeler>> tumKelimeler() async {
    var db = await VeriTabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM kelimeler ORDER BY kelime_id ASC");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kelimeler(
          satir["kelime_id"], satir["ingilizce"], satir["ingilizce"]);
    });
  }

  Future<List<Kelimeler>> kelimeAra(String aramaKelime) async {
    var db = await VeriTabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM kelimeler WHERE ingilizce LIKE '%$aramaKelime%' OR turkce LIKE '%$aramaKelime%'");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }
}
