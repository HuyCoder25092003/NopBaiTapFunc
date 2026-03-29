import 'dart:io';

bool kiemTraCoPhaiLaSoKhong(double input) => input >=0 && input <=10;

bool kiemTraTenCoHopLeKhong(String name) => RegExp(r'^[a-zA-Z\s]+$').hasMatch(name);

void themSinhVien(List dssv)
{
  while(true)
  {
    double diemToan = 0, diemLy = 0, diemHoa = 0;
    String hoTen = "";

    print("Ho ten");
    while(true)
    {
      hoTen = stdin.readLineSync()!.replaceAll(RegExp(r'\s+'), ' ').trim().toLowerCase();
      if(kiemTraTenCoHopLeKhong(hoTen))
        break;
      else
        print("Ten khong hop le. Vui long nhap lai");
    }

    print("Diem toan");
    while(true)
    {
      diemToan = double.tryParse(stdin.readLineSync() ?? "") ?? -1;
      if(kiemTraCoPhaiLaSoKhong(diemToan))
        break;
      else
        print("Ban vua nhap khong phai la so. Vui long nhap lai.");
    }

    print("Diem ly");
    while(true)
    {
      diemLy = double.tryParse(stdin.readLineSync() ?? "") ?? -1;
      if(kiemTraCoPhaiLaSoKhong(diemLy))
        break;
      else
        print("Ban vua nhap khong phai la so. Vui long nhap lai.");
    }

    print("Diem hoa");
    while(true)
    {
      diemHoa = double.tryParse(stdin.readLineSync() ?? "") ?? -1;
      if(kiemTraCoPhaiLaSoKhong(diemHoa))
        break;
      else
        print("Ban vua nhap khong phai la so. Vui long nhap lai.");
    }
    
    double diemTrungBinhMon = double.parse(diemTrungBinh(diemToan, diemLy, diemHoa).toStringAsFixed(1));

    String hocLuc = "Kem";

    if(diemTrungBinhMon > 9)
      hocLuc = "Xuat sac";
    else if(diemTrungBinhMon > 7 && diemTrungBinhMon <=9)
      hocLuc = "Gioi";
    else if (diemTrungBinhMon > 5 && diemTrungBinhMon <=7)
      hocLuc = "Kha";

    if(dssv.isNotEmpty)
    {
      var kiemTraTen = dssv.any((e) => e['hoTen'] == hoTen && e['diemToan'] == diemToan 
                                     && e['diemLy'] == diemLy && e['diemHoa'] == diemHoa);
      if(!kiemTraTen)
      {
        dssv.add(
          { 'hoTen':hoTen,
            'diemToan': diemToan,
            'diemLy': diemLy,
            'diemHoa' : diemHoa,
            'diemTrungBinh' : diemTrungBinhMon,
            'hocLuc' : hocLuc,
          }
        );
        break;
      }
      else
      {
        print("Sinh vien da ton tai");
      }
    }
    else
    {
      dssv.add
      (
        { 'hoTen':hoTen,
          'diemToan': diemToan,
          'diemLy': diemLy,
          'diemHoa' : diemHoa,
          'diemTrungBinh' : diemTrungBinhMon,
          'hocLuc' : hocLuc,
        }
      );
      break;
    }
  }
}
void themDanhSachSinhVien(List dssv, int n)
{
  if(n == 0)
  {
    print("Khong them sinh vien nao ca");
    return;
  }
  else if (n == 1)
  {
    print("Sinh vien thu 1");
    themSinhVien(dssv);
  }
  else
  {
    for(int i = 0 ; i<n ; i++)
    {
      print("Sinh vien thu ${i+1}");
      themSinhVien(dssv);
    }
  }
}

double diemTrungBinh(double diemToan, double diemLy, double diemHoa) => (diemToan + diemLy + diemHoa) / 3;

void timKiemDTBCaoNhat(List dssv)
{
  if(dssv.isEmpty)
    print("Khong co sinh vien trong danh sach");
  else if(dssv.length == 1)
    print("Sinh vien co diem trung binh cao nhat la: ${dssv[0]["hoTen"]}");
  else
  {
    double diemTB = 0;
    List<Map<String, dynamic>> svBest = [];
    for(var sv in dssv)
    {
      if(sv["diemTrungBinh"] > diemTB)
      {
        diemTB = sv["diemTrungBinh"];
        svBest = [sv];
      }
      else if (sv['diemTrungBinh'] == diemTB)
        svBest.add(sv);
    }
    
    if(svBest.length == 1)
      print("Sinh vien co diem trung binh cao nhat la: ${svBest[0]["hoTen"]}");
    else if (dssv.length > 1)
    {
      print("Co tong cong ${svBest.length} sinh vien co diem trung binh cao nhat");
      for(int i = 0; i < svBest.length; i++)
        print("Sinh vien ${i+1} ho ten: ${svBest[i]["hoTen"]}");
    }
  }
}

void xuatDanhSachSinhVien(List dssv)
{
  if(dssv.isEmpty)
  {
    print("Khong co sinh vien");
    return;
  }

  print("Thong tin cac sinh vien");  
  for(int i = 0; i < dssv.length; i++)
  {
    print("Sinh vien thu ${i+1}");
    print("Ho ten: ${dssv[i]["hoTen"]} Diem toan: ${dssv[i]["diemToan"]} Diem ly: ${dssv[i]["diemLy"]} Diem hoa: ${dssv[i]["diemHoa"]} Diem trung binh: ${dssv[i]["diemTrungBinh"]} Hoc luc: ${dssv[i]["hocLuc"]}");
  }
}

void main() 
{
  List<Map<String, dynamic>> danhSach = [];

  while (true) 
  {
    print("\n===== MENU =====");
    print("1. Thêm sinh viên");
    print("2. Hiển thị danh sách sinh vien");
    print("3. Tìm SV ĐTB cao nhất");
    print("4. Thoát");
    print("Chọn:");

    int chon = int.parse(stdin.readLineSync() ?? "0");

    switch (chon) {
      case 1:
        print("Ban muon them bao nhieu sinh vien");
        int n = int.parse(stdin.readLineSync() ?? "0");
        themDanhSachSinhVien(danhSach,n);
        break;
      case 2:
        xuatDanhSachSinhVien(danhSach);
        break;
      case 3:
        timKiemDTBCaoNhat(danhSach);
        break;
      case 4:
        print("Thoát chương trình.");
        return;
      default:
        print("Chọn sai!");
    }
  }
}