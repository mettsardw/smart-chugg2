import 'package:webapp_super/barang.dart';
import 'package:webapp_super/self_client.dart';

class BarangManager{
  SelfClient sc;
  
  BarangManager(){sc = SelfClient();}

  isiBarangs({txnID:11}) async{
    print("Getting txn ke: "+txnID.toString());
    List<Barang> barangs = [];
    Map <String,dynamic> m = await sc.inqBarangFromTxn(txnID);
    var jsonBrg = m["TRANSACTION_DETAIL"];
    for (var i = 0; i < jsonBrg.length; i++) {
      barangs.add(Barang.fromJson(jsonBrg[i]));
    }
    return barangs;
  }

  updBarang(itemID,qty,{txnID:11}) async{
    print("Mengupdate barang yang: "+itemID.toString());
    var resp = await sc.updateItem(txnID, itemID, qty);
  }

  delBarang(itemID,{txnID:11}) async{
    print("Mendelete barang yang: "+itemID.toString());
    var resp = await sc.deleteItem(txnID, itemID);
  }
}