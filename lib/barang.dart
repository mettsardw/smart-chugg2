import 'package:intl/intl.dart';

class Barang{
  int id;
  String nama;
  int qty;
  int baseprice;
  int price;

  Barang(this.id,this.nama,this.qty,this.baseprice){this.price = baseprice*qty;}

  Barang.fromJson(Map<dynamic,dynamic> json){
    this.id = json["ID_ITEM"];
    this.nama = json["ITEM_DESC"];
    this.qty= int.parse(json["QUANTITY"]);
    this.baseprice = int.parse(json["BASE_PRICE"]);
    this.price = this.qty * this.baseprice;
  }

  Map<String,dynamic> toJson() => {
    "ID_ITEM":id,"ITEM_DESC":nama,"QUANTITY":qty,"BASE_PRICE":baseprice,
  };

  void setQty(int qty){this.qty=qty;}
  String getNama(){return this.nama;}
  int getQty(){return this.qty;}
  int getPrice(){return this.price;}
  void removeBarang(){
    this.qty--;
    updPrice();
  }
  void addQty(){
    this.qty++;
    updPrice();
  }
  void updPrice(){
    this.price=this.baseprice*this.qty;
  }
  String infoPrice(){
    var cur = NumberFormat.currency(locale: "id",symbol:"Rp. ",decimalDigits: 0);
    String tx = qty.toString()+" pcs @ "+cur.format(baseprice).toString() + " = " + cur.format(price).toString();
    return tx;
  }
}