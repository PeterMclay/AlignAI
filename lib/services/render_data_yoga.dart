import 'package:flutter/material.dart';

class RenderDataYoga extends StatefulWidget {
  final List<dynamic> data;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  RenderDataYoga(
      {this.data, this.previewH, this.previewW, this.screenH, this.screenW});
  @override
  _RenderDataYogaState createState() => _RenderDataYogaState();
}

class _RenderDataYogaState extends State<RenderDataYoga> {
  Map<String, List<double>> inputArr;

  String excercise = 'warrior';
  Color correctColor;
  Color armColor, shoulderColor, legColor;
  String memo = 'Warrior position not aligned.';

  double leftShoulderY,
      rightShoulderY,
      leftWristX,
      leftWristY,
      rightWristX,
      rightWristY,
      leftAnkleX,
      rightAnkleX,
      leftKneeY,
      leftHipY;

  bool wristAlignment, shoulderAlignment, ankleAlignment, kneeAndHipAlignment;

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
    correctColor = Colors.red;
    wristAlignment = false;
    shoulderAlignment = false;
    ankleAlignment = false;
    kneeAndHipAlignment = false;
    armColor = Colors.red;
    shoulderColor = Colors.red;
    legColor = Colors.red;
    super.initState();
  }

  void _postureAccordingToExercise(Map<String, List<double>> poses) {
    setState(() {
      leftShoulderY = poses['leftShoulder'][1];
      rightShoulderY = poses['rightShoulder'][1];
      leftWristX = poses['leftWrist'][0];
      leftWristY = poses['leftWrist'][1];
      rightWristX = poses['rightWrist'][0];
      rightWristY = poses['leftWrist'][1];
      leftAnkleX = poses['leftAnkle'][0];
      rightAnkleX = poses['rightAnkle'][0];
      leftKneeY = poses['leftKnee'][1];
      leftHipY = poses['leftHip'][1];
    });

    if (leftWristY > 120 &&
        rightWristY > 120 &&
        leftWristX < 255 &&
        leftWristX > 200 &&
        rightWristX < 255 &&
        rightWristX > 160) {
      wristAlignment = true;
      setState(() {
        armColor = Colors.green;
        shoulderColor = Colors.green;
      });
    } else {
      wristAlignment = false;
      setState(() {
        armColor = Colors.red;
        shoulderColor = Colors.red;
      });
    }
    if (leftAnkleX > 360 && rightAnkleX < 60) {
      ankleAlignment = true;
      setState(() {
        legColor = Colors.green;
      });
    } else {
      ankleAlignment = false;
      setState(() {
        legColor = Colors.red;
      });
    }
    if (leftKneeY > 580 && leftHipY > 505) {
      kneeAndHipAlignment = true;
      setState(() {
        //legColor = Colors.green;
      });
    } else {
      kneeAndHipAlignment = false;
      setState(() {
        legColor = Colors.red;
      });
    }
    if (wristAlignment && ankleAlignment && kneeAndHipAlignment) {
      setState(() {
        correctColor = Colors.green;
        memo = 'Warrior position aligned!';
      });
    } else {
      setState(() {
        correctColor = Colors.red;
        memo = 'Warrior position not aligned.';
      });
    }
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

        _postureAccordingToExercise(inputArr);
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
              painter: MyPainter(
                  left: leftShoulderPos,
                  right: rightShoulderPos,
                  color: shoulderColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftElbowPos, right: leftShoulderPos, color: armColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftWristPos, right: leftElbowPos, color: armColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: rightElbowPos,
                  right: rightShoulderPos,
                  color: armColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: rightWristPos, right: rightElbowPos, color: armColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftShoulderPos,
                  right: leftHipPos,
                  color: shoulderColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftHipPos, right: leftKneePos, color: legColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftKneePos, right: leftAnklePos, color: legColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: rightShoulderPos,
                  right: rightHipPos,
                  color: shoulderColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: rightHipPos, right: rightKneePos, color: legColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: rightKneePos, right: rightAnklePos, color: legColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftHipPos, right: rightHipPos, color: shoulderColor),
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
                  //'$whatToDo\nArm Presses: ${_counter.toString()}',
                  '$memo',
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
  Color color;
  MyPainter({this.left, this.right, this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(left.x, left.y);
    final p2 = Offset(right.x, right.y);
    final paint = Paint()
      ..color = color //Colors.blue
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
