// import 'package:BrandFarm/blocs/weather/bloc.dart';
// import 'package:BrandFarm/screens/facility/facility_home.dart';
// import 'package:BrandFarm/utils/unicode/unicode_util.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class FMHomeScreenWidget extends StatefulWidget {
//   @override
//   _FMHomeScreenWidgetState createState() => _FMHomeScreenWidgetState();
// }
//
// class _FMHomeScreenWidgetState extends State<FMHomeScreenWidget> {
//   String fieldListOptions = '거리순';
//   int index = 2;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14.0),
//               border: Border.all(color: Theme.of(context).dividerColor)),
//           padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Image.asset(
//                         'assets/brandfarm.png',
//                         height: 21.0,
//                         width: 17.0,
//                       ),
//                       SizedBox(
//                         width: 6,
//                       ),
//                       Text(
//                         '농장 관리',
//                         style: Theme.of(context).textTheme.headline5,
//                       )
//                     ],
//                   ),
//                   Container(
//                     height: 23,
//                     width: 65,
//                     color: Colors.white,
//                     child: RaisedButton(
//                       elevation: 0.0,
//                       color: Colors.white,
//                       padding: EdgeInsets.all(2),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(color: Color(0xFFD6D6D6)),
//                       ),
//                       child: FittedBox(
//                         child: Row(
//                           children: [
//                             Text(fieldListOptions),
//                             Icon(Icons.keyboard_arrow_down),
//                           ],
//                         ),
//                       ),
//                       onPressed: () {
//                         _settingModalBottomSheet(context);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               ListView.builder(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: 5,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       SizedBox(height: 18.0,),
//                       (index == 0)
//                       ? CardWthBgImage()
//                       : CardWthDefaultImage(),
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 100,)
//       ],
//     );
//   }
//
//   Widget CardWthBgImage() {
//     return InkWell(
//       onTap: (){
//         Navigator.of(context).push(
//             PageRouteBuilder(
//               transitionDuration: Duration(milliseconds: 300),
//               pageBuilder: (_, __, ___) => BlocProvider(
//                 create: (BuildContext context) =>
//                 WeatherBloc()..add(Wait_Fetch_Weather()),
//                 child: FacilityHome(),
//               ),
//               fullscreenDialog: true,
//               transitionsBuilder: (
//                   BuildContext context,
//                   Animation<double> animation,
//                   Animation<double> secondaryAnimation,
//                   Widget child,
//                   ) =>
//                   FadeTransition(
//                     opacity: animation,
//                     child: child,
//                   ),
//             ));
//       },
//       child: Hero(
//         tag: 123,
//         child: Material(
//           type: MaterialType.transparency,
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 image: DecorationImage(
//                   colorFilter: ColorFilter.mode(
//                       Colors.black.withOpacity(0.4), BlendMode.darken),
//                   image: AssetImage("assets/strawberry_farm.png"),
//                   fit: BoxFit.cover,
//                   alignment: Alignment.bottomLeft,
//                 )
//             ),
//             padding: EdgeInsets.all(8),
//             // margin: EdgeInsets.all(8),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       '한동이네 딸기 농장',
//                       style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white)
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       '16',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 36,
//                         color: Colors.white
//                       ),
//                     ),
//                     Container(
//                       height: 30,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             degrees + 'C',
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Icon(CupertinoIcons.sun_max, color: Colors.white,),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       '경북 포항시',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget CardWthDefaultImage() {
//     return InkWell(
//       onTap: (){
//
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//               scale: 1.2,
//               image: AssetImage("assets/default_card_bg_image.png"),
//               alignment: Alignment.bottomLeft,
//             ),
//           borderRadius: BorderRadius.circular(15.0),
//           border: Border.all(color: Theme.of(context).dividerColor),
//         ),
//         // padding: EdgeInsets.all(8),
//         padding: EdgeInsets.all(8),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   '한동이네 딸기 농장',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF37949B),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   '16',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 30,
//                   ),
//                 ),
//                 Container(
//                   height: 30,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         degrees + 'C',
//                         style: TextStyle(
//                           fontSize: 15,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(CupertinoIcons.sun_max),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   '경북 포항시',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _settingModalBottomSheet(context) {
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         context: context,
//         builder: (BuildContext bc) {
//           return new Wrap(
//             children: <Widget>[
//               ListTile(
//                   leading: Text('가나다순'),
//                   title: Text(''),
//                   trailing: (index == 1)
//                       ? Icon(Icons.check)
//                       : Container(height: 1, width: 1,),
//                   onTap: () => {
//                         Navigator.pop(context),
//                     setState(() {
//                       fieldListOptions = '가나다순';
//                       index = 1;
//                     }),
//                   }),
//               Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
//               ListTile(
//                 leading: Text('거리순'),
//                 title: Text(''),
//                 trailing: (index == 2)
//                     ? Icon(Icons.check)
//                     : Container(height: 1, width: 1,),
//                 onTap: () => {
//                   Navigator.pop(context),
//                   setState(() {
//                     fieldListOptions = '거리순';
//                     index = 2;
//                   }),
//                 },
//               ),
//               Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
//               ListTile(
//                 leading: Text('최근 열람순'),
//                 title: Text(''),
//                 trailing: (index == 3)
//                     ? Icon(Icons.check)
//                     : Container(height: 1, width: 1,),
//                 onTap: () => {
//                   Navigator.pop(context),
//                   setState(() {
//                     fieldListOptions = '최근 열람순';
//                     index = 3;
//                   }),
//                 },
//               ),
//               Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
//               ListTile(
//                 leading: Text('잘생긴순'),
//                 title: Text(''),
//                 trailing: (index == 4)
//                     ? Icon(Icons.check)
//                     : Container(height: 1, width: 1,),
//                 onTap: () => {
//                   Navigator.pop(context),
//                 setState(() {
//                   fieldListOptions = '잘생긴순';
//                   index = 4;
//                 }),
//                 },
//               ),
//               Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
//             ],
//           );
//         });
//   }
// }
