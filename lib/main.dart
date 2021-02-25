import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sigma_test/db/db_helper.dart';
import 'package:sigma_test/model/sigmat.dart';
import 'package:sigma_test/services/sigmaapi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sigma',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Sigma Tenant Task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceSize = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: FutureBuilder<List<SigmaModel>>(
          future: SigmaApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<SigmaModel> data = snapshot.data;
              return ListView.builder(
                  itemCount:data.length,
                  itemBuilder:(context,index){
                    final sigmadb = SigmaModel(id: data[index].id,
                        description: data[index].description,
                        displayName: data[index].displayName,
                    meta: data[index].meta,v: data[index].v
                    );
                    DBProvider.db.insertSigmaData(sigmadb);
                    print(DBProvider.db.readSigmaData());
                    return Container(
                      padding: EdgeInsets.only(top: deviceSize.size.height*0.04),
                      width: double.infinity,
                      color: Colors.white,
                      height: deviceSize.size.height*0.35,
                      child: Neumorphic(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: deviceSize.size.height*0.02,),
                            Padding(
                              padding: EdgeInsets.only(left:  deviceSize.size.width*0.02),
                              child: Neumorphic(

                                child: Container(
                                    padding: EdgeInsets.symmetric(vertical:  deviceSize.size.height*0.01,horizontal:  deviceSize.size.width*0.01),
                                    height: deviceSize.size.height*0.05,
                                    child: Text(data[index].displayName,style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink
                                    ),)),
                              ),
                            ),
                            SizedBox(height: deviceSize.size.height*0.02,),
                            Text(data[index].meta,style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: deviceSize.size.height*0.02,),
                            Text(data[index].description),
                            SizedBox(height: deviceSize.size.height*0.02,),
                           Text("Spaces",
                             style: TextStyle(
                               color: Colors.pinkAccent,
                               fontWeight: FontWeight.w400
                           ),),
                          ],
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        )
      ),

    );
  }
}
