import 'dart:io';

void main() {
  Map<String, int> makanan = {
    'Nasi Goreng': 20000,
    'Mie Ayam': 18000,
    'Ayam Geprek': 22000,
  };

  Map<String, int> minuman = {
    'Es Teh': 5000,
    'Jus Jeruk': 8000,
    'Kopi Hitam': 7000,
  };

  bool lanjut = true;

  while (lanjut) {
    print("======================================");
    print("        SELAMAT DATANG DI RESTORAN     ");
    print("======================================");
    print("\nMenu Makanan:");
    makanan.forEach((nama, harga) => print(" - $nama : Rp $harga"));
    print("\nMenu Minuman:");
    minuman.forEach((nama, harga) => print(" - $nama : Rp $harga"));

    List<String> pesanan = [];
    int total = 0;

    print("\nMasukkan pesanan Anda (ketik 'selesai' jika sudah):");
    while (true) {
      stdout.write("Pesanan: ");
      String? input = stdin.readLineSync();

      if (input == null) continue;
      if (input.toLowerCase() == 'selesai') break;

      if (makanan.containsKey(input)) {
        total += makanan[input]!;
        pesanan.add(input);
        print("✅ ${input} ditambahkan. Subtotal: Rp $total");
      } else if (minuman.containsKey(input)) {
        total += minuman[input]!;
        pesanan.add(input);
        print("✅ ${input} ditambahkan. Subtotal: Rp $total");
      } else {
        print("⚠️ Menu tidak ditemukan, coba lagi.");
      }
    }

    print("\n===============================");
    print("Pesanan Anda:");
    for (var item in pesanan) {
      print(" - $item");
    }
    print("Total Harga: Rp $total");
    print("===============================");

    stdout.write("Masukkan jumlah uang pembayaran: Rp ");
    int? bayar = int.tryParse(stdin.readLineSync() ?? "0");

    if (bayar == null || bayar < total) {
      print("⚠️ Uang tidak cukup! Pesanan dibatalkan.\n");
    } else {
      int kembalian = bayar - total;
      print("💰 Pembayaran berhasil!");
      print("Kembalian Anda: Rp $kembalian\n");
    }

    stdout.write("Apakah Anda masih ingin memesan lagi? (y/n): ");
    String? jawab = stdin.readLineSync();

    if (jawab == null || jawab.toLowerCase() != 'y') {
      lanjut = false;
      print("\n🍽️ Terima kasih telah berkunjung ke restoran kami!");
    }
  }
}
