import 'dart:io';
bool laSoHopLe(int input) => input >=0;

bool kiemTraTenCoHopLeKhong(String name) => RegExp(r'^[a-zA-Z\s]+$').hasMatch(name);

void themSanPham(List dssp)
{
  int giaTien = 0, soLuong = 0;
  String tenSanPham = "";

  print("Ten san pham");
  while(true)
  {
    tenSanPham = stdin.readLineSync()!.replaceAll(RegExp(r'\s+'), ' ').trim().toLowerCase();
    if(kiemTraTenCoHopLeKhong(tenSanPham))
      break;
    else
      print("Ten khong hop le. Vui long nhap lai");
  }

  print("Gia tien");
  while(true)
  {
    giaTien = int.tryParse(stdin.readLineSync() ?? "") ?? -1;
    if(laSoHopLe(giaTien))
      break;
    else
      print("Ban vua nhap khong phai la so. Vui long nhap lai.");
  }

  print("So luong");
  while(true)
  {
    soLuong = int.tryParse(stdin.readLineSync() ?? "") ?? -1;
    if(laSoHopLe(soLuong))
      break;
    else
      print("Ban vua nhap khong phai la so. Vui long nhap lai.");
  }

  if(dssp.isNotEmpty)
  {
    var kiemTraSanPham = dssp.firstWhere((e) => e['tenSanPham'] == tenSanPham && e['giaTien'] == giaTien, orElse: () => <String, dynamic>{});
  
    if (kiemTraSanPham.isNotEmpty)
    {
      kiemTraSanPham['soLuong'] += soLuong;
    }
    else
    {
      dssp.add(
        { 'tenSanPham': tenSanPham,
          'giaTien': giaTien,
          'soLuong': soLuong,
        }
      );
    }
  }
  else
  {
    dssp.add(
      { 'tenSanPham': tenSanPham,
        'giaTien': giaTien,
        'soLuong': soLuong,
      }
    );
  }

}
void themDanhSachSanPham(List dssp, int n)
{
  if(n == 0)
  {
    print("Khong them sinh vien nao ca");
    return;
  }
  else if (n == 1)
  {
    print("San pham thu 1");
    themSanPham(dssp);
  }
  else
  {
    for(int i = 0 ; i<n ; i++)
    {
      print("San pham thu ${i+1}");
      themSanPham(dssp);
    }
  }
}
bool timKiemSanPhamTheoTen(List dssp, String name) => dssp.any((e) => e['tenSanPham'] == name);

void xuatDanhSachSanPham(List dssp)
{
  if(dssp.isEmpty)
  {
    print("Khong co san pham");
    return;
  }

  print("Thong tin cac san pham");  
  for(int i = 0; i < dssp.length; i++)
  {
    print("San pham thu ${i+1}");
    print("Ten san pham: ${dssp[i]["tenSanPham"]} Gia tien: ${dssp[i]["giaTien"]} So luong: ${dssp[i]["soLuong"]}");
  }
}

void banSanPham(List dssp, String tenSanPham, int soLuong)
{
  var sanPham = dssp.firstWhere((e)=> e['tenSanPham'] == tenSanPham, orElse: () => <String, dynamic>{});
  if(sanPham.isNotEmpty)
  {
    if(sanPham['soLuong'] >= soLuong)
    {
      sanPham['soLuong'] -= soLuong;
      print("Đã bán $soLuong sản phẩm $tenSanPham.");
    }
    else
      print("Khong du hang de ban.");
  }
  else
    print("Khong tim thay san pham.");
}

void main() 
{
  List<Map<String, dynamic>> danhSach = [];

  while (true) 
  {
    print("\n===== MENU =====");
    print("1. Them san pham");
    print("2. Hien thi danh sach san pham");
    print("3. Tim san pham");
    print("4. Ban san pham");
    print("5. Thoat");
    print("Chon:");

    int chon = int.parse(stdin.readLineSync() ?? "0");

    switch (chon) {
      case 1:
        print("Ban muon them bao nhieu san pham");
        int n = int.parse(stdin.readLineSync() ?? "0");
        themDanhSachSanPham(danhSach,n);
        break;
      case 2:
        xuatDanhSachSanPham(danhSach);
        break;
      case 3:
        if(danhSach.isEmpty)
        {
          print("Danh sach khong co san pham");
          break;
        }
        else
        {
          print("Nhap ten san pham ban muon tim kiem");
          String tenSanPhamTimKiem = "";
          while(true)
          {
            tenSanPhamTimKiem = stdin.readLineSync()!.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
            if(kiemTraTenCoHopLeKhong(tenSanPhamTimKiem))
              break;
            else
              print("Ten khong hop le. Vui long nhap lai");         
          }
          print(timKiemSanPhamTheoTen(danhSach, tenSanPhamTimKiem) ? "Tim thay san pham" : "Khong tim thay san pham");
          break;
        }
      case 4:
        if(danhSach.isEmpty)
        {
          print("Danh sach khong co san pham");
          break;
        }
        String tenSanPham = "";
        int soLuong = 0;
        print("Nhap ten san pham can ban");
        while(true)
        {
          tenSanPham = stdin.readLineSync()!.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
          if(kiemTraTenCoHopLeKhong(tenSanPham))
            break;
          else
            print("Ten khong hop le. Vui long nhap lai");         
        }

        print("Nhap so luong can ban");
        while(true)
        {
          soLuong = int.tryParse(stdin.readLineSync() ?? "") ?? -1;
          if(laSoHopLe(soLuong))
            break;
          else
            print("Ban vua nhap khong phai la so. Vui long nhap lai.");         
        }
        banSanPham(danhSach, tenSanPham, soLuong);
        break;
      case 5:
        print("Thoat chương trinh.");
        return;
      default:
        print("Chon sai!");
    }
  }
}