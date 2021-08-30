import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Worldtime{
  late String location; //location name for the ui
  late String time ;//time in that location
  late String flag;// url to an asset flag icon
  late String url;//location url for api endpoint
  late bool isDaytime ; // true or false if daytime or not

  Worldtime({ required this.location,required this.flag,required this.url});

  Future<void> getTime() async {
    try{
      //make request
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);
      //get propertites from data
      String datatime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datatime);
      //print(offset);
      //create a datetime object
      DateTime now= DateTime.parse(datatime);
      now = now.add(Duration(hours: int.parse(offset)));
      //set time properity
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false ;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error :$e');
      time ='could not get time data';
    }
  }
}


