import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RenderData extends StatefulWidget {
  final List<dynamic> data;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  RenderData(
      {this.data, this.previewH, this.previewW, this.screenH, this.screenW});
  @override
  _RenderDataState createState() => _RenderDataState();
}

class _RenderDataState extends State<RenderData> {
  Map<String, List<double>> inputArr;

  String excercise = 'squat';
  double upperRange = 300;
  double lowerRange = 500;
  bool midCount, isCorrectPosture;
  int _counter;
  Color correctColor;
  double shoulderLY;
  double shoulderRY;
  double kneeRY;
  double kneeLY;
  bool squatUp;
  String whatToDo = 'Finding Posture';

  var leftEyePos = Vector(0, 0);
  var rightEyePos = Vector(0, 0);
  var leftShoulderPos = Vector(0, 0);
  var rightShoulderPos = Vector(0, 0);
  var leftHipPos = Vector(0, 0);
  var rightHipPos = Vector(0, 0);
  var leftElbowPos = Vector(0, 0);
  var rightElbowPos = Vector(0, 0);
  var leftWristPos = Vector(0, 0);
  var rightWristPos = Vector(0, 0);
  var leftKneePos = Vector(0, 0);
  var rightKneePos = Vector(0, 0);
  var leftAnklePos = Vector(0, 0);
  var rightAnklePos = Vector(0, 0);

  @override
  void initState() {
    inputArr = new Map();
    midCount = false;
    isCorrectPosture = false;
    _counter = 0;
    correctColor = Colors.red;
    shoulderLY = 0;
    shoulderRY = 0;
    kneeRY = 0;
    kneeLY = 0;
    squatUp = true;
    super.initState();
  }

  bool _postureAccordingToExercise(Map<String, List<double>> poses) {
    setState(() {
      shoulderLY = poses['leftShoulder'][1];
      shoulderRY = poses['rightShoulder'][1];
      kneeLY = poses['leftKnee'][1];
      kneeRY = poses['rightKnee'][1];
    });
    if (excercise == 'squat') {
      if (squatUp) {
        return poses['leftShoulder'][1] < 320 &&
            poses['leftShoulder'][1] > 280 &&
            poses['rightShoulder'][1] < 320 &&
            poses['rightShoulder'][1] > 280 &&
            poses['rightKnee'][1] > 570 &&
            poses['leftKnee'][1] > 570;
      } else {
        return poses['leftShoulder'][1] > 475 &&
            poses['rightShoulder'][1] > 475;
      }
    }
  }

  _checkCorrectPosture(Map<String, List<double>> poses) {
    if (_postureAccordingToExercise(poses)) {
      if (!isCorrectPosture) {
        setState(() {
          isCorrectPosture = true;
          correctColor = Colors.green;
        });
      }
    } else {
      if (isCorrectPosture) {
        setState(() {
          isCorrectPosture = false;
          correctColor = Colors.red;
        });
      }
    }
  }

  Future<void> _countingLogic(Map<String, List<double>> poses) async {
    if (poses != null) {
      _checkCorrectPosture(poses);

      if (isCorrectPosture && squatUp && midCount == false) {
        //in correct initial posture
        setState(() {
          whatToDo = 'Squat Down';
          //correctColor = Colors.green;
        });
        squatUp = !squatUp;
        isCorrectPosture = false;
      }

      //lowered all the way
      if (isCorrectPosture && !squatUp && midCount == false) {
        midCount = true;
        isCorrectPosture = false;
        squatUp = !squatUp;
        setState(() {
          whatToDo = 'Go Up';
          //correctColor = Colors.green;
        });
      }

      //back up
      if (midCount &&
          poses['leftShoulder'][1] < 320 &&
          poses['leftShoulder'][1] > 280 &&
          poses['rightShoulder'][1] < 320 &&
          poses['rightShoulder'][1] > 280) {
        incrementCounter();
        midCount = false;
        squatUp = !squatUp;
        setState(() {
          //whatToDo = 'Go Up';
        });
      }
    }
  }

  void incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _getKeyPoints(k, x, y) {
      if (k["part"] == 'leftEye') {
        leftEyePos.x = x - 230;
        leftEyePos.y = y - 45;
      }
      if (k["part"] == 'rightEye') {
        rightEyePos.x = x - 230;
        rightEyePos.y = y - 45;
      }
      if (k["part"] == 'leftShoulder') {
        leftShoulderPos.x = x - 230;
        leftShoulderPos.y = y - 45;
      }
      if (k["part"] == 'rightShoulder') {
        rightShoulderPos.x = x - 230;
        rightShoulderPos.y = y - 45;
      }
      if (k["part"] == 'leftElbow') {
        leftElbowPos.x = x - 230;
        leftElbowPos.y = y - 45;
      }
      if (k["part"] == 'rightElbow') {
        rightElbowPos.x = x - 230;
        rightElbowPos.y = y - 45;
      }
      if (k["part"] == 'leftWrist') {
        leftWristPos.x = x - 230;
        leftWristPos.y = y - 45;
      }
      if (k["part"] == 'rightWrist') {
        rightWristPos.x = x - 230;
        rightWristPos.y = y - 45;
      }
      if (k["part"] == 'leftHip') {
        leftHipPos.x = x - 230;
        leftHipPos.y = y - 45;
      }
      if (k["part"] == 'rightHip') {
        rightHipPos.x = x - 230;
        rightHipPos.y = y - 45;
      }
      if (k["part"] == 'leftKnee') {
        leftKneePos.x = x - 230;
        leftKneePos.y = y - 45;
      }
      if (k["part"] == 'rightKnee') {
        rightKneePos.x = x - 230;
        rightKneePos.y = y - 45;
      }
      if (k["part"] == 'leftAnkle') {
        leftAnklePos.x = x - 230;
        leftAnklePos.y = y - 45;
      }
      if (k["part"] == 'rightAnkle') {
        rightAnklePos.x = x - 230;
        rightAnklePos.y = y - 45;
      }
    }

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      widget.data.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (widget.screenH / widget.screenW >
              widget.previewH / widget.previewW) {
            scaleW = widget.screenH / widget.previewH * widget.previewW;
            scaleH = widget.screenH;
            var difW = (scaleW - widget.screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = widget.screenW / widget.previewW * widget.previewH;
            scaleW = widget.screenW;
            var difH = (scaleH - widget.screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          inputArr[k['part']] = [x, y];
          //Mirroring
          if (x > 320) {
            var temp = x - 320;
            x = 320 - temp;
          } else {
            var temp = 320 - x;
            x = 320 + temp;
          }

          _getKeyPoints(k, x, y);

          if (k["part"] == 'leftEye') {
            leftEyePos.x = x - 230;
            leftEyePos.y = y - 45;
          }
          if (k["part"] == 'rightEye') {
            rightEyePos.x = x - 230;
            rightEyePos.y = y - 45;
          }
          return Positioned(
            left: x - 230,
            top: y - 50,
            width: 100,
            height: 15,
            child: Container(
                // child: Text(
                //   "● ${k["part"]}",
                //   style: TextStyle(
                //     color: Color.fromRGBO(37, 213, 253, 1.0),
                //     fontSize: 12.0,
                //   ),
                // ),
                ),
          );
        }).toList();

        _countingLogic(inputArr);
        inputArr.clear();

        lists..addAll(list);
      });
      //lists.clear();

      return lists;
    }

    return Stack(
      children: <Widget>[
        Stack(
          children: [
            CustomPaint(
              painter:
                  MyPainter(left: leftShoulderPos, right: rightShoulderPos),
            ),
            CustomPaint(
              painter: MyPainter(left: leftElbowPos, right: leftShoulderPos),
            ),
            CustomPaint(
              painter: MyPainter(left: leftWristPos, right: leftElbowPos),
            ),
            CustomPaint(
              painter: MyPainter(left: rightElbowPos, right: rightShoulderPos),
            ),
            CustomPaint(
              painter: MyPainter(left: rightWristPos, right: rightElbowPos),
            ),
            CustomPaint(
              painter: MyPainter(left: leftShoulderPos, right: leftHipPos),
            ),
            CustomPaint(
              painter: MyPainter(left: leftHipPos, right: leftKneePos),
            ),
            CustomPaint(
              painter: MyPainter(left: leftKneePos, right: leftAnklePos),
            ),
            CustomPaint(
              painter: MyPainter(left: rightShoulderPos, right: rightHipPos),
            ),
            CustomPaint(
              painter: MyPainter(left: rightHipPos, right: rightKneePos),
            ),
            CustomPaint(
              painter: MyPainter(left: rightKneePos, right: rightAnklePos),
            ),
            CustomPaint(
              painter: MyPainter(left: leftHipPos, right: rightHipPos),
            ),
          ],
        ),
        Stack(children: _renderKeypoints()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            width: widget.screenW,
            decoration: BoxDecoration(
              color: correctColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25)),
            ),
            child: Column(
              children: [
                Text(
                  '$whatToDo\nArm Presses: ${_counter.toString()}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Vector {
  double x, y;
  Vector(this.x, this.y);
}

class MyPainter extends CustomPainter {
  Vector left;
  Vector right;
  MyPainter({this.left, this.right});
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(left.x, left.y);
    final p2 = Offset(right.x, right.y);
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

// class MyPainter extends CustomPainter {
//   Vector leftShoulderPos;
//   Vector rightShoulderPos;
//   Vector leftHipPos;
//   Vector rightHipPos;
//   Vector leftElbowPos;
//   Vector rightElbowPos;
//   Vector leftWristPos;
//   Vector rightWristPos;
//   Vector leftKneePos;
//   Vector rightKneePos;
//   Vector leftAnklePos;
//   Vector rightAnklePos;
//   MyPainter(
//       {this.leftShoulderPos,
//       this.leftAnklePos,
//       this.leftElbowPos,
//       this.leftHipPos,
//       this.leftKneePos,
//       this.leftWristPos,
//       this.rightAnklePos,
//       this.rightElbowPos,
//       this.rightHipPos,
//       this.rightKneePos,
//       this.rightShoulderPos,
//       this.rightWristPos});
//   @override
//   void paint(Canvas canvas, Size size) {
//     final pointMode = ui.PointMode.polygon;
//     final points = [
//       Offset(leftWristPos.x, leftWristPos.y),
//       Offset(leftElbowPos.x, leftElbowPos.y),
//       Offset(leftShoulderPos.x, leftShoulderPos.y),
//       Offset(leftHipPos.x, leftHipPos.y),
//       Offset(leftKneePos.x, leftKneePos.y),
//       Offset(leftAnklePos.x, leftAnklePos.y),
//       Offset(rightHipPos.x, rightHipPos.y),
//       Offset(rightKneePos.x, rightKneePos.y),
//       Offset(rightAnklePos.x, rightAnklePos.y),
//       Offset(rightShoulderPos.x, rightShoulderPos.y),
//       Offset(rightElbowPos.x, rightElbowPos.y),
//       Offset(rightWristPos.x, rightWristPos.y),
//     ];
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 4
//       ..strokeCap = StrokeCap.round;
//     canvas.drawPoints(pointMode, points, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter old) {
//     return false;
//   }
// }

// CustomPaint(
//               painter: MyPainter(
//                   leftShoulderPos: leftShoulderPos,
//                   leftElbowPos: leftElbowPos,
//                   leftWristPos: leftWristPos,
//                   leftHipPos: leftHipPos,
//                   leftKneePos: leftKneePos,
//                   leftAnklePos: leftAnklePos,
//                   rightHipPos: rightHipPos,
//                   rightKneePos: rightKneePos,
//                   rightAnklePos: rightAnklePos,
//                   rightShoulderPos: rightShoulderPos,
//                   rightElbowPos: rightElbowPos,
//                   rightWristPos: rightWristPos),
//             ),
