import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:wallet_manager/util/ad_manager.dart';
import 'package:wallet_manager_ads_sharedpref/util/myButton.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../my_color_picker.dart';
import '../util/myChartGen.dart';
//import '../util/myChartGen.dart';
//import '../util/my_transes.dart';
import '../util/whallet.dart';
import '../util/MYMZ_database.dart';
import '../util/bus.dart';
import '../util/driver.dart';
import '../util/ticket.dart';
import '../util/route.dart';
import '../util/user.dart';
import '../util/transInfo.dart';
import 'package:wallet_manager_ads_sharedpref/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> Category = [
    'Food',
    'Transportation',
    'Studying',
    'Gaming',
    'Robot',
    'New Category +?',
  ];
  bool catDeleted=false;
  String kk='';
  String tem1='';
  String tem2='';
  String tem3='';
  String tem4='';
  String tem5='';
  String tem6='';

  Map<String, int> catCount = {
    'Food': 0,
    'Transportation': 0,
    'Studying': 0,
    'Gaming': 0,
    'Robot': 0,
  };
  Map<String, double> catPay = {
    'Food1': 0,
    'Transportation1': 0,
    'Studying1': 0,
    'Gaming1': 0,
    'Robot1': 0,
  };

  //for daily avg
  int currentDay=0;
  int totalDays=0;

  int numOfWallets = 0;
  bool transed = false;
  bool NightMood = false;

  List<Wallet> wallets = <Wallet>[];
  List<TransInfo> transs = <TransInfo>[];
  List<String> transPrint = <String>[];
  List<String> transColor = <String>[];

  List<String> walletNames = <String>[];


  //page controller
  //final key1 = GlobalKey<PageView>();
  final TextEditingController _walletNameCont = TextEditingController();
  final TextEditingController _chashCont = TextEditingController();
  final TextEditingController _withdrawalAmount = TextEditingController();

  final TextEditingController _busNumber = TextEditingController();
  final TextEditingController _pickup = TextEditingController();
  final TextEditingController _Arrival = TextEditingController();
  final TextEditingController _Departure_time = TextEditingController();
  final TextEditingController _expDate= TextEditingController();
  final TextEditingController _Status = TextEditingController();
  final TextEditingController _bid = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _price = TextEditingController();

  final TextEditingController _license = TextEditingController();
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  final TextEditingController _withdrawalName = TextEditingController();
  final TextEditingController _withdrawalCat = TextEditingController();
  final TextEditingController _Deposit = TextEditingController();
  final TextEditingController _newCat = TextEditingController();

  //final Uri _urlYousef = Uri.parse('https://www.linkedin.com/in/yousef-jarbou-9b50751ba');
  String yousefURL = 'https://www.linkedin.com/in/yousef-jarbou-9b50751ba';
  String omarURL = 'https://www.linkedin.com/in/omar-tobassi-818356211';
  //final Uri _urlOmar = Uri.parse('https://www.linkedin.com/in/omar-tobassi-818356211');
  final _controller = PageController();

  Color _color = Colors.blue;

bool dataLoaded=false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      getpref();
    });
    super.initState();
  }

  //Map<Date>

  String? value;
  String? value1;
  String? value2;
  String? value3;
  String? value4;
  String? value5;
  String dropdownValue = 'Food';
  String? currentName;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    GlobalKey<FormState> depositKey = GlobalKey<FormState>();
    GlobalKey<FormState> withdrawalKey = GlobalKey<FormState>();
    GlobalKey<FormState> newCattKey = GlobalKey<FormState>();

    GlobalKey<FormState> busInsert = GlobalKey<FormState>();
    GlobalKey<FormState> busSelect = GlobalKey<FormState>();
    GlobalKey<FormState> driverInsert = GlobalKey<FormState>();
    GlobalKey<FormState> tickInsert = GlobalKey<FormState>();
    GlobalKey<FormState> userInsert = GlobalKey<FormState>();
    GlobalKey<FormState> routInsert = GlobalKey<FormState>();
    GlobalKey<FormState> pickTimeselect = GlobalKey<FormState>();
    GlobalKey<FormState> ArrivalTimeselect = GlobalKey<FormState>();

    GlobalKey<FormState> routselect = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: NightMood ? Colors.grey[850] : Colors.grey[300],
      body: SafeArea(
        child:
              dataLoaded==false?Center(child: CircularProgressIndicator()):
              dataLoaded==true?
                 Column(children: [
                  Column(children: [
                    //appbar
                    Padding(
                      padding: EdgeInsets.only(top: w*0.12,bottom: w*0.08,left: w*0.06,right: w*0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "MYMZ",
                                style: TextStyle(
                                  fontSize: w * 0.078,
                                  fontWeight: FontWeight.bold,
                                  color:
                                  NightMood ? Colors.white : Colors.grey[900],
                                ),
                              ),
                              Text(
                                " Bus station",
                                style: TextStyle(fontSize: w * 0.07,color:
                                NightMood ? Colors.white : Colors.grey[900],),
                              ),
                            ],
                          ),
                          // plus button
                          // plus button
                          Container(

                            child: Image.asset('lib/icons/busss.png',scale: 6,),
                          ), // Container
                        ],
                      ),
                    ),
                    //wallets
                    Container(
                            height: h * 0.255,

                            //        //
                            //        //
                            //our team members
                            //        //
                            //        //
                            //        //
                            child: PageView.builder(
                              // reverse: true,
                              scrollDirection: Axis.horizontal,
                              controller: _controller,
                              itemCount: 5,

                              itemBuilder: (context, i) {

                                return
                                  Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.06),
                                  child: Container(
                                    width: 300,
                                    padding: EdgeInsets.all(w * 0.08),
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius:
                                        BorderRadius.circular(w * 0.04)),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(height: h * 0.009),

                                        Center(
                                          child: Text(
                                            i==0?'Swipe to know our team':i==1?'Yousef Jarbou':i==2?'Mohammad Inshasi':i==3?'Mohammad Kharoub':'Zaid Abdallah',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: w * 0.07,
                                              fontWeight: FontWeight.bold,
                                            ), // TextStyle
                                          ),
                                        ), // Text
                                        SizedBox(height: h * 0.05),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [

                                                Text(
                                        i==0?'':i==1?'Computer Engineering':i==2?'NIS Engineering':i==3?'NIS Engineering':'AI & Data',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: w * 0.055,

                                                  ),
                                                ),
                                              ],
                                            ),
                                            //card expiry date
                                            i==0||i==2||i==3?Container():
                                            Container(
                                              //padding: EdgeInsets.all(w*0.01,),
                                              // BoxDecoration
                                              child: IconButton(
                                                  onPressed: () {
                                                    openUrl(
                                                      i==1?yousefURL:'https://www.linkedin.com/in/zaid-abdullah-75066b24a/',
                                                    );
                                                  },
                                                  icon: Image.asset('lib/icons/linkedin.png')),

                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                );

                              },
                            ),
                            //        //
                            //        //
                            //        //
                            //Our Team MYMZZZZZZZZZZZZ
                            //        //
                            //        //
                          ),
                    SizedBox(height: h * 0.022),

                    SmoothPageIndicator(
                      controller: _controller,
                      count: 5,
                      effect: ExpandingDotsEffect(
                        activeDotColor: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: h * 0.026),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //        //
                        //        //
                        //select button
                        //        //
                        //        //
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              // disabledBackgroundColor: Colors.transparent,
                              // disabledForegroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              value=currentName;
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  )),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child:
                                      Container(
                                        height: h * 0.8,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: Text(
                                                'Select',
                                                style: TextStyle(
                                                  fontSize: w * 0.08,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                  NightMood ? Colors.white : Colors.grey[800],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              //Bus Bus bus
                                              //Bus Bus bus
                                              //Bus Bus bus
                                              //Bus Bus bus

                                              padding:  EdgeInsets.all(w*0.06),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.vertical(
                                                              top: Radius.circular(16),
                                                            )),
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.vertical,
                                                            child: Form(
                                                              key: busSelect,
                                                              child: Container(
                                                                height: h * 0.7,
                                                                child: Column(
                                                                  children: [

                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType:
                                                                        TextInputType.number, maxLines: 1, maxLength: 9, controller: _busNumber, validator: (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty||value.contains(" ")||value.contains("_")||value.contains("-")||int.parse(value)<0) {
                                                                            return "This field is required, or invalid entry!";
                                                                          }
                                                                          else{kk=value;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text("Bus Number"), border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    ElevatedButton(
                                                                        onPressed: ()  async{
                                                                          if (busSelect.currentState!.validate() == true) {
                                                                            Navigator.pop(context);

                                                                            var data= await DatabaseHelper.instance.getBusbynum(kk);

                                                                            var a1= thefun(data);
                                                                            var a0="Bid: "+data[0].Bid.toString()+"  bus number: "+data[0].BusNumber.toString()+'\n';
                                                                            var a3;
                                                                            if(data.length==0)a3='no data found';
                                                                            if(data.length>1)a3=a1;
                                                                            if(data.length==1)a3=a0;

                                                                            showDialog(context: context, builder: (context){
                                                                              return AlertDialog(
                                                                                title: Text('selected busses',),
                                                                                content: Text(a3  ),

                                                                              );
                                                                            });

                                                                            _busNumber.clear();
                                                                          }
                                                                        },
                                                                        child: const Text("Done")),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                   child: const Text("BUS")),
                                            ),

                                            Padding(
                                              //driver
                                              //driver
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: const Text("DRIVER")),
                                            ),

                                            Padding(
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: ElevatedButton(
                                                  onPressed: (){},
                                                  child: const Text("TICKET")),
                                            ),

                                            Padding(
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: ElevatedButton(
                                                  onPressed: (){},
                                                  child: const Text("USER")),
                                            ),

                                            Padding(
                                              //rout rout rout
                                              //rout rout rout
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.vertical(
                                                              top: Radius.circular(16),
                                                            )),
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.vertical,
                                                            child:
                                                            Container(
                                                              height: h * 0.8,
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:  EdgeInsets.all(w*0.06),
                                                                    child: Text(
                                                                      'Select rout',
                                                                      style: TextStyle(
                                                                        fontSize: w * 0.08,
                                                                        fontWeight: FontWeight.bold,
                                                                        color:
                                                                        NightMood ? Colors.white : Colors.grey[800],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    //Bus Bus bus
                                                                    //Bus Bus bus
                                                                    //Bus Bus bus
                                                                    //Bus Bus bus

                                                                    padding:  EdgeInsets.all(w*0.06),
                                                                    child: ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                          showModalBottomSheet(
                                                                              isScrollControlled: true,
                                                                              shape: const RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.vertical(
                                                                                    top: Radius.circular(16),
                                                                                  )),
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return SingleChildScrollView(
                                                                                  scrollDirection: Axis.vertical,
                                                                                  child: Form(
                                                                                    key: pickTimeselect,
                                                                                    child: Container(
                                                                                      height: h * 0.7,
                                                                                      child: Column(
                                                                                        children: [

                                                                                          Padding(
                                                                                            padding:
                                                                                            const EdgeInsets.all(10.0),
                                                                                            child: TextFormField(
                                                                                              keyboardType:
                                                                                              TextInputType.number,
                                                                                              //search for (on change function) to make the max line =5
                                                                                              maxLines: 1,
                                                                                              maxLength: 9,
                                                                                              controller: _pickup,
                                                                                              validator: (value) {
                                                                                                if (value == null ||
                                                                                                    value.isEmpty||value.contains(" ")||value.contains("_")
                                                                                                    ||value.contains("-")||int.parse(value)<0||int.parse(value)>23) {
                                                                                                  return "This field is required, or invalid entry!";
                                                                                                }
                                                                                                else{kk=value;return null;}
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                label: const Text(
                                                                                                    "pick time (just hours from 0 to 23"),
                                                                                                border: OutlineInputBorder(
                                                                                                    borderRadius:
                                                                                                    BorderRadius
                                                                                                        .circular(15)),
                                                                                              ),
                                                                                            ),
                                                                                          ),

                                                                                          ElevatedButton(
                                                                                              onPressed: ()  async{
                                                                                                if (pickTimeselect.currentState!.validate() == true) {
                                                                                                  var data= await DatabaseHelper.instance.getRoutByPickup(kk);
                                                                                                  Navigator.pop(context);

                                                                                                  var a1= thefun1(data);
                                                                                                  var a0="Rid: "+data[0].Rid.toString()+"  pick time: "+data[0].Pickup_point.toString()+"  Arrival time: "+data[0].Arrival_point.toString()+'\n';
                                                                                                  var a3;
                                                                                                  if(data.length==0)a3='no data found';
                                                                                                  if(data.length>1)a3=a1;
                                                                                                  if(data.length==1)a3=a0;



                                                                                                  showDialog(context: context, builder: (context){
                                                                                                    return AlertDialog(
                                                                                                      title: Text('routes--> pick up',),
                                                                                                      content: Text(a3),

                                                                                                    );
                                                                                                  });
                                                                                                  
                                                                                                  _pickup.clear();
                                                                                                }
                                                                                              },
                                                                                              child: const Text("Done")),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              });
                                                                        },
                                                                        child: const Text("Pickup time")),
                                                                  ),

                                                                  Padding(
                                                                    //driver
                                                                    //driver
                                                                    padding:  EdgeInsets.all(w*0.06),
                                                                    child: ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                          showModalBottomSheet(
                                                                              isScrollControlled: true,
                                                                              shape: const RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.vertical(
                                                                                    top: Radius.circular(16),
                                                                                  )),
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return SingleChildScrollView(
                                                                                  scrollDirection: Axis.vertical,
                                                                                  child: Form(
                                                                                    key: ArrivalTimeselect,
                                                                                    child: Container(
                                                                                      height: h * 0.7,
                                                                                      child: Column(
                                                                                        children: [

                                                                                          Padding(
                                                                                            padding:
                                                                                            const EdgeInsets.all(10.0),
                                                                                            child: TextFormField(
                                                                                              keyboardType:
                                                                                              TextInputType.number,
                                                                                              //search for (on change function) to make the max line =5
                                                                                              maxLines: 1,
                                                                                              maxLength: 9,
                                                                                              controller: _Arrival,
                                                                                              validator: (value) {
                                                                                                if (value == null ||
                                                                                                    value.isEmpty||value.contains(" ")||value.contains("_")
                                                                                                    ||value.contains("-")||int.parse(value)<0||int.parse(value)>23) {
                                                                                                  return "This field is required, or invalid entry!";
                                                                                                }
                                                                                                else{tem2=value;return null;}
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                label: const Text(
                                                                                                    "Arrival time (just hours from 0 to 23"),
                                                                                                border: OutlineInputBorder(
                                                                                                    borderRadius:
                                                                                                    BorderRadius
                                                                                                        .circular(15)),
                                                                                              ),
                                                                                            ),
                                                                                          ),

                                                                                          ElevatedButton(
                                                                                              onPressed: ()  async{
                                                                                                if (ArrivalTimeselect.currentState!.validate() == true) {
                                                                                                  var data= await DatabaseHelper.instance.getRoutByArrive(tem2);
                                                                                                  Navigator.pop(context);

                                                                                                  var a1= thefun1(data);
                                                                                                  var a0="Rid: "+data[0].Rid.toString()+"  pick time: "+data[0].Pickup_point.toString()+"  Arrival time: "+data[0].Arrival_point.toString()+'\n';
                                                                                                  var a3;
                                                                                                  if(data.length==0)a3='no data found';
                                                                                                  if(data.length>1)a3=a1;
                                                                                                  if(data.length==1)a3=a0;



                                                                                                  showDialog(context: context, builder: (context){
                                                                                                    return AlertDialog(
                                                                                                      title: Text('routes--> Arrival',),
                                                                                                      content: Text(a3),

                                                                                                    );
                                                                                                  });
                                                                                                  _Arrival.clear();
                                                                                                  _pickup.clear();
                                                                                                }
                                                                                              },
                                                                                              child: const Text("Done")),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              });
                                                                        },
                                                                        child: const Text("Arrival time")),
                                                                  ),



                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: const Text("ROUTE")),
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Mybotton(
                              buttinText: 'Select',
                              imagePath: 'lib/icons/cash-withdrawal.png',
                              buttonNightMood: NightMood,
                            )),
                        //        //
                        //     //
                        //insert button
                        //    //
                        //        //

                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  )),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child:
                                      Container(
                                        height: h * 0.8,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: Text(
                                                'Insert',
                                                style: TextStyle(
                                                  fontSize: w * 0.08,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                  NightMood ? Colors.white : Colors.grey[800],
                                                ),
                                              ),
                                            ),
                                            Padding(//busssssssssssssssssssssssssss bussssssssss
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.vertical(
                                                              top: Radius.circular(16),
                                                            )),
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.vertical,
                                                            child: Form(
                                                              key: busInsert,
                                                              child: Container(
                                                                height: h * 0.7,
                                                                child: Column(
                                                                  children: [

                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType:
                                                                        TextInputType.number,
                                                                        maxLines: 1,
                                                                        maxLength: 9,
                                                                        controller: _busNumber,
                                                                        validator: (value) {
                                                                          if (value == null || value.isEmpty||value.contains(" ")||value.contains("_")||value.contains("-")||int.parse(value)<0) {
                                                                            return "This field is required, or invalid entry!";

                                                                          }
                                                                          else{kk= value; return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "Bus Number"),
                                                                          border: OutlineInputBorder(
                                                                              borderRadius:
                                                                              BorderRadius
                                                                                  .circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    ElevatedButton(
                                                                        onPressed: ()  async{

                                                                          if (busInsert.currentState!.validate() == true) {
                                                                            print('---------ffffffffff------------\n');

                                                                            print('---------ffffffffff------------\n');
                                                                            ggg(kk);
                                                                            Navigator.pop(context);
                                                                            _busNumber.clear();
                                                                            print('---------ffffffffff------------\n');
                                                                            print('---------ffffffffff------------\n');
                                                                            print('---------ffffffffff------------\n');
                                                                            var tt=await DatabaseHelper.instance.getBusses();
                                                                            print('0'+tt[0].BusNumber);
                                                                            var ttt=await DatabaseHelper.instance.getBusses();
                                                                            print(ttt[1].BusNumber);
                                                                            var tttt=await DatabaseHelper.instance.getBusses();
                                                                            print(tttt[2].BusNumber);
                                                                            var ttttt=await DatabaseHelper.instance.getBusses();
                                                                            print("3"+ttttt[3].BusNumber);
                                                                            var rr=await DatabaseHelper.instance.getBusses();
                                                                            print("4"+rr[4].BusNumber);
                                                                            print('---------ffffffffff------------\n');
                                                                            print('---------ffffffffff------------\n');
                                                                          }
                                                                        },
                                                                        child: const Text("Done")),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: const Text("BUS")),
                                            ),

                                            Padding(//driiiiiiiiiver driiiiiiver
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.vertical(
                                                              top: Radius.circular(16),
                                                            )),
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.vertical,
                                                            child: Form(
                                                              key: driverInsert,
                                                              child: Container(
                                                                height: h * 0.95,
                                                                child: Column(
                                                                  children: [

                                                                    Padding(//License_no License_noooooooo
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.number, maxLines: 1, maxLength: 9, controller: _license,
                                                                        validator: (value) {
                                                                          if (value == null || value.isEmpty||value.contains(" ")||value.contains("_")||value.contains("-")||int.parse(value)<0) {
                                                                            return "This field is required, or invalid entry!";

                                                                          }
                                                                          else{kk=value;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "License_no"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(//FNAME FNAME FNAME
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.text, maxLines: 1, maxLength: 9, controller: _fname,
                                                                        validator: (value1) {
                                                                          if (value1 == null || value1.isEmpty||value1.contains(" ")||value1.contains("_")||value1.contains("-")) {
                                                                            return "This field is required, or invalid entry!";

                                                                          }
                                                                          else{tem1=value1;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "First NAME"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Padding(//LNAME lNAME LNAME
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.text, maxLines: 1, maxLength: 9, controller: _lname,
                                                                        validator: (value2) {
                                                                          if (value2 == null || value2.isEmpty||value2.contains(" ")||value2.contains("_")||value2.contains("-")) {
                                                                            return "This field is required, or invalid entry!";

                                                                          }
                                                                          else{tem2=value2;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "Last NAME"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Padding(//Bid bid biddddd
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.number, maxLines: 1, maxLength: 9, controller: _bid,
                                                                        validator: (value3) {
                                                                          if (value3 == null || value3.isEmpty||value3.contains(" ")||value3.contains("_")||value3.contains("-")||int.parse(value3)<0) {
                                                                            return "This field is required, or invalid entry!";

                                                                          }
                                                                          else{tem3=value3;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "bus id"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    ElevatedButton(
                                                                        onPressed: ()  async{
                                                                          if (driverInsert.currentState!.validate() == true) {

                                                                            await DatabaseHelper.instance.addDriver(
                                                                                DRIVER(License_no: kk, FNAME: tem1, LNAME: tem2, Bid: tem3)
                                                                            );
                                                                            Navigator.pop(context);
                                                                            _license.clear();
                                                                            _fname.clear();
                                                                            _lname.clear();
                                                                            _bid.clear();

                                                                          }
                                                                        },
                                                                        child: const Text("Done")),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: const Text("DRIVER")),
                                            ),

                                            Padding( //tickkkkkkkkt tickkkkkkkkket
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.vertical(
                                                              top: Radius.circular(16),
                                                            )),
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.vertical,
                                                            child: Form(
                                                              key: tickInsert,
                                                              child: Container(
                                                                height: h * 0.94,
                                                                child: Column(
                                                                  children: [

                                                                    Padding(//Departure_time Departure_timeeeeeeeeeeee
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType:
                                                                        TextInputType.number,
                                                                        maxLines: 1,
                                                                        maxLength: 9,
                                                                        controller: _Departure_time,
                                                                        validator: (valu) {
                                                                          if (valu == null ||
                                                                              valu.isEmpty||valu.contains(" ")||valu.contains("_")
                                                                              ||valu.contains("-")||int.parse(valu)<0||int.parse(valu)>23) {
                                                                            return "This field is required, or invalid entry!";
                                                                          }
                                                                          else{kk=valu;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "Departure_time  (just hours from 0 to 23"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding( //Status Status Statusssssssss
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.number, maxLines: 1, maxLength: 1, controller: _Status,
                                                                        validator: (valu1) {
                                                                          if (valu1==null||valu1.isEmpty||(valu1!='0'&& valu1!='1')) {
                                                                            return "This field is required, or invalid entry!";
                                                                          }else{tem1=valu1!;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "Status (0 or 1)"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Padding( //type type type
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.number, maxLines: 1, maxLength: 1, controller: _type,
                                                                        validator: (valu2) {
                                                                          if (valu2 == null ||
                                                                              valu2.isEmpty||valu2.contains(" ")||valu2.contains("_") ||valu2.contains("-")||(valu2!='0'&&valu2!='1')) {
                                                                            return "This field is required, or invalid entry!";
                                                                          }else{tem2=valu2;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "Vip/economy (1 / 0)"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Padding(//Expiry_date eeeeeeeeeee
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.text, maxLines: 1, maxLength: 10, controller: _expDate,
                                                                        validator: (valu3) {
                                                                          if (valu3 == null ||
                                                                              valu3.isEmpty||valu3.contains(" ")||valu3.contains("_")
                                                                              ||valu3.contains("-")) {
                                                                            return "This field is required, or invalid entry!";
                                                                          }
                                                                          else{tem3=valu3;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "Expiry_date day/month/year"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding( //priiceeeeeeeeeeee $$$$$$$$$$
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.number, maxLines: 1, maxLength: 2, controller: _price,
                                                                        validator: (valu4) {
                                                                          if (valu4 == null ||
                                                                              valu4.isEmpty||valu4.contains(" ")||valu4.contains("_") ||valu4.contains("-")||int.parse(valu4)<0) {
                                                                            return "This field is required, or invalid entry!";
                                                                          }else{tem4=valu4;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "price"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding( //bus iddddddd
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.number, maxLines: 1, maxLength: 3, controller: _bid,
                                                                        validator: (valu5) {
                                                                          if (valu5 == null ||
                                                                              valu5.isEmpty||valu5.contains(" ")||valu5.contains("_") ||valu5.contains("-")||int.parse(valu5)<0) {
                                                                            return "This field is required, or invalid entry!";
                                                                          }else{tem5=valu5;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "bus id"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    ElevatedButton(

                                                                        onPressed: ()  async{
                                                                          if (tickInsert.currentState!.validate() == true) {

                                                                            await DatabaseHelper.instance.addTicket(
                                                                                TICKET(Departure_time: kk, Status: tem1, Vip: tem2, Expiry_date: tem3, Price: tem4, Bid: tem5)
                                                                            );
                                                                            Navigator.pop(context);
                                                                            _Departure_time.clear();
                                                                            _Status.clear();
                                                                            _type.clear();
                                                                            _bid.clear();
                                                                            _expDate.clear();
                                                                            _price.clear();

                                                                          }
                                                                        },
                                                                        child: const Text("Done")),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: const Text("TICKET")),
                                            ),

                                            Padding(//USER USERrrrrrrrrrr
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.vertical(
                                                              top: Radius.circular(16),
                                                            )),
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.vertical,
                                                            child: Form(
                                                              key: userInsert,
                                                              child: Container(
                                                                height: h * 0.94,
                                                                child: Column(
                                                                  children: [

                                                                    Padding(//mobile number
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.number, maxLines: 1, maxLength: 10, controller: _license,
                                                                        validator: (value) {
                                                                          if (value == null || value.isEmpty||value.contains(" ")||value.contains("_")||value.contains("-")||int.parse(value)<0) {
                                                                            return "This field is required, or invalid entry!";

                                                                          }
                                                                          else{kk=value;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "mobile number 10 digits"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(//FNAME FNAME FNAME
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.text, maxLines: 1, maxLength: 9, controller: _fname,
                                                                        validator: (value1) {
                                                                          if (value1 == null || value1.isEmpty||value1.contains(" ")||value1.contains("_")||value1.contains("-")) {
                                                                            return "This field is required, or invalid entry!";

                                                                          }
                                                                          else{tem1=value1;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "First NAME"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Padding(//LNAME lNAME LNAME
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.text, maxLines: 1, maxLength: 9, controller: _lname,
                                                                        validator: (value2) {
                                                                          if (value2 == null || value2.isEmpty||value2.contains(" ")||value2.contains("_")||value2.contains("-")) {
                                                                            return "This field is required, or invalid entry!";

                                                                          }
                                                                          else{tem2=value2;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "Last NAME"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Padding(//password
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType: TextInputType.text, maxLines: 1, maxLength: 10, controller: _pass,
                                                                        validator: (value3) {
                                                                          if (value3 == null || value3.isEmpty||value3.contains(" ")||value3.contains("_")||value3.contains("-")||int.parse(value3)<0) {
                                                                            return "This field is required, or invalid entry!";

                                                                          }
                                                                          else{tem3=value3;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "passward"),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    ElevatedButton(
                                                                        onPressed: ()  async{
                                                                          if (userInsert.currentState!.validate() == true) {

                                                                            await DatabaseHelper.instance.addUsers(
                                                                                USERS(MOBILE_NO: kk, FNAME: tem1, LNAME: tem2, PASSWORD: tem3)
                                                                            );
                                                                            Navigator.pop(context);
                                                                          }
                                                                        },
                                                                        child: const Text("Done")),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: const Text("USER")),
                                            ),

                                            Padding(//rout rout rout routtttttttttttttt
                                              padding:  EdgeInsets.all(w*0.06),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.vertical(
                                                              top: Radius.circular(16),
                                                            )),
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.vertical,
                                                            child: Form(
                                                              key: routInsert,
                                                              child: Container(
                                                                height: h * 0.94,
                                                                child: Column(
                                                                  children: [

                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType:
                                                                        TextInputType.number,
                                                                        //search for (on change function) to make the max line =5
                                                                        maxLines: 1,
                                                                        maxLength: 9,
                                                                        controller: _pickup,
                                                                        validator: (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty||value.contains(" ")||value.contains("_")
                                                                              ||value.contains("-")||int.parse(value)<0||int.parse(value)>23) {
                                                                            return "This field is required, or invalid entry!";
                                                                          }
                                                                          else{kk=value;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "pick time (just hours from 0 to 23"),
                                                                          border: OutlineInputBorder(
                                                                              borderRadius:
                                                                              BorderRadius
                                                                                  .circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        keyboardType:
                                                                        TextInputType.number,
                                                                        //search for (on change function) to make the max line =5
                                                                        maxLines: 1,
                                                                        maxLength: 9,
                                                                        controller: _Arrival,
                                                                        validator: (value1) {
                                                                          if (value1 == null ||
                                                                              value1.isEmpty||value1.contains(" ")||value1.contains("_")
                                                                              ||value1.contains("-")||int.parse(value1)<0||int.parse(value1)>23) {
                                                                            return "This field is required, or invalid entry!";
                                                                          }
                                                                          else{tem1=value1;return null;}
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          label: const Text(
                                                                              "Arrival time (just hours from 0 to 23"),
                                                                          border: OutlineInputBorder(
                                                                              borderRadius:
                                                                              BorderRadius
                                                                                  .circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    ElevatedButton(
                                                                        onPressed: () async {
                                                                          if (routInsert.currentState!.validate() == true) {

                                                                            await DatabaseHelper.instance.addROUTE(
                                                                                ROUTE(Pickup_point: kk, Arrival_point: tem1)
                                                                            );

                                                                            Navigator.pop(context);
                                                                            _Arrival.clear();
                                                                            _pickup.clear();
                                                                          }
                                                                        },
                                                                        child: const Text("Done")),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: const Text("ROUTE")),
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Mybotton(
                              buttinText: 'Insert',
                              imagePath: 'lib/icons/deposit.png',
                              buttonNightMood: NightMood,
                            )),
                        //deposit button
                      ],
                    ),

                    //        //
                    //        //
                    //masroofaty
                    //        //
                    //        //
                    SizedBox(height: h * 0.03),
                    Column(
                      children: [
                        ListTile(
                          leading: Container(
                            height: w * 0.2,
                            padding: EdgeInsets.all(w * 0.014),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(w * 0.018),
                              boxShadow: [
                                if (NightMood == false)
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: w * 0.09,
                                    spreadRadius: w * 0.029,
                                  ),
                              ],
                            ),
                            child: Image.asset('lib/icons/budget.png'),
                          ),
                          title: Text(
                            'All tables',
                            style: TextStyle(
                              fontSize: w * 0.05,
                              fontWeight: FontWeight.bold,
                              color:
                                  NightMood ? Colors.white : Colors.grey[800],
                            ),
                          ),
                          onTap: () async {
                            var bus1 = await DatabaseHelper.instance.getBusses();
                            var bus2 = <String>[]; // Initialize bus2 as an empty list

                            for (int i = 0; i < bus1.length; i++) {
                              bus2.add("Bid: " +
                                  bus1[i].Bid.toString() +
                                  "  bus number: " +
                                  bus1[i].BusNumber.toString() +
                                  '\n\n');
                            }

                            var ticket1 = await DatabaseHelper.instance.getTickets();
                            var ticket2 = <String>[]; // Initialize ticket2 as an empty list

                            for (int i = 0; i < ticket1.length; i++) {
                              ticket2.add("Tid: " +
                                  ticket1[i].Tid.toString() +
                                  "  Departure_time: " +
                                  ticket1[i].Departure_time.toString() +
                                  "  Status: " +
                                  ticket1[i].Status.toString() +
                                  "  vip?: "+
                                  ticket1[i].Vip.toString() +
                                  "  exp: " +
                                  ticket1[i].Expiry_date.toString() +
                                  "  price: " +
                                  ticket1[i].Price.toString() +
                                  '\n\n');
                            }

                            var driver1 = await DatabaseHelper.instance.getDRIVERs();
                            var driver2 = <String>[]; // Initialize driver2 as an empty list

                            for (int i = 0; i < driver1.length; i++) {
                              driver2.add("Did: " +
                                  driver1[i].id.toString() +
                                  "  License_no: " +
                                  driver1[i].License_no.toString() +
                                  "  FNAME: " +
                                  driver1[i].FNAME.toString() +
                                  "  LNAME: " +
                                  driver1[i].LNAME.toString() +
                                  "  Bid: "+
                                  driver1[i].Bid.toString() +
                                  '\n\n');
                            }

                            var user1 = await DatabaseHelper.instance.getUsers();
                            var user2 = <String>[]; // Initialize user2 as an empty list

                            for (int i = 0; i < user1.length; i++) {
                              user2.add("Pid: " +
                                  user1[i].PID.toString() +
                                  "  MOBILE_NO: " +
                                  user1[i].MOBILE_NO.toString() +
                                  "  FNAME: " +
                                  user1[i].FNAME.toString() +
                                  '\n\n');
                            }

                            var rout1 = await DatabaseHelper.instance.getROUTEs();
                            var rout2 = <String>[]; // Initialize rout2 as an empty list

                            for (int i = 0; i < rout1.length; i++) {
                              rout2.add("Rid: " +
                                  rout1[i].Rid.toString() +
                                  "  Pickup_point: " +
                                  rout1[i].Pickup_point.toString() +
                                  "  Arrival_point: " +
                                  rout1[i].Arrival_point.toString() +
                                  '\n');
                            }

                            var myall = {'bus:\n': bus2, '\n\nticket:\n': ticket2, '\n\ndriver:\n': driver2, '\n\nuser:\n': user2, '\n\nrout:\n': rout2};

                            showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16),
                                          )),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child:
                                          Container(
                                            height: h * 0.94,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:  EdgeInsets.all(w*0.06),
                                                  child: Text(
                                                    'All tables',
                                                    style: TextStyle(
                                                      fontSize: w * 0.08,
                                                      fontWeight: FontWeight.bold,
                                                      color:
                                                      NightMood ? Colors.white : Colors.grey[800],
                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding:  EdgeInsets.all(w*0.02),
                                                  child: Text(
                                                    myall.toString(),
                                                    style: TextStyle(
                                                      fontSize: w * 0.04,
                                                      fontWeight: FontWeight.bold,
                                                      color:
                                                      NightMood ? Colors.white : Colors.grey[800],
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },

                          trailing: const Icon(Icons.arrow_forward,),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.08),
                          child: Row(
                            children: [
                              Container(
                                //height: h*0.14,
                                decoration: BoxDecoration(
                                  // color: Colors.grey[100],
                                  borderRadius:
                                      BorderRadius.circular(w * 0.036),
                                  boxShadow: [],
                                ),
                                child: Center(
                                  //'lib/icons/cash-withdrawal.png'
                                  child: Icon(CupertinoIcons.moon_stars,color:
                                  NightMood ? Colors.white : Colors.grey[850],),
                                ),
                              ),
                              Switch(
                                  activeColor: Colors.grey[700],
                                  value: NightMood,
                                  onChanged: (value) async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    pref.setBool('NightMood', value);
                                    setState(() {

                                      NightMood = value;
                                      darkModeNotifier.value = NightMood;
                                      //darky.put('darky',value);

                                    });
                                  }),
                            ],
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: h * 0.005,),
                  ]),
                ]):

                 Center(child: Text("Error"),),

      ),
    );
  }


  String? getDataTrans() {
    for (int u = 0; u < transs.length; u++) {
      return transs[u].dataOflog()!;
    }
  }

  List<GDPData> getChartData1() {
    final List<GDPData> chartData = [];
    for(int i=0;i<Category.length-1;i++){
      if (catCount[Category[i]]! != 0) chartData.add(GDPData(Category[i], catCount[Category[i]]!));
  }
    return chartData;
  }
  List<GDPData> getChartData2() {

    final List<GDPData> chartData = [];
    for(int i=0;i<Category.length-1;i++){
      if (catPay[Category[i]+'1']! != 0) chartData.add(GDPData(Category[i], catPay[Category[i]+'1']!.toInt()));
    }

    return chartData;
  }

  Future<void> openUrl(String url) async {
    final _url = Uri.parse(url);
    if (!await canLaunchUrl(_url)) throw Exception('Could not launch $_url');
    await launchUrl(_url, mode: LaunchMode.externalApplication);
  }

  Future<void> getpref() async {

    await setOpened();


    SharedPreferences pref = await SharedPreferences.getInstance();


      if ((pref.getBool('NightMood')) != null) {
        NightMood = pref.getBool('NightMood')!;
        //N=NightMood;
      } else {
        NightMood = false;
      }
      darkModeNotifier.value = NightMood;


    if ((pref.getInt('currentDay')) != null) {
      currentDay = pref.getInt('currentDay')!;
    } else {
      currentDay = 0;
    }

    if ((pref.getInt('totalDays')) != null) {
      totalDays = pref.getInt('totalDays')!;
    } else {
      totalDays = 0;
    }


      if ((pref.getStringList("walletsList")) != null) {
        for (int i = 0; i < numOfWallets; i++) {
          String n;
          double m;
          Color c;
          String temp1 = pref.getStringList("walletsList")![i];
          List<String> temp2 = temp1.split(",");
          n = temp2[0];
          m = double.parse(temp2[1]);

          String valueString =
              temp2[2].split('(0x')[1].split(')')[0]; // kind of hacky..
          int value = int.parse(valueString, radix: 16);
          c = Color(value);
          wallets.add(Wallet(name: n, money: m, cc: c));
          walletNames.add(n);

        }
      }



    setState(() {
      dataLoaded=true;
    });
    print('---------------\ngetpref');
  }
  Future<void> setTransed(String timp4) async {
    SharedPreferences pref =
    await SharedPreferences
        .getInstance();
    pref.setBool(
        'transed', true);
    pref.setInt(timp4, catCount[timp4]!);
    pref.setInt(timp4+'1', catPay[timp4+'1']!.toInt());
  }

  Future<void> setCateg(String timp4) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(timp4, catCount[timp4]!);
    pref.setInt(timp4+'1', catPay[timp4+'1']!.toInt());
  }
  Future<void> delCateg(int more) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // int tempp;
    // double temppp;
    for (int i = 5; i < more-1; i++) {

      // tempp=pref.getInt(Category[i])!;
      // temppp=pref.getInt(Category[i]+'1')!.toDouble();
      pref.remove(Category[i]);
      pref.remove(Category[i]+"1");
       // pref.setInt(Category[i],tempp);
       // pref.setInt(Category[i]+'1',temppp.toInt());
    }
    setState(() {

    });
  }

  Future<void> setTransedOnly() async {
  SharedPreferences pref =
      await SharedPreferences
      .getInstance();
  pref.setBool(
  'transed', true);}

  Future<void> setOpened() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('opened', true);
  }

  Future<void> ggg(String dd)async{
  await DatabaseHelper.instance.addBusses(BUS(BusNumber: dd),);
  }

  Future<void> clearAllTrans() async {
    setState(() {
      transed=false;
      Navigator.pop(
          context);
    });
    SharedPreferences pref = await SharedPreferences.getInstance();

      transColor.clear();
      pref.remove('transColor');

      transPrint.clear();
      pref.remove('transList');

    for(int i=0;i<Category.length-1;i++){
      catCount[Category[i]] =0; pref.setInt(Category[i],0);
      catPay[Category[i]+'1'] =0; pref.setInt(Category[i]+'1',0);
    }

    pref.remove('currentDay');
    pref.remove('totalDays');
    totalDays=0;
    currentDay=-1;
    pref.setBool('transed', false);


  }
  double getTotalExp(){
    double total=0;
    for(int i=0;i<Category.length-1;i++){
      if (catPay[Category[i]+'1']! != 0) total+=catPay[Category[i]+'1']!;
    }

    return total;
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
}

String thefun(List<BUS> h){
  String j="Bid: "+h[0].Bid.toString()+"  bus number: "+h[0].BusNumber.toString()+'\n';
  for (int i=1; i<h.length;i++){
    j+="Bid: "+h[i].Bid.toString()+"  bus number: "+h[i].BusNumber.toString()+'\n';
  }
  return j;
}

String thefun1(List<ROUTE> h){
  String j="Rid: "+h[0].Rid.toString()+"  pick time: "+h[0].Pickup_point.toString()+"  Arrival time: "+h[0].Arrival_point.toString()+'\n';
  for (int i=1; i<h.length;i++){
    j+="Rid: "+h[i].Rid.toString()+"  pick time: "+h[i].Pickup_point.toString()+"  Arrival time: "+h[i].Arrival_point.toString()+'\n';
  }
  return j;
}

