import 'package:flutter/material.dart';
import 'package:github_flutter/providers/repo_provider.dart';
import 'package:github_flutter/screen/info_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RepositiriesScreen extends StatefulWidget {
  String username;

  RepositiriesScreen(this.username);

  @override
  _RepositiriesScreenState createState() => _RepositiriesScreenState();
}

class _RepositiriesScreenState extends State<RepositiriesScreen> {
  var _init = true;
  var _isLoading = false;
  var repoData;
  var dateF;
  List<Widget> L = List<Widget>();
  void demo() async{
    await Carou();
  }
  void Carou() {
    for (int index = 0; index < repoData.repoList.length; index++) {
      L.add(
        InkWell(
          onTap: ()  {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => InfoScreen(repoData.repoList[index].repo_name,
                    repoData.repoList[index].url)));
          },
          child: Container(
            //width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffd9d9d9), width: 2),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    width: double.infinity,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          repoData.repoList[index].repo_name,textAlign:TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900),
                      ),
                    )),

                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Created :',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff595959)),
                      ),
                      Text(dateF.format(DateTime.parse(
                          repoData.repoList[index].created_date)))
                    ],
                  ),
                ),
                repoData.repoList[index].description == null
                    ? Container()
                    : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Description :',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff595959)),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          child:
                          Text(repoData.repoList[index].description))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Last Pushed : ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff595959)),
                      ),
                      Text(dateF.format(
                          DateTime.parse(repoData.repoList[index].last_pushed)))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Branch : ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff595959)),
                      ),
                      Text(repoData.repoList[index].branch)
                    ],
                  ),
                ),
                Container(
                  //  height: 40,
                    width: double.infinity,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              'Stars: ${repoData.repoList[index].stars.toString()}',style: TextStyle(color: Colors.white)),
                          repoData.repoList[index].language == null
                              ? Text('None')
                              : Text(repoData.repoList[index].language,style: TextStyle(color: Colors.white),),
                          //ternary operator
                        ],
                      ),
                    )),
//                        Text('${url}')
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<RepositriesProvider>(context)
          .getRepositriesList(widget.username)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    L=[];
    repoData = Provider.of<RepositriesProvider>(context);
    dateF = new DateFormat.yMMMMd("en_US");
    demo();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
//        backgroundColor: Color(0xff330033),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff33ffff), Color(0xff000099)],
              begin: FractionalOffset.topRight,
              end: FractionalOffset.bottomLeft,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Center(
        child: CarouselSlider(
            options: CarouselOptions(
              // aspectRatio: 3,
              height: MediaQuery.of(context).size.height * 0.8,
              enlargeCenterPage: true,
              autoPlay: true,
            ),
            items: L),
      ),
    );
  }
}