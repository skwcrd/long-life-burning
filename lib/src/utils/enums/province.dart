part of util;

enum ProvinceType {
  All,
  Bangkok,
  AmnatCharoen,
  AngThong,
  BuengKan,
  Buriram,
  Chachoengsao,
  ChaiNat,
  Chaiyaphum,
  Chanthaburi,
  ChiangMai,
  ChiangRai,
  Chonburi,
  Chumphon,
  Kalasin,
  KamphaengPhet,
  Kanchanaburi,
  KhonKaen,
  Krabi,
  Lampang,
  Lamphun,
  Loei,
  Lopburi,
  MaeHongSon,
  MahaSarakham,
  Mukdahan,
  NakhonNayok,
  NakhonPathom,
  NakhonPhanom,
  NakhonRatchasima,
  NakhonSawan,
  NakhonSiThammarat,
  Nan,
  Narathiwat,
  NongBuaLamphu,
  NongKhai,
  Nonthaburi,
  PathumThani,
  Pattani,
  PhangNga,
  Phatthalung,
  Phayao,
  Phetchabun,
  Phetchaburi,
  Phichit,
  Phitsanulok,
  PhraNakhonSiAyutthaya,
  Phrae,
  Phuket,
  Prachinburi,
  PrachuapKhiriKhan,
  Ranong,
  Ratchaburi,
  Rayong,
  RoiEt,
  SaKaeo,
  SakonNakhon,
  SamutPrakan,
  SamutSakhon,
  SamutSongkhram,
  Saraburi,
  Satun,
  SingBuri,
  Sisaket,
  Songkhla,
  Sukhothai,
  SuphanBuri,
  SuratThani,
  Surin,
  Tak,
  Trang,
  Trat,
  UbonRatchathani,
  UdonThani,
  UthaiThani,
  Uttaradit,
  Yala,
  Yasothon,
}

extension ProvinceTypeDescription on ProvinceType {
  String get value {
    switch (this) {
      case ProvinceType.All:
        return 'all';

      case ProvinceType.Bangkok:
        return 'bangkok';

      case ProvinceType.AmnatCharoen:
        return 'amnat-charoen';

      case ProvinceType.AngThong:
        return 'ang-thong';

      case ProvinceType.BuengKan:
        return 'bueng-kan';

      case ProvinceType.Buriram:
        return 'buriram';

      case ProvinceType.Chachoengsao:
        return 'chachoengsao';

      case ProvinceType.ChaiNat:
        return 'chai-nat';

      case ProvinceType.Chaiyaphum:
        return 'chaiyaphum';

      case ProvinceType.Chanthaburi:
        return 'chanthaburi';

      case ProvinceType.ChiangMai:
        return 'chiang-mai';

      case ProvinceType.ChiangRai:
        return 'chiang-rai';

      case ProvinceType.Chonburi:
        return 'chonburi';

      case ProvinceType.Chumphon:
        return 'chumphon';

      case ProvinceType.Kalasin:
        return 'kalasin';

      case ProvinceType.KamphaengPhet:
        return 'kamphaeng-phet';

      case ProvinceType.Kanchanaburi:
        return 'kanchanaburi';

      case ProvinceType.KhonKaen:
        return 'khon-kaen';

      case ProvinceType.Krabi:
        return 'krabi';

      case ProvinceType.Lampang:
        return 'lampang';

      case ProvinceType.Lamphun:
        return 'lamphun';

      case ProvinceType.Loei:
        return 'loei';

      case ProvinceType.Lopburi:
        return 'lopburi';

      case ProvinceType.MaeHongSon:
        return 'mae-hong-son';

      case ProvinceType.MahaSarakham:
        return 'maha-sarakham';

      case ProvinceType.Mukdahan:
        return 'mukdahan';

      case ProvinceType.NakhonNayok:
        return 'nakhon-nayok';

      case ProvinceType.NakhonPathom:
        return 'nakhon-pathom';

      case ProvinceType.NakhonPhanom:
        return 'nakhon-phanom';

      case ProvinceType.NakhonRatchasima:
        return 'nakhon-ratchasima';

      case ProvinceType.NakhonSawan:
        return 'nakhon-sawan';

      case ProvinceType.NakhonSiThammarat:
        return 'nakhon-si-thammarat';

      case ProvinceType.Nan:
        return 'nan';

      case ProvinceType.Narathiwat:
        return 'narathiwat';

      case ProvinceType.NongBuaLamphu:
        return 'nong-bua-lamphu';

      case ProvinceType.NongKhai:
        return 'nong-khai';

      case ProvinceType.Nonthaburi:
        return 'nonthaburi';

      case ProvinceType.PathumThani:
        return 'pathum-thani';

      case ProvinceType.Pattani:
        return 'pattani';

      case ProvinceType.PhangNga:
        return 'phang-nga';

      case ProvinceType.Phatthalung:
        return 'phatthalung';

      case ProvinceType.Phayao:
        return 'phayao';

      case ProvinceType.Phetchabun:
        return 'phetchabun';

      case ProvinceType.Phetchaburi:
        return 'phetchaburi';

      case ProvinceType.Phichit:
        return 'phichit';

      case ProvinceType.Phitsanulok:
        return 'phitsanulok';

      case ProvinceType.PhraNakhonSiAyutthaya:
        return 'phra-nakhon-si-ayutthaya';

      case ProvinceType.Phrae:
        return 'phrae';

      case ProvinceType.Phuket:
        return 'phuket';

      case ProvinceType.Prachinburi:
        return 'prachinburi';

      case ProvinceType.PrachuapKhiriKhan:
        return 'prachuap-khiri-khan';

      case ProvinceType.Ranong:
        return 'ranong';

      case ProvinceType.Ratchaburi:
        return 'ratchaburi';

      case ProvinceType.Rayong:
        return 'rayong';

      case ProvinceType.RoiEt:
        return 'roi-et';

      case ProvinceType.SaKaeo:
        return 'sa-kaeo';

      case ProvinceType.SakonNakhon:
        return 'sakon-nakhon';

      case ProvinceType.SamutPrakan:
        return 'samut-prakan';

      case ProvinceType.SamutSakhon:
        return 'samut-sakhon';

      case ProvinceType.SamutSongkhram:
        return 'samut-songkhram';

      case ProvinceType.Saraburi:
        return 'saraburi';

      case ProvinceType.Satun:
        return 'satun';

      case ProvinceType.SingBuri:
        return 'sing-buri';

      case ProvinceType.Sisaket:
        return 'sisaket';

      case ProvinceType.Songkhla:
        return 'songkhla';

      case ProvinceType.Sukhothai:
        return 'sukhothai';

      case ProvinceType.SuphanBuri:
        return 'suphan-buri';

      case ProvinceType.SuratThani:
        return 'surat-thani';

      case ProvinceType.Surin:
        return 'surin';

      case ProvinceType.Tak:
        return 'tak';

      case ProvinceType.Trang:
        return 'trang';

      case ProvinceType.Trat:
        return 'trat';

      case ProvinceType.UbonRatchathani:
        return 'ubon-ratchathani';

      case ProvinceType.UdonThani:
        return 'udon-thani';

      case ProvinceType.UthaiThani:
        return 'uthai-thani';

      case ProvinceType.Uttaradit:
        return 'uttaradit';

      case ProvinceType.Yala:
        return 'yala';

      case ProvinceType.Yasothon:
        return 'yasothon';

      default:
        return 'unknown';
    }
  }

  String get text {
    switch (this) {
      case ProvinceType.All:
        return 'All Provinces';

      case ProvinceType.Bangkok:
        return 'Bangkok';

      case ProvinceType.AmnatCharoen:
        return 'Amnat Charoen';

      case ProvinceType.AngThong:
        return 'Ang Thong';

      case ProvinceType.BuengKan:
        return 'Bueng Kan';

      case ProvinceType.Buriram:
        return 'Buriram';

      case ProvinceType.Chachoengsao:
        return 'Chachoengsao';

      case ProvinceType.ChaiNat:
        return 'Chai Nat';

      case ProvinceType.Chaiyaphum:
        return 'Chaiyaphum';

      case ProvinceType.Chanthaburi:
        return 'Chanthaburi';

      case ProvinceType.ChiangMai:
        return 'Chiang Mai';

      case ProvinceType.ChiangRai:
        return 'Chiang Rai';

      case ProvinceType.Chonburi:
        return 'Chonburi';

      case ProvinceType.Chumphon:
        return 'Chumphon';

      case ProvinceType.Kalasin:
        return 'Kalasin';

      case ProvinceType.KamphaengPhet:
        return 'Kamphaeng Phet';

      case ProvinceType.Kanchanaburi:
        return 'Kanchanaburi';

      case ProvinceType.KhonKaen:
        return 'Khon Kaen';

      case ProvinceType.Krabi:
        return 'Krabi';

      case ProvinceType.Lampang:
        return 'Lampang';

      case ProvinceType.Lamphun:
        return 'Lamphun';

      case ProvinceType.Loei:
        return 'Loei';

      case ProvinceType.Lopburi:
        return 'Lopburi';

      case ProvinceType.MaeHongSon:
        return 'Mae Hong Son';

      case ProvinceType.MahaSarakham:
        return 'Maha Sarakham';

      case ProvinceType.Mukdahan:
        return 'Mukdahan';

      case ProvinceType.NakhonNayok:
        return 'Nakhon Nayok';

      case ProvinceType.NakhonPathom:
        return 'Nakhon Pathom';

      case ProvinceType.NakhonPhanom:
        return 'Nakhon Phanom';

      case ProvinceType.NakhonRatchasima:
        return 'Nakhon Ratchasima';

      case ProvinceType.NakhonSawan:
        return 'Nakhon Sawan';

      case ProvinceType.NakhonSiThammarat:
        return 'Nakhon Si Thammarat';

      case ProvinceType.Nan:
        return 'Nan';

      case ProvinceType.Narathiwat:
        return 'Narathiwat';

      case ProvinceType.NongBuaLamphu:
        return 'Nong Bua Lamphu';

      case ProvinceType.NongKhai:
        return 'Nong Khai';

      case ProvinceType.Nonthaburi:
        return 'Nonthaburi';

      case ProvinceType.PathumThani:
        return 'Pathum Thani';

      case ProvinceType.Pattani:
        return 'Pattani';

      case ProvinceType.PhangNga:
        return 'Phang Nga';

      case ProvinceType.Phatthalung:
        return 'Phatthalung';

      case ProvinceType.Phayao:
        return 'Phayao';

      case ProvinceType.Phetchabun:
        return 'Phetchabun';

      case ProvinceType.Phetchaburi:
        return 'Phetchaburi';

      case ProvinceType.Phichit:
        return 'Phichit';

      case ProvinceType.Phitsanulok:
        return 'Phitsanulok';

      case ProvinceType.PhraNakhonSiAyutthaya:
        return 'Phra Nakhon Si Ayutthaya';

      case ProvinceType.Phrae:
        return 'Phrae';

      case ProvinceType.Phuket:
        return 'Phuket';

      case ProvinceType.Prachinburi:
        return 'Prachinburi';

      case ProvinceType.PrachuapKhiriKhan:
        return 'Prachuap Khiri Khan';

      case ProvinceType.Ranong:
        return 'Ranong';

      case ProvinceType.Ratchaburi:
        return 'Ratchaburi';

      case ProvinceType.Rayong:
        return 'Rayong';

      case ProvinceType.RoiEt:
        return 'Roi Et';

      case ProvinceType.SaKaeo:
        return 'Sa Kaeo';

      case ProvinceType.SakonNakhon:
        return 'Sakon Nakhon';

      case ProvinceType.SamutPrakan:
        return 'Samut Prakan';

      case ProvinceType.SamutSakhon:
        return 'Samut Sakhon';

      case ProvinceType.SamutSongkhram:
        return 'Samut Songkhram';

      case ProvinceType.Saraburi:
        return 'Saraburi';

      case ProvinceType.Satun:
        return 'Satun';

      case ProvinceType.SingBuri:
        return 'Sing Buri';

      case ProvinceType.Sisaket:
        return 'Sisaket';

      case ProvinceType.Songkhla:
        return 'Songkhla';

      case ProvinceType.Sukhothai:
        return 'Sukhothai';

      case ProvinceType.SuphanBuri:
        return 'Suphan Buri';

      case ProvinceType.SuratThani:
        return 'Surat Thani';

      case ProvinceType.Surin:
        return 'Surin';

      case ProvinceType.Tak:
        return 'Tak';

      case ProvinceType.Trang:
        return 'Trang';

      case ProvinceType.Trat:
        return 'Trat';

      case ProvinceType.UbonRatchathani:
        return 'Ubon Ratchathani';

      case ProvinceType.UdonThani:
        return 'Udon Thani';

      case ProvinceType.UthaiThani:
        return 'Uthai Thani';

      case ProvinceType.Uttaradit:
        return 'Uttaradit';

      case ProvinceType.Yala:
        return 'Yala';

      case ProvinceType.Yasothon:
        return 'Yasothon';

      default:
        return 'unknown';
    }
  }

  String get th {
    switch (this) {
      case ProvinceType.All:
        return 'ทุกจังหวัด';

      case ProvinceType.Bangkok:
        return 'กรุงเทพมหานคร';

      case ProvinceType.AmnatCharoen:
        return 'อำนาจเจริญ';

      case ProvinceType.AngThong:
        return 'อ่างทอง';

      case ProvinceType.BuengKan:
        return 'บึงกาฬ';

      case ProvinceType.Buriram:
        return 'บุรีรัมย์';

      case ProvinceType.Chachoengsao:
        return 'ฉะเชิงเทรา';

      case ProvinceType.ChaiNat:
        return 'ชัยนาท';

      case ProvinceType.Chaiyaphum:
        return 'ชัยภูมิ';

      case ProvinceType.Chanthaburi:
        return 'จันทบุรี';

      case ProvinceType.ChiangMai:
        return 'เชียงใหม่';

      case ProvinceType.ChiangRai:
        return 'เชียงราย';

      case ProvinceType.Chonburi:
        return 'ชลบุรี';

      case ProvinceType.Chumphon:
        return 'ชุมพร';

      case ProvinceType.Kalasin:
        return 'กาฬสินธุ์';

      case ProvinceType.KamphaengPhet:
        return 'กำแพงเพชร';

      case ProvinceType.Kanchanaburi:
        return 'กาญจนบุรี';

      case ProvinceType.KhonKaen:
        return 'ขอนแก่น';

      case ProvinceType.Krabi:
        return 'กระบี่';

      case ProvinceType.Lampang:
        return 'ลำปาง';

      case ProvinceType.Lamphun:
        return 'ลำพูน';

      case ProvinceType.Loei:
        return 'เลย';

      case ProvinceType.Lopburi:
        return 'ลพบุรี';

      case ProvinceType.MaeHongSon:
        return 'แม่ฮ่องสอน';

      case ProvinceType.MahaSarakham:
        return 'มหาสารคาม';

      case ProvinceType.Mukdahan:
        return 'มุกดาหาร';

      case ProvinceType.NakhonNayok:
        return 'นครนายก';

      case ProvinceType.NakhonPathom:
        return 'นครปฐม';

      case ProvinceType.NakhonPhanom:
        return 'นครพนม';

      case ProvinceType.NakhonRatchasima:
        return 'นครราชสีมา';

      case ProvinceType.NakhonSawan:
        return 'นครสวรรค์';

      case ProvinceType.NakhonSiThammarat:
        return 'นครศรีธรรมราช';

      case ProvinceType.Nan:
        return 'น่าน';

      case ProvinceType.Narathiwat:
        return 'นราธิวาส';

      case ProvinceType.NongBuaLamphu:
        return 'หนองบัวลำภู';

      case ProvinceType.NongKhai:
        return 'หนองคาย';

      case ProvinceType.Nonthaburi:
        return 'นนทบุรี';

      case ProvinceType.PathumThani:
        return 'ปทุมธานี';

      case ProvinceType.Pattani:
        return 'ปัตตานี';

      case ProvinceType.PhangNga:
        return 'พังงา';

      case ProvinceType.Phatthalung:
        return 'พัทลุง';

      case ProvinceType.Phayao:
        return 'พะเยา';

      case ProvinceType.Phetchabun:
        return 'เพชรบูรณ์';

      case ProvinceType.Phetchaburi:
        return 'เพชรบุรี';

      case ProvinceType.Phichit:
        return 'พิจิตร';

      case ProvinceType.Phitsanulok:
        return 'พิษณุโลก';

      case ProvinceType.PhraNakhonSiAyutthaya:
        return 'พระนครศรีอยุธยา';

      case ProvinceType.Phrae:
        return 'แพร่';

      case ProvinceType.Phuket:
        return 'ภูเก็ต';

      case ProvinceType.Prachinburi:
        return 'ปราจีนบุรี';

      case ProvinceType.PrachuapKhiriKhan:
        return 'ประจวบคีรีขันธ์';

      case ProvinceType.Ranong:
        return 'ระนอง';

      case ProvinceType.Ratchaburi:
        return 'ราชบุรี';

      case ProvinceType.Rayong:
        return 'ระยอง';

      case ProvinceType.RoiEt:
        return 'ร้อยเอ็ด';

      case ProvinceType.SaKaeo:
        return 'สระแก้ว';

      case ProvinceType.SakonNakhon:
        return 'สกลนคร';

      case ProvinceType.SamutPrakan:
        return 'สมุทรปราการ';

      case ProvinceType.SamutSakhon:
        return 'สมุทรสาคร';

      case ProvinceType.SamutSongkhram:
        return 'สมุทรสงคราม';

      case ProvinceType.Saraburi:
        return 'สระบุรี';

      case ProvinceType.Satun:
        return 'สตูล';

      case ProvinceType.SingBuri:
        return 'สิงห์บุรี';

      case ProvinceType.Sisaket:
        return 'ศรีสะเกษ';

      case ProvinceType.Songkhla:
        return 'สงขลา';

      case ProvinceType.Sukhothai:
        return 'สุโขทัย';

      case ProvinceType.SuphanBuri:
        return 'สุพรรณบุรี';

      case ProvinceType.SuratThani:
        return 'สุราษฎร์ธานี';

      case ProvinceType.Surin:
        return 'สุรินทร์';

      case ProvinceType.Tak:
        return 'ตาก';

      case ProvinceType.Trang:
        return 'ตรัง';

      case ProvinceType.Trat:
        return 'ตราด';

      case ProvinceType.UbonRatchathani:
        return 'อุบลราชธานี';

      case ProvinceType.UdonThani:
        return 'อุดรธานี';

      case ProvinceType.UthaiThani:
        return 'อุทัยธานี';

      case ProvinceType.Uttaradit:
        return 'อุตรดิตถ์';

      case ProvinceType.Yala:
        return 'ยะลา';

      case ProvinceType.Yasothon:
        return 'ยโสธร';

      default:
        return 'unknown';
    }
  }
}

extension ProvinceTypeCompare on ProvinceType {
  bool get isAll =>
      this == ProvinceType.All;
  bool get isBangkok =>
      this == ProvinceType.Bangkok;
  bool get isAmnatCharoen =>
      this == ProvinceType.AmnatCharoen;
  bool get isAngThong =>
      this == ProvinceType.AngThong;
  bool get isBuengKan =>
      this == ProvinceType.BuengKan;
  bool get isBuriram =>
      this == ProvinceType.Buriram;
  bool get isChachoengsao =>
      this == ProvinceType.Chachoengsao;
  bool get isChaiNat =>
      this == ProvinceType.ChaiNat;
  bool get isChaiyaphum =>
      this == ProvinceType.Chaiyaphum;
  bool get isChanthaburi =>
      this == ProvinceType.Chanthaburi;
  bool get isChiangMai =>
      this == ProvinceType.ChiangMai;
  bool get isChiangRai =>
      this == ProvinceType.ChiangRai;
  bool get isChonburi =>
      this == ProvinceType.Chonburi;
  bool get isChumphon =>
      this == ProvinceType.Chumphon;
  bool get isKalasin =>
      this == ProvinceType.Kalasin;
  bool get isKamphaengPhet =>
      this == ProvinceType.KamphaengPhet;
  bool get isKanchanaburi =>
      this == ProvinceType.Kanchanaburi;
  bool get isKhonKaen =>
      this == ProvinceType.KhonKaen;
  bool get isKrabi =>
      this == ProvinceType.Krabi;
  bool get isLampang =>
      this == ProvinceType.Lampang;
  bool get isLamphun =>
      this == ProvinceType.Lamphun;
  bool get isLoei =>
      this == ProvinceType.Loei;
  bool get isLopburi =>
      this == ProvinceType.Lopburi;
  bool get isMaeHongSon =>
      this == ProvinceType.MaeHongSon;
  bool get isMahaSarakham =>
      this == ProvinceType.MahaSarakham;
  bool get isMukdahan =>
      this == ProvinceType.Mukdahan;
  bool get isNakhonNayok =>
      this == ProvinceType.NakhonNayok;
  bool get isNakhonPathom =>
      this == ProvinceType.NakhonPathom;
  bool get isNakhonPhanom =>
      this == ProvinceType.NakhonPhanom;
  bool get isNakhonRatchasima =>
      this == ProvinceType.NakhonRatchasima;
  bool get isNakhonSawan =>
      this == ProvinceType.NakhonSawan;
  bool get isNakhonSiThammarat =>
      this == ProvinceType.NakhonSiThammarat;
  bool get isNan =>
      this == ProvinceType.Nan;
  bool get isNarathiwat =>
      this == ProvinceType.Narathiwat;
  bool get isNongBuaLamphu =>
      this == ProvinceType.NongBuaLamphu;
  bool get isNongKhai =>
      this == ProvinceType.NongKhai;
  bool get isNonthaburi =>
      this == ProvinceType.Nonthaburi;
  bool get isPathumThani =>
      this == ProvinceType.PathumThani;
  bool get isPattani =>
      this == ProvinceType.Pattani;
  bool get isPhangNga =>
      this == ProvinceType.PhangNga;
  bool get isPhatthalung =>
      this == ProvinceType.Phatthalung;
  bool get isPhayao =>
      this == ProvinceType.Phayao;
  bool get isPhetchabun =>
      this == ProvinceType.Phetchabun;
  bool get isPhetchaburi =>
      this == ProvinceType.Phetchaburi;
  bool get isPhichit =>
      this == ProvinceType.Phichit;
  bool get isPhitsanulok =>
      this == ProvinceType.Phitsanulok;
  bool get isPhraNakhonSiAyutthaya =>
      this == ProvinceType.PhraNakhonSiAyutthaya;
  bool get isPhrae =>
      this == ProvinceType.Phrae;
  bool get isPhuket =>
      this == ProvinceType.Phuket;
  bool get isPrachinburi =>
      this == ProvinceType.Prachinburi;
  bool get isPrachuapKhiriKhan =>
      this == ProvinceType.PrachuapKhiriKhan;
  bool get isRanong =>
      this == ProvinceType.Ranong;
  bool get isRatchaburi =>
      this == ProvinceType.Ratchaburi;
  bool get isRayong =>
      this == ProvinceType.Rayong;
  bool get isRoiEt =>
      this == ProvinceType.RoiEt;
  bool get isSaKaeo =>
      this == ProvinceType.SaKaeo;
  bool get isSakonNakhon =>
      this == ProvinceType.SakonNakhon;
  bool get isSamutPrakan =>
      this == ProvinceType.SamutPrakan;
  bool get isSamutSakhon =>
      this == ProvinceType.SamutSakhon;
  bool get isSamutSongkhram =>
      this == ProvinceType.SamutSongkhram;
  bool get isSaraburi =>
      this == ProvinceType.Saraburi;
  bool get isSatun =>
      this == ProvinceType.Satun;
  bool get isSingBuri =>
      this == ProvinceType.SingBuri;
  bool get isSisaket =>
      this == ProvinceType.Sisaket;
  bool get isSongkhla =>
      this == ProvinceType.Songkhla;
  bool get isSukhothai =>
      this == ProvinceType.Sukhothai;
  bool get isSuphanBuri =>
      this == ProvinceType.SuphanBuri;
  bool get isSuratThani =>
      this == ProvinceType.SuratThani;
  bool get isSurin =>
      this == ProvinceType.Surin;
  bool get isTak =>
      this == ProvinceType.Tak;
  bool get isTrang =>
      this == ProvinceType.Trang;
  bool get isTrat =>
      this == ProvinceType.Trat;
  bool get isUbonRatchathani =>
      this == ProvinceType.UbonRatchathani;
  bool get isUdonThani =>
      this == ProvinceType.UdonThani;
  bool get isUthaiThani =>
      this == ProvinceType.UthaiThani;
  bool get isUttaradit =>
      this == ProvinceType.Uttaradit;
  bool get isYala =>
      this == ProvinceType.Yala;
  bool get isYasothon =>
      this == ProvinceType.Yasothon;

  bool get isNotAll =>
      this != ProvinceType.All;
  bool get isNotBangkok =>
      this != ProvinceType.Bangkok;
  bool get isNotAmnatCharoen =>
      this != ProvinceType.AmnatCharoen;
  bool get isNotAngThong =>
      this != ProvinceType.AngThong;
  bool get isNotBuengKan =>
      this != ProvinceType.BuengKan;
  bool get isNotBuriram =>
      this != ProvinceType.Buriram;
  bool get isNotChachoengsao =>
      this != ProvinceType.Chachoengsao;
  bool get isNotChaiNat =>
      this != ProvinceType.ChaiNat;
  bool get isNotChaiyaphum =>
      this != ProvinceType.Chaiyaphum;
  bool get isNotChanthaburi =>
      this != ProvinceType.Chanthaburi;
  bool get isNotChiangMai =>
      this != ProvinceType.ChiangMai;
  bool get isNotChiangRai =>
      this != ProvinceType.ChiangRai;
  bool get isNotChonburi =>
      this != ProvinceType.Chonburi;
  bool get isNotChumphon =>
      this != ProvinceType.Chumphon;
  bool get isNotKalasin =>
      this != ProvinceType.Kalasin;
  bool get isNotKamphaengPhet =>
      this != ProvinceType.KamphaengPhet;
  bool get isNotKanchanaburi =>
      this != ProvinceType.Kanchanaburi;
  bool get isNotKhonKaen =>
      this != ProvinceType.KhonKaen;
  bool get isNotKrabi =>
      this != ProvinceType.Krabi;
  bool get isNotLampang =>
      this != ProvinceType.Lampang;
  bool get isNotLamphun =>
      this != ProvinceType.Lamphun;
  bool get isNotLoei =>
      this != ProvinceType.Loei;
  bool get isNotLopburi =>
      this != ProvinceType.Lopburi;
  bool get isNotMaeHongSon =>
      this != ProvinceType.MaeHongSon;
  bool get isNotMahaSarakham =>
      this != ProvinceType.MahaSarakham;
  bool get isNotMukdahan =>
      this != ProvinceType.Mukdahan;
  bool get isNotNakhonNayok =>
      this != ProvinceType.NakhonNayok;
  bool get isNotNakhonPathom =>
      this != ProvinceType.NakhonPathom;
  bool get isNotNakhonPhanom =>
      this != ProvinceType.NakhonPhanom;
  bool get isNotNakhonRatchasima =>
      this != ProvinceType.NakhonRatchasima;
  bool get isNotNakhonSawan =>
      this != ProvinceType.NakhonSawan;
  bool get isNotNakhonSiThammarat =>
      this != ProvinceType.NakhonSiThammarat;
  bool get isNotNan =>
      this != ProvinceType.Nan;
  bool get isNotNarathiwat =>
      this != ProvinceType.Narathiwat;
  bool get isNotNongBuaLamphu =>
      this != ProvinceType.NongBuaLamphu;
  bool get isNotNongKhai =>
      this != ProvinceType.NongKhai;
  bool get isNotNonthaburi =>
      this != ProvinceType.Nonthaburi;
  bool get isNotPathumThani =>
      this != ProvinceType.PathumThani;
  bool get isNotPattani =>
      this != ProvinceType.Pattani;
  bool get isNotPhangNga =>
      this != ProvinceType.PhangNga;
  bool get isNotPhatthalung =>
      this != ProvinceType.Phatthalung;
  bool get isNotPhayao =>
      this != ProvinceType.Phayao;
  bool get isNotPhetchabun =>
      this != ProvinceType.Phetchabun;
  bool get isNotPhetchaburi =>
      this != ProvinceType.Phetchaburi;
  bool get isNotPhichit =>
      this != ProvinceType.Phichit;
  bool get isNotPhitsanulok =>
      this != ProvinceType.Phitsanulok;
  bool get isNotPhraNakhonSiAyutthaya =>
      this != ProvinceType.PhraNakhonSiAyutthaya;
  bool get isNotPhrae =>
      this != ProvinceType.Phrae;
  bool get isNotPhuket =>
      this != ProvinceType.Phuket;
  bool get isNotPrachinburi =>
      this != ProvinceType.Prachinburi;
  bool get isNotPrachuapKhiriKhan =>
      this != ProvinceType.PrachuapKhiriKhan;
  bool get isNotRanong =>
      this != ProvinceType.Ranong;
  bool get isNotRatchaburi =>
      this != ProvinceType.Ratchaburi;
  bool get isNotRayong =>
      this != ProvinceType.Rayong;
  bool get isNotRoiEt =>
      this != ProvinceType.RoiEt;
  bool get isNotSaKaeo =>
      this != ProvinceType.SaKaeo;
  bool get isNotSakonNakhon =>
      this != ProvinceType.SakonNakhon;
  bool get isNotSamutPrakan =>
      this != ProvinceType.SamutPrakan;
  bool get isNotSamutSakhon =>
      this != ProvinceType.SamutSakhon;
  bool get isNotSamutSongkhram =>
      this != ProvinceType.SamutSongkhram;
  bool get isNotSaraburi =>
      this != ProvinceType.Saraburi;
  bool get isNotSatun =>
      this != ProvinceType.Satun;
  bool get isNotSingBuri =>
      this != ProvinceType.SingBuri;
  bool get isNotSisaket =>
      this != ProvinceType.Sisaket;
  bool get isNotSongkhla =>
      this != ProvinceType.Songkhla;
  bool get isNotSukhothai =>
      this != ProvinceType.Sukhothai;
  bool get isNotSuphanBuri =>
      this != ProvinceType.SuphanBuri;
  bool get isNotSuratThani =>
      this != ProvinceType.SuratThani;
  bool get isNotSurin =>
      this != ProvinceType.Surin;
  bool get isNotTak =>
      this != ProvinceType.Tak;
  bool get isNotTrang =>
      this != ProvinceType.Trang;
  bool get isNotTrat =>
      this != ProvinceType.Trat;
  bool get isNotUbonRatchathani =>
      this != ProvinceType.UbonRatchathani;
  bool get isNotUdonThani =>
      this != ProvinceType.UdonThani;
  bool get isNotUthaiThani =>
      this != ProvinceType.UthaiThani;
  bool get isNotUttaradit =>
      this != ProvinceType.Uttaradit;
  bool get isNotYala =>
      this != ProvinceType.Yala;
  bool get isNotYasothon =>
      this != ProvinceType.Yasothon;
}