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
bool timKiemSanPhamTheoTen(List dssp, String name) => dssp.any((e) => e['tenSanPham'] == name);

int tongTienSanPham(List dssp)
{
  int tong = 0;
  if(dssp.isEmpty)
    return tong;
  for(int i = 0; i<dssp.length; i++)
    tong+= (dssp[i]["giaTien"] as int) * (dssp[i]["soLuong"] as int);
  return tong;
}

void xoaSanPham(List dssp, String name)
{
  if(dssp.isEmpty)
  {
    print("Danh sach hien tai chua co san pham");
    return; 
  }
  if(!timKiemSanPhamTheoTen(dssp, name))
  {
    print("Khong tim thay san pham");
    return;
  }
  dssp.removeWhere((e) => e['tenSanPham'] == name);
  print("Da xoa san pham");
}

void suaSanPham(List dssp, String name)
{
  if(dssp.isEmpty)
  {
    print("Danh sach hien tai chua co san pham");
    return;
  }
  int check = -1;
  for (var sp in dssp) 
  {
    if (sp['tenSanPham'] == name) 
    {
      check = 1;
      print("Nhap so luong moi:");
      int soLuongMoi = 0;
      while(true)
      {
        soLuongMoi = int.tryParse(stdin.readLineSync() ?? "") ?? -1;
        if(laSoHopLe(soLuongMoi))
          break;
        else
          print("Ban vua nhap khong phai la so. Vui long nhap lai.");
      }
      sp['soLuong'] = soLuongMoi;
      break;
    }
  }
  if(check == -1)
  {
    print("Khong tim thay san pham");
  }
  else
    print("Da sua san pham");
}


void main() 
{
  
  List<Map<String, dynamic>> dssp = [];

  while (true) 
  {
    print("\n===== MENU =====");
    print("1. Them san pham");
    print("2. Xoa san pham");
    print("3. Sua san pham");
    print("4. Hien thi danh sach");
    print("5. Tong tien");
    print("6. Thoat");
    print("Chon");

    int chon = int.parse(stdin.readLineSync() ?? "1");

    switch (chon) 
    {
      case 1:
        print("Ban muon them bao nhieu san pham");
        int n = int.parse(stdin.readLineSync() ?? "0");
        themDanhSachSanPham(dssp,n);
        break;
      case 2:
        print("Nhap ten can xoa:");
        String tenSanPham = "";
        while(true)
        {
          tenSanPham = stdin.readLineSync()!.replaceAll(RegExp(r'\s+'), ' ').trim().toLowerCase();
          if(kiemTraTenCoHopLeKhong(tenSanPham))
            break;
          else
            print("Ten khong hop le. Vui long nhap lai");
        }
        xoaSanPham(dssp, tenSanPham);
        break;
      case 3:
        print("Nhap ten can sua:");
        String tenSanPham = "";
        while(true)
        {
          tenSanPham = stdin.readLineSync()!.replaceAll(RegExp(r'\s+'), ' ').trim().toLowerCase();
          if(kiemTraTenCoHopLeKhong(tenSanPham))
            break;
          else
            print("Ten khong hop le. Vui long nhap lai");
        }
        suaSanPham(dssp, tenSanPham);
        break;
      case 4:
        xuatDanhSachSanPham(dssp);
        break;
      case 5:
        print("Tong tien: ${tongTienSanPham(dssp)}");
        break;
      case 6:
        print("Thoat chuong trinh.");
        return;
      default:
        print("Lua chon khong hop le");
    }
  }
}