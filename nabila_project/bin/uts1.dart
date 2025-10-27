// Kelas abstrak Transportasi → jadi induk dari semua jenis transportasi
abstract class Transportasi {
  String id, nama; // ID dan nama transportasi
  double _tarifDasar; // tarif dasar (bersifat private → enkapsulasi)
  int kapasitas; // kapasitas maksimal penumpang

  // Konstruktor
  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

  // Getter untuk mengakses tarif dasar (karena atributnya private)
  double get tarifDasar => _tarifDasar;

  // Method abstrak (belum punya isi) → wajib dioverride di kelas turunan
  double hitungTarif(int jumlahPenumpang);
  void tampilInfo();
}

// ====== KELAS TURUNAN TAKSI ======
class Taksi extends Transportasi {
  double jarak; // atribut tambahan untuk jarak perjalanan (km)

  // Konstruktor Taksi memanggil konstruktor induk (super)
  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
    : super(id, nama, tarifDasar, kapasitas);

  // Override method hitungTarif dari kelas induk (polimorfisme)
  @override
  double hitungTarif(int jumlahPenumpang) => tarifDasar * jarak;

  // Override tampilInfo untuk menampilkan informasi taksi
  @override
  void tampilInfo() => print("Taksi $nama ($jarak km)");
}

// ====== KELAS TURUNAN BUS ======
class Bus extends Transportasi {
  bool adaWifi; // atribut tambahan: apakah bus ada wifi

  Bus(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
    : super(id, nama, tarifDasar, kapasitas);

  // Override hitungTarif: tarif dasar × jumlah penumpang + tambahan jika ada wifi
  @override
  double hitungTarif(int jumlahPenumpang) =>
      (tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);

  // Override tampilInfo untuk menampilkan detail bus
  @override
  void tampilInfo() => print("Bus $nama Wifi: ${adaWifi ? 'Ya' : 'Tidak'}");
}

// ====== KELAS TURUNAN PESAWAT ======
class Pesawat extends Transportasi {
  String kelas; // atribut tambahan: kelas penerbangan (Ekonomi / Bisnis)

  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelas)
    : super(id, nama, tarifDasar, kapasitas);

  // Override hitungTarif dengan rumus sesuai kelas penerbangan
  @override
  double hitungTarif(int jumlahPenumpang) =>
      tarifDasar * jumlahPenumpang * (kelas == "Bisnis" ? 1.5 : 1.0);

  // Override tampilInfo untuk menampilkan info pesawat
  @override
  void tampilInfo() => print("Pesawat $nama ($kelas)");
}

// ====== KELAS PEMESANAN ======
class Pemesanan {
  String idPemesanan, namaPelanggan;
  Transportasi
  transportasi; // objek transportasi (bisa Taksi, Bus, atau Pesawat)
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(
    this.idPemesanan,
    this.namaPelanggan,
    this.transportasi,
    this.jumlahPenumpang,
    this.totalTarif,
  );

  // Menampilkan detail struk pemesanan
  void cetakStruk() {
    print("\n=== Struk Pemesanan ===");
    print("Nama: $namaPelanggan");
    transportasi
        .tampilInfo(); // panggil method tampilInfo dari objek transportasi
    print(
      "Penumpang: $jumlahPenumpang | Total: Rp${totalTarif.toStringAsFixed(0)}",
    );
  }
}

// ====== FUNGSI GLOBAL ======

// Fungsi buatPemesanan → membuat objek Pemesanan dan menghitung total tarif
Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang) =>
    Pemesanan(
      "P-${DateTime.now().millisecondsSinceEpoch}",
      nama,
      t,
      jumlahPenumpang,
      t.hitungTarif(jumlahPenumpang),
    );

// Fungsi tampilSemuaPemesanan → menampilkan semua data pemesanan dari list
void tampilSemuaPemesanan(List<Pemesanan> daftar) =>
    daftar.forEach((p) => p.cetakStruk());

// ====== MAIN PROGRAM ======
void main() {
  // Membuat beberapa objek transportasi
  var t1 = Taksi("T1", "Blue Bird", 8000, 4, 10);
  var b1 = Bus("B1", "TransJakarta", 3000, 30, true);
  var p1 = Pesawat("P1", "Garuda Indonesia", 150000, 150, "Ekonomi");

  // Membuat list pemesanan (simulasi data pelanggan)
  var list = [
    buatPemesanan(t1, "Nabila", 1),
    buatPemesanan(b1, "Leli", 5),
    buatPemesanan(p1, "Jida", 2),
  ];

  // Menampilkan semua pemesanan
  tampilSemuaPemesanan(list);
}
