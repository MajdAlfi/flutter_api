import 'package:flutter/material.dart';
import 'package:flutter_api/src/Names/Models/get_set_data.dart';
import 'package:flutter_api/src/Names/Services/Names_Services.dart';
import '../Models/Models.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var Limit = ["5", "10", "100"].map<DropdownMenuItem<String>>((String limitX) {
    return DropdownMenuItem(child: Text(limitX), value: limitX);
  }).toList();
  var Gender = ["M", "F", "O"].map<DropdownMenuItem<String>>((String gen) {
    return DropdownMenuItem(child: Text(gen), value: gen);
  }).toList();
  var SortBy =
      ["positive", "negative"].map<DropdownMenuItem<String>>((String sort) {
    return DropdownMenuItem(child: Text(sort), value: sort);
  }).toList();
  namesServices _services = namesServices();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                      items: Limit,
                      value: Values.LimitV,
                      onChanged: (String? newValue) {
                        setState(() {
                          Values.LimitV = newValue!;
                        });
                      }),
                  DropdownButton(
                      items: Gender,
                      value: Values.GenderV,
                      onChanged: (String? newValue) {
                        setState(() {
                          Values.GenderV = newValue!;
                        });
                      }),
                  DropdownButton(
                      items: SortBy,
                      value: Values.SortV,
                      onChanged: (String? newValue) {
                        setState(() {
                          Values.SortV = newValue!;
                        });
                      }),
                  // Container(
                  //   height: 50,
                  //   width: 80,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(12)),
                  //       color: Colors.blue),
                  //   child: TextButton(
                  //     child: Text(
                  //       "Submit",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w600,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     onPressed: null,
                  //   ),
                  //         )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: FutureBuilder<Names_Kurd>(
                      future: _services.fetchListNames(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else if (snapshot.data == null) {
                          return Text("No Data Found");
                        }
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              leading: Text(snapshot
                                  .data!.names[index].positive_votes
                                  .toString()),
                              title: Text(
                                  snapshot.data!.names[index].name.toString()),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snapshot.data!.names[index].desc
                                      .toString()),
                                )
                              ],
                            );
                          },
                          itemCount: snapshot.data!.names.length,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
