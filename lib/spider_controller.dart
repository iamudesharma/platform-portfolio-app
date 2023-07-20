import 'dart:math';
import 'dart:ui_web';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rive/rive.dart';

class SpiderController {
  final StateMachineController _stateMachineController;
  late SMIInput<double> _speedInput;
  late SMIInput<double> _turnInput;
  late SMIInput<double> _rotateInput;
  late SMITrigger _leftClick;
  late SMITrigger _rightClick;

  SpiderController(this._stateMachineController) {
    _speedInput = _stateMachineController.findInput('Speed')!;
    _turnInput = _stateMachineController.findInput('Turn')!;
    _rotateInput = _stateMachineController.findInput('Rotate')!;
    _leftClick =
        _stateMachineController.findInput<bool>('LeftClick') as SMITrigger;
    _rightClick =
        _stateMachineController.findInput<bool>('RightClick')! as SMITrigger;
  }

  Offset spiderPosition = Offset.zero;
  Offset targetPosition = Offset.zero;
  double _targetRotation = 0;
  double _rotation = 0;

  double get rotation => _rotation;

  Offset _direction = Offset.zero;

  double get dx => spiderPosition.dx;
  double get dy => spiderPosition.dy;

  static const double _maxMovementSpeed = 300.0;
  double _movementSpeed = 0;
  static const double _maxRotationSpeed = 4;
  double _turnSpeed = 0;

  void leftClick() => _leftClick.fire();

  void rightClick() => _rightClick.fire();

  void update(double dt) {
    final difference = targetPosition - spiderPosition;
    final distance = difference.distance;
    if (distance == 0) {
      _resetValues();
      return; // exit early
    }
    _direction = difference / distance;

    _calculateRotation(dt);

    _targetRotation = atan2(_direction.dx, -_direction.dy);
    final rotationDifference = _targetRotation - _rotation;
    if (rotationDifference > pi / 2) {
      return;
    }

    _calculatePosition(dt, distance);
  }

  void _calculateRotation(double dt) {
    _targetRotation = atan2(_direction.dx, -_direction.dy);
    final rotationDifference = _targetRotation - _rotation;

    final currentRotationValue = _rotateInput.value;
    final targetRotationValue = rotationDifference / pi * 100;

    if ((currentRotationValue - targetRotationValue).abs() < 5) {
      _rotateInput.value = 0;
    } else {
      if (currentRotationValue > targetRotationValue) {
        final newRotation = currentRotationValue - (1000 * dt);
        _rotateInput.value = newRotation;
      } else {
        final newRotation = currentRotationValue + (1000 * dt);
        _rotateInput.value = newRotation;
      }
    }

    // Ramp down the speed if we are close to the correct rotation
    if (rotationDifference.abs() < 0.1) {
      var rotationPercentage = _turnSpeed / _maxRotationSpeed * 100;
      rotationPercentage = clampDouble(rotationPercentage, 0, 100);
      if (_turnSpeed < 0) {
        _turnInput.value = 0;
        _turnSpeed = 0;
        return;
      }

      if (rotationPercentage >= 0) {
        _turnSpeed -= 0.1;
        _turnSpeed = _turnSpeed.clamp(0, _maxRotationSpeed);
        _turnInput.value = rotationPercentage;
      }
      return;
    }

    // Resolves the issue of the spider rotating the long way around
    // to face the target.
    if (rotationDifference > pi) {
      _rotation += 2 * pi;
    } else if (rotationDifference < -pi) {
      _rotation -= 2 * pi;
    }

    final rotationPercentage = _turnSpeed / _maxRotationSpeed * 100;
    _turnInput.value = rotationPercentage;

    if (_targetRotation > _rotation) {
      _rotation += _turnSpeed * dt;
    } else {
      _rotation -= _turnSpeed * dt;
    }

    _turnSpeed += rotationDifference.abs();
    _turnSpeed = _turnSpeed.clamp(0, min(_turnSpeed, _maxRotationSpeed));
  }

  void _calculatePosition(double dt, double distance) {
    _speedInput.value = (_movementSpeed * 1.5) / _maxMovementSpeed * 100;

    // POSITION
    if (distance < 0.1) {
      _movementSpeed = 0;
      return; // exit early
    }
    _movementSpeed += max(distance, 1);
    _movementSpeed =
        _movementSpeed.clamp(0, min(distance * 2, _maxMovementSpeed));

    spiderPosition += _direction * dt * _movementSpeed;
  }

  void _resetValues() {
    _turnInput.value = 0;
    _speedInput.value = 0;
    _movementSpeed = 0;
    _turnSpeed = 0;
  }
}

class SpiderMouse extends StatefulWidget {
  const SpiderMouse({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<SpiderMouse> createState() => _SpiderMouseState();
}

class _SpiderMouseState extends State<SpiderMouse> {
  late Ticker ticker;

  final Size _cursorSize = const Size(125, 125);

  late final Artboard _artboard;
  late final StateMachineController _stateMachineController;

  late final SpiderController _spider;

  final _indicatorPainter = IndicatorPainter();

  var _previuosDuration = Duration.zero;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  void dispose() {
    ticker.stop();
    ticker.dispose();
    _stateMachineController.dispose();
    super.dispose();
  }

  Future<void> _setup() async {
    ticker = Ticker(_onTick);
    await _setupRiveFile();
    _spider = SpiderController(_stateMachineController);
    ticker.start();
    setState(() {
      _isLoading = false;
    });
  }

  void _onTick(Duration elapsed) {
    _spider.update((elapsed.inMicroseconds.toDouble() -
            _previuosDuration.inMicroseconds.toDouble()) /
        1000000.0);
    _previuosDuration = elapsed;
    setState(() {});
  }

  Future<void> _setupRiveFile() async {
    // Load file
    final file = await RiveFile.asset("assets/images/spider_cursor.riv");

    // Get artboard
    final artboard = file.artboardByName('Spider');
    if (artboard == null) {
      throw Exception('Failed to load artboard');
    }
    _artboard = artboard.instance();

    // Get State Machine controller and attach to artboard
    final controller =
        StateMachineController.fromArtboard(_artboard, 'spider-machine');
    if (controller == null) {
      throw Exception('Failed to load state machine');
    }
    _stateMachineController = controller;
    _artboard.addController(_stateMachineController);
  }

  void _setMousePosition(Offset pos) {
    _indicatorPainter.position = pos;
    _spider.targetPosition = pos;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();

    final pointerOffset = _cursorSize.height / 5;
    final dxPointer = _spider.dx -
        (_cursorSize.width / 2) -
        (pointerOffset * sin(_spider.rotation));
    final dyPointer = _spider.dy -
        (_cursorSize.height / 2) +
        (pointerOffset * cos(_spider.rotation));

    final transform = Matrix4.identity()
      ..translate(
        dxPointer,
        dyPointer,
      )
      ..rotateZ(_spider.rotation);

    return Listener(
      onPointerMove: (event) => _setMousePosition(event.position),
      onPointerHover: (event) => _setMousePosition(event.position),
      onPointerDown: (event) {
        if (event.buttons == kSecondaryMouseButton) {
          _spider.rightClick();
        } else {
          _spider.leftClick();
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.none,
        child: Stack(
          children: [
            RepaintBoundary(child: widget.child),
            IgnorePointer(
              child: Transform(
                alignment: Alignment.center,
                transform: transform,
                child: SizedBox(
                  width: _cursorSize.width,
                  height: _cursorSize.height,
                  child: Rive(
                    artboard: _artboard,
                  ),
                ),
              ),
            ),
            CustomPaint(
              painter: _indicatorPainter,
            ),
          ],
        ),
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  Offset position = Offset.zero;

  final _indicatorPaint = Paint()
    ..color = Colors.black12
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(position, 5, _indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
