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
  postAfterScan(noID) async{
    var body = _makeJSON("cartId", noID);
    var svc = url+"getTransactionID";
    print(body);
    return await http.post(svc,headers: headers,body:body);
  }

  _postData(String suffix,String body) async{
    Map m;
    var svc=url+suffix;
    var response;
    print(svc+"   "+headers['Content-type']);
    try{
      response = await http.post(svc,headers: headers, body:body);
      print('dajdsihaisdhiahsias');
      if(response.statusCode==200){
        print('dajdsihaisdhiahsias');
        m = json.decode(response.body) as Map;
      }
    }catch(e){
      print(e.toString());
    }
    
    //cl.close();
    return m;
  }
  
  //list trsx
  getTrID(noID) {
    return _postData("getTransactionID",_makeJSON("cartId", noID));
  }
}