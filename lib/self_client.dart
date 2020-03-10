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
}