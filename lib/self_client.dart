import 'dart:convert';

import 'package:http/http.dart' as http;

class SelfClient{
  final url ="http://192.168.43.10:6969/";
  final Map<String,String> headers = {'Content-type':'application/json'};
  var cl;
  SelfClient(){
    cl = http.Client();
  }
  String _makeJSON(key,value){
    String json = '{"'+key.toString()+'":"'+value.toString()+'"}';
    return json;
  }
  String _makeJSON3(key,value,key2,value2,key3,value3){
    String json = '{"'+key.toString()+'":"'+value.toString()+'","'+key2.toString()+'":"'+value2.toString()+'","'+key3.toString()+'":"'+value3.toString()+'"}';
    return json;
  }

  String _makeJSON4(key,value,key2,value2,key3,value3,key4,value4){
    String json = '{"'+key.toString()+'":"'+value.toString()+'","'+key2.toString()+'":"'+value2.toString()+'","'+key3.toString()+'":"'+value3.toString()+'","'+key4.toString()+'":"'+value4.toString()+'"}';
    return json;
  }
  _postData(String suffix,String body) async{
    Map m;
    var svc=url+suffix;
    var response;
    try{
      response = await http.post(svc,headers: headers, body:body);
      if(response.statusCode==200){
        m = json.decode(response.body) as Map;
      }
    }catch(e){
      print(e.toString());
    }
    cl.close();
    return m;
  }
  
  //list trsx
  getTrID(noID) {
    //balikan: ID_TRANSACTION
    return _postData("getTransactionID",_makeJSON("cartId", noID));
  }

  recreateTrID(noID) {
    //balikan: ID_TRANSACTION
    return _postData("createTransactionID",_makeJSON("cartId", noID));
  }

  inqBarangFromTxn(txnID){
    //balikan:
    var jsonBody = _makeJSON("txnId", txnID.toString());
    return _postData("inquiryTransactionList",jsonBody);
  }

  deleteItem(txnID,itemID){
    var jsonBody = _makeJSON3("flag", "3","txnId",txnID.toString(),"itemId",itemID.toString());
    return _postData("manipulateTransactionData", jsonBody);
  }

  updateItem(txnID,itemID,qty){
    var jsonBody = _makeJSON4("flag", "2","txnId",txnID.toString(),"itemId",itemID.toString(),"quantity",qty.toString());
    return _postData("manipulateTransactionData", jsonBody);
  }

  getOTP(txnID){
    //balikan: status, OTP
    return _postData("getOTP", _makeJSON("txnId", txnID));
  }
}