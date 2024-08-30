import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  DateTime? selectedDate;

  void _showDatePicker() async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) {
      return;
    }

    setState(() {
      selectedDate = newDate;
    });
  }

  Future<void> getdata() async {
    final String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI0OTk5NjgyLCJpYXQiOjE3MjQ5MDc0NzUsImp0aSI6IjZmNTExNjQ4MzI3ZjQ2ODNhNGE4MTVlOTgxMTQ1N2U3IiwidXNlcl9pZCI6IjJlNGUyNTFkLWI5ZWMtNDQ3NC1iOTI2LTM3ZjE0YTU1M2Q1YiIsInRpbWVjb2RlIjoiMjAyNDA4MjkxMDI3IiwibWl4ZXIiOiJhVE13TjB0c1lsazJhbnBOVUZSTVIwNWlWRTFTTlZSNmRYcHRNaTEwV2tob2RUZFRZMnd3U25Gc1dUMD0ifQ.pDkJavxNCKxNnnPt7wx3bzFKbK8_EI3wiIRUryHIS6Q";

    // try
     {
      final response = await http.get(
          Uri.parse(
              'http://192.168.29.160:8000/api/v1/level-2/parent/new-child/?format=api'),
          headers: {"Authorization": 'Bearer $token'});

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        log(response.body);
        setState(() {
          data = data;
        });
      } else {
        log('Request failed with status: ${response.statusCode}');
      }
    } 
    // catch (e) {
    //   log('Exception occured: $e');
    // }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 145, 45, 226),
        leading: Icon(
          Icons.keyboard_arrow_left_rounded,
          size: 40,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_active,
              size: 40,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        color: Color.fromARGB(255, 145, 45, 226),
                        padding: EdgeInsets.all(16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (selectedDate != null)
                                Text(
                                  ' ${selectedDate!.day} - ${selectedDate!.month} - ${selectedDate!.year}',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              Row(
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ElevatedButton(
                                        onPressed: _showDatePicker,
                                        child: Text("march  28")),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/Screenshot 2024-08-30 105520.png"))),
                      ),
                      Column(
                        children: [
                          Text("Are you have a"),
                          Text("fasting today?")
                        ],
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 40,
                        color: Color.fromARGB(255, 171, 36, 36),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Schedules",
                            style: TextStyle(
                                color: Color.fromARGB(255, 2, 4, 6),
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: FutureBuilder(
                          future: getdata(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return ListView.builder(
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Container(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  snapshot.toString()),
                                              radius: 24,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Title(
                                                  color: Colors.green,
                                                  child:
                                                      Text(snapshot.toString()))
                                              // Text(snapshot.toString())
                                              // Text(
                                              //   "suhoor",
                                              //   style: TextStyle(
                                              //       fontWeight: FontWeight.w600,
                                              //       fontSize: 19),
                                              // ),
                                              // Text(
                                              //   "02:00 AM - 04:36PM",
                                              //   style: TextStyle(
                                              //       color:
                                              //           Color.fromARGB(255, 131, 91, 111),
                                              //       fontSize: 13,
                                              //       fontWeight: FontWeight.w500),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

ListUsers listUsersFromJson(String str) => ListUsers.fromJson(json.decode(str));

String listUsersToJson(ListUsers data) => json.encode(data.toJson());

class ListUsers {
  String? detail;

  ListUsers({
    this.detail,
  });

  factory ListUsers.fromJson(Map<String, dynamic> json) => ListUsers(
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
      };
}
