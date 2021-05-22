import 'dart:ui';

import 'package:driver_app/models/cars_model.dart';
import 'package:driver_app/models/ridedetailsmodel.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/material.dart';

// class TimeLine extends StatefulWidget {
//   @override
//   _TimeLineState createState() => _TimeLineState();
// }

// class _TimeLineState extends State<TimeLine> with TickerProviderStateMixin {
//    AnimationController animationController;
//    AnimationController animationTextController;
//
//    Animation<double> doubleTweenAnimation;
//
//    ScrollController scrollController;
//    PageController pageController;
//    List<Car> listCars;
//    List<RideDetails> _rideDetails;
//   bool isOpen = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     scrollController = ScrollController(initialScrollOffset: 0);
//
//     pageController = PageController()
//       ..addListener(() {
//         setState(() {});
//       });
//     animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 800),
//     );
//     animationTextController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 400),
//     );
//
//     doubleTweenAnimation = Tween<double>(begin: 0.0, end: 1.0)
//         .chain(CurveTween(curve: Curves.fastOutSlowIn))
//         .animate(animationTextController);
//     doubleTweenAnimation.addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     animationTextController.dispose();
//     pageController.dispose();
//
//     // TODO: review if all controllers are disposed
//
//     super.dispose();
//   }
//
//   @override
//   // Widget build(BuildContext context) {
//   //   final size = MediaQuery.of(context).size;
//   //   double altura = size.height * 0.6;
//   //   listCars = _createCars();
//   //   _rideDetails = _createRide();
//   //   return Material(
//   //     child: Stack(
//   //       children: [
//   //         Container(
//   //             margin: EdgeInsets.only(top: 50),
//   //             alignment: Alignment.topCenter,
//   //             height: size.height * 0.3,
//   //             child: Image.asset('images/greencar.png')),
//   //         PageView.builder(
//   //             scrollDirection: Axis.horizontal,
//   //             controller: pageController,
//   //             itemCount: 13,
//   //             itemBuilder: (context, index) {
//   //               double page = 0;
//   //               if (!pageController.position.hasContentDimensions) {
//   //                 page = 0.0;
//   //               } else {
//   //                 page = pageController.page;
//   //               }
//   //               page = page ?? 0;
//   //               final aux = (1 - (page - index)).clamp(0, 1).toDouble();
//   //               return Transform.rotate(
//   //                 alignment: Alignment.bottomRight,
//   //                 angle: vector.radians((1 - aux) * -15),
//   //                 child: Opacity(
//   //                   opacity: aux,
//   //                   child: Container(
//   //                     child: GestureDetector(
//   //                       // TODO: Remove OnTap, add onVerticalDrag... functionality
//   //                       onTap: () {
//   //                         isOpen = !isOpen;
//   //                         if (isOpen) {
//   //                           animationController.forward();
//   //                           animationTextController.reverse();
//   //                         } else {
//   //                           scrollController.animateTo(0.0,
//   //                               duration: Duration(milliseconds: 300),
//   //                               curve: Curves.linear);
//   //                           animationController.reverse();
//   //                           animationTextController.reset();
//   //                         }
//   //                         setState(() {});
//   //                       },
//   //                       child: AnimatedBuilder(
//   //                           animation: animationController,
//   //                           builder: (context, snapshopt) {
//   //                             final value = animationController.value;
//   //                             return Container(
//   //                               child: Column(
//   //                                 mainAxisAlignment: MainAxisAlignment.end,
//   //                                 children: [
//   //                                   Container(
//   //                                     alignment: Alignment.topCenter,
//   //                                     height: lerpDouble(altura, size.height,
//   //                                         value.toDouble()),
//   //                                     decoration: BoxDecoration(
//   //                                       borderRadius: BorderRadius.vertical(
//   //                                           top: Radius.circular(
//   //                                               lerpDouble(50, 0, value) ?? 0)),
//   //                                       gradient: this._getBackground(
//   //                                         animationController.value,
//   //                                         animationTextController,
//   //                                       ),
//   //                                     ),
//   //                                     child: SingleChildScrollView(
//   //                                       physics: isOpen
//   //                                           ? null
//   //                                           : NeverScrollableScrollPhysics(),
//   //                                       controller: scrollController,
//   //                                       child: buildCarsPages(
//   //                                         size,
//   //                                         index,
//   //                                         isOpen ? Colors.black : Colors.white,
//   //                                         animationController.value,
//   //                                         doubleTweenAnimation,
//   //                                         animationTextController,
//   //                                       ),
//   //                                     ),
//   //                                   ),
//   //                                 ],
//   //                               ),
//   //                             );
//   //                           }),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               );
//   //             }),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   RadialGradient _getBackground(
//     double animationControllerValue,
//     AnimationController animationTextController,
//   ) {
//     // TODO: improve bottom animation (in the original the radius seems bigger )
//
//     if (animationControllerValue == 1) {
//       animationTextController.forward();
//     }
//     print(animationControllerValue);
//     double stops = lerpDouble(0.0002, 0.02, animationControllerValue * 50);
//
//     return RadialGradient(
//       center: Alignment.bottomCenter,
//       radius: 2.5 * (animationControllerValue - 0.1),
//       colors: [
//         Colors.white,
//         Colors.black,
//       ],
//       stops: [
//         lerpDouble(0.00001, 1, animationControllerValue) ?? 1,
//         lerpDouble(stops, 1, animationControllerValue) ?? 10,
//       ],
//     );
//   }
//
//   // LINEAR GRADIENT OPTION: I like it more but isnt like the original inspiration
//   /*LinearGradient _getBackground(
//     animationControllerValue,
//     AnimationController animationTextController,
//   ) {
//     if (animationControllerValue == 1) {
//       animationTextController.forward();
//     }
//
//     double? num = lerpDouble(0.0002, 0.02, animationControllerValue * 50);
//     return LinearGradient(
//       colors: [
//         Colors.white,
//         Colors.black,
//       ],
//       stops: [
//         lerpDouble(0.00001, 1, animationControllerValue) ?? 1,
//         lerpDouble(num, 1, animationControllerValue) ?? 10,
//       ],
//       begin: Alignment.bottomCenter,
//       end: Alignment.topCenter,
//     );
//   }
//   */
//
//   Column buildCarsPages(
//       Size size,
//       int index,
//       Color textColor,
//       double controllerValue,
//       Animation<double> doubleTweenAnimation,
//       AnimationController animationTextController) {
//     // TODO: improve the scroll and reverse when isOpen == false again
//     // TODO: improve text change color
//     if (controllerValue == 1) {
//       animationTextController.forward();
//     } else {
//       animationTextController.reverse();
//     }
//
//     double value = 1;
//
//     if (controllerValue > 0.5) {
//       value = lerpDouble(1, 2, (controllerValue - 0.5));
//     }
//
//     final String loremText =
//         "\n\nDescription \n\n Est ei erat mucius quaeque. Ei his quas phaedrum, efficiantur mediocritatem ne sed, hinc oratio blandit ei sed. Blandit gloriatur eam et. Brute noluisse per et, verear disputando neglegentur at quo. Sea quem legere ei, unum soluta ne duo. Ludus complectitur quo te, ut vide autem homero pro. In mel saperet expetendis. Vitae urbanitas sadipscing nec ut, at vim quis lorem labitur. Exerci electram has et, vidit solet tincidunt quo ad, moderatius contentiones nec no. Nam et puto abhorreant scripserit, et cum inimicus accusamus. Virtute equidem ceteros in mel. Id volutpat neglegentur eos. Eu eum facilisis voluptatum, no eam albucius verterem. Sit congue platonem adolescens ut. Offendit reprimique et has, eu mei homero imperdiet.";
//     // return Column(
//     //   children: [
//     //     Container(
//     //       width: size.width * 0.1,
//     //       height: 2,
//     //       color: Colors.grey,
//     //       margin: EdgeInsets.only(top: 10),
//     //     ),
//     //     Container(
//     //       margin: EdgeInsets.only(top: 50, left: 50),
//     //       alignment: Alignment.centerLeft,
//     //       child: Text(
//     //         listCars[index].model,
//     //         style: TextStyle(
//     //             color: textColor, fontSize: 50, fontFamily: 'JosefinSans'),
//     //       ),
//     //     ),
//     //     Container(
//     //       width: 250 * (value != null ? value : 0),
//     //       height: 250,
//     //       color: Colors.transparent,
//     //       child: Image.asset(listCars[index].imgUrl, fit: BoxFit.contain),
//     //     ),
//     //     Container(
//     //       alignment: Alignment.bottomCenter,
//     //       color: Colors.transparent,
//     //       child: Text(
//     //         listCars[index].name,
//     //         style: TextStyle(
//     //             color: textColor, fontSize: 50, fontFamily: 'JosefinSans'),
//     //       ),
//     //     ),
//     //     SizedBox(
//     //       height: lerpDouble(700, 50, doubleTweenAnimation.value),
//     //     ),
//     //     Container(
//     //       child: ClipRRect(
//     //         borderRadius: BorderRadius.circular(10),
//     //         child: MaterialButton(
//     //           color: Color.fromRGBO(43, 154, 214, 1),
//     //           height: 50,
//     //           minWidth: 200,
//     //           elevation: 10,
//     //           textColor: Colors.white,
//     //           onPressed: () {
//     //
//     //           },
//     //           child: Text('Request Ride'),
//     //         ),
//     //       ),
//     //     ),
//     //     Container(
//     //       padding: EdgeInsets.all(20),
//     //       child: ClipRRect(
//     //         borderRadius: BorderRadius.circular(10),
//     //         child: MaterialButton(
//     //           color: Color.fromRGBO(43, 154, 214, 1),
//     //           height: 50,
//     //           minWidth: 200,
//     //           elevation: 10,
//     //           textColor: Colors.white,
//     //           onPressed: () {
//     //             //TODO : show TestDrive video (assets/videos/...)
//     //           },
//     //           child: Text('Contact'),
//     //         ),
//     //       ),
//     //     ),
//     //     SizedBox(
//     //       height: lerpDouble(300, 20, doubleTweenAnimation.value),
//     //     ),
//     //     Container(
//     //       child: DataTable(
//     //         columns: const <DataColumn>[
//     //           DataColumn(
//     //             label: Text(
//     //               'Specs',
//     //               style: TextStyle(fontStyle: FontStyle.italic),
//     //             ),
//     //           ),
//     //           DataColumn(
//     //             label: Text(
//     //               'Value',
//     //               style: TextStyle(fontStyle: FontStyle.italic),
//     //             ),
//     //           ),
//     //         ],
//     //         rows:  <DataRow>[
//     //           DataRow(
//     //             cells: <DataCell>[
//     //               DataCell(Text('Ride From')),
//     //               DataCell(Text(_rideDetails[index].fromplace)),
//     //             ],
//     //           ),
//     //           DataRow(
//     //             cells: <DataCell>[
//     //               DataCell(Text('Ride To')),
//     //               DataCell(Text(_rideDetails[index].toplace)),
//     //             ],
//     //           ),
//     //           DataRow(
//     //             cells: <DataCell>[
//     //               DataCell(Text('Fuel consumption')),
//     //               DataCell(Text('13.4 l/100 km')),
//     //             ],
//     //           ),
//     //           DataRow(
//     //             cells: <DataCell>[
//     //               DataCell(Text('Per Person')),
//     //               DataCell(Text('₹700')),
//     //             ],
//     //           ),
//     //           DataRow(
//     //             cells: <DataCell>[
//     //               DataCell(Text('Capacity')),
//     //               DataCell(Text('4')),
//     //             ],
//     //           ),
//     //           DataRow(
//     //             cells: <DataCell>[
//     //               DataCell(Text('Body type')),
//     //               DataCell(Text('Sedan')),
//     //             ],
//     //           ),
//     //           DataRow(
//     //             cells: <DataCell>[
//     //               DataCell(Text('Gender Preference')),
//     //               DataCell(Text('Unisex')),
//     //             ],
//     //           ),
//     //           DataRow(
//     //             cells: <DataCell>[
//     //               DataCell(Text('Pet Friendly')),
//     //               DataCell(Text('No')),
//     //             ],
//     //           ),
//     //           DataRow(
//     //             cells: <DataCell>[
//     //               DataCell(Text('Body type')),
//     //               DataCell(Text('Sedan')),
//     //             ],
//     //           ),
//     //           DataRow(
//     //             cells: <DataCell>[
//     //               DataCell(Text('Detour')),
//     //               DataCell(Text('No')),
//     //             ],
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //   ],
//     // );
//   }
// }

// List<Car> _createCars() {
//   List<Car> lista = [];
//
//
//   lista.add(
//     Car(
//         id: 9,
//         imgUrl: 'assets/images/car9.png',
//         model: '2021',
//         name: 'Supersonic LM'),
//   );
//   lista.add(
//     Car(
//         id: 10,
//         imgUrl: 'assets/images/car10.png',
//         model: '2021',
//         name: 'Supersonic LM'),
//   );
//   lista.add(
//     Car(
//         id: 11,
//         imgUrl: 'assets/images/car11.png',
//         model: '2021',
//         name: 'Supersonic LM'),
//   );
//   lista.add(
//     Car(
//         id: 12,
//         imgUrl: 'assets/images/car12.png',
//         model: '2021',
//         name: 'Supersonic LM'),
//   );
//   lista.add(
//     Car(
//         id: 13,
//         imgUrl: 'assets/images/car13.png',
//         model: '2021',
//         name: 'Supersonic LM'),
//   );
//   lista.add(
//     Car(
//         id: 1,
//         imgUrl: 'assets/images/car1.png',
//         model: '2021',
//         name: 'Combat XM'),
//   );
//   lista.add(
//     Car(
//         id: 2,
//         imgUrl: 'assets/images/car2.png',
//         model: '2020',
//         name: 'Supreme'),
//   );
//   lista.add(
//     Car(
//         id: 3,
//         imgUrl: 'assets/images/car3.png',
//         model: '2021',
//         name: 'XMM Turbo'),
//   );
//   lista.add(
//     Car(
//         id: 4,
//         imgUrl: 'assets/images/car4.png',
//         model: '2021',
//         name: 'Supersonic LM'),
//   );
//   lista.add(
//     Car(
//         id: 5,
//         imgUrl: 'assets/images/car5.png',
//         model: '2021',
//         name: 'Supersonic LM'),
//   );
//   lista.add(
//     Car(
//         id: 6,
//         imgUrl: 'assets/images/car6.png',
//         model: '2021',
//         name: 'Supersonic LM'),
//   );
//   lista.add(
//     Car(
//         id: 7,
//         imgUrl: 'assets/images/car7.png',
//         model: '2021',
//         name: 'Supersonic LM'),
//   );
//   lista.add(
//     Car(
//         id: 8,
//         imgUrl: 'assets/images/car8.png',
//         model: '2021',
//         name: 'Supersonic LM'),
//   );
//
//
//   return lista;
// }
List<RideDetails> _createRide() {
  List<RideDetails> lista = [];

  lista.add(
    RideDetails(
        id: 1,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  );
  lista.add(
    RideDetails(
        id: 2,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  );
  lista.add(
    RideDetails(
        id: 3,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  ); lista.add(
    RideDetails(
        id: 4,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  ); lista.add(
    RideDetails(
        id: 5,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  ); lista.add(
    RideDetails(
        id: 6,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  ); lista.add(
    RideDetails(
        id: 7,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  ); lista.add(
    RideDetails(
        id: 8,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  ); lista.add(
    RideDetails(
        id: 9,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  ); lista.add(
    RideDetails(
        id: 10,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  ); lista.add(
    RideDetails(
        id: 11,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  ); lista.add(
    RideDetails(
        id: 12,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  );
  lista.add(
    RideDetails(
        id: 13,
        fromplace: 'Tirur',
        toplace: 'Calicut',
        date: '12/12/2000'),
  );

  return lista;
}
