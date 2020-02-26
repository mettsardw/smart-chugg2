class Barang{
  int id;
  String nama;
  int qty;
  int baseprice;
  int price;

  Barang(this.id,this.nama,this.qty,this.baseprice){this.price = baseprice*qty;}

  void setQty(int qty){this.qty=qty;}
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
    String tx = qty.toString()+" x "+baseprice.toString() + " = " + price.toString();
    return tx;
  }
}