// lib/presentation/pages/memory_success_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' hide RadialGradient, LinearGradient;
import 'dart:math' as math;


class MemorySuccessPage extends StatefulWidget {
  final String riveAssetPath;
  final bool shouldExitApp;
  final VoidCallback onAddedToMemory;
  final Function(void Function(int)) onAnimationStateChanged;

  const MemorySuccessPage({
    super.key,
    required this.riveAssetPath,
    this.shouldExitApp = true,
    required this.onAddedToMemory,
    required this.onAnimationStateChanged,
  });

  @override
  State<MemorySuccessPage> createState() => _MemorySuccessPageState();
}

class _MemorySuccessPageState extends State<MemorySuccessPage>
    with TickerProviderStateMixin {
  late AnimationController _expandController;
  late AnimationController _contentController;
  late AnimationController _navigationController;

  late Animation<double> _expandScale;
  late Animation<double> _contentOpacity;
  late Animation<double> _textSlide;
  late Animation<double> _navigationScale;
  late Animation<double> _navigationOpacity;

  OverlayEntry? _overlayEntry;
  bool _isShowing = false;
  Offset? _buttonPosition;
  Size? _buttonSize;

  RiveAnimationController? _riveController;
  StateMachineController? _stateMachineController;
  SMINumber? _stateInput;

  int _currentState = 2; // Start with loading

  final GlobalKey _buttonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeRiveAnimation();

    // Register the callback with parent widget
    widget.onAnimationStateChanged(_updateAnimationState);
  }

  void _updateAnimationState(int state) {
    if (mounted) {
      setState(() {
        _currentState = state;
      });

      if (_stateInput != null) {
        _stateInput?.change(state.toDouble());
      }

      // Auto-complete animation for success/failure states
      if (state == 0 || state == 1) {
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (mounted && _isShowing) {
            _completeAnimation();
          }
        });
      }
    }
  }

  void _initializeAnimations() {
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _navigationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _expandScale = Tween<double>(begin: 0.01, end: 1.0)
        .animate(CurvedAnimation(parent: _expandController, curve: Curves.easeOutCubic));

    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _contentController, curve: Curves.easeIn));

    _textSlide = Tween<double>(begin: 50.0, end: 0.0)
        .animate(CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic));

    _navigationScale = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _navigationController, curve: Curves.easeInCubic));

    _navigationOpacity = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _navigationController, curve: Curves.easeIn));
  }

  void _initializeRiveAnimation() {
    _riveController = SimpleAnimation('success');
  }

  void _getButtonPosition() {
    final RenderBox? renderBox = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      _buttonPosition = renderBox.localToGlobal(Offset.zero);
      _buttonSize = renderBox.size;
    }
  }

  String _getStatusText(int state) {
    switch (state) {
      case 0:
        return 'Failed';
      case 1:
        return 'Success';
      default:
        return 'Processing';
    }
  }

  Color _getStatusColor(int state) {
    switch (state) {
      case 0:
        return Colors.red;
      case 1:
        return const Color(0xFF64FFDA);
      case 2:
        return Colors.orange;
      default:
        return const Color(0xFF64FFDA);
    }
  }

  void _showMemorySuccessOverlay() async {
    print("Showing memory success overlay");
    if (_isShowing) return;

    _getButtonPosition();
    if (_buttonPosition == null || _buttonSize == null) return;

    setState(() {
      _isShowing = true;
      _currentState = 2; // Reset to loading state
    });

    final screenSize = MediaQuery.of(context).size;

    // Calculate the center of the button
    final buttonCenter = Offset(
      _buttonPosition!.dx + _buttonSize!.width / 2,
      _buttonPosition!.dy + _buttonSize!.height / 2,
    );

    // Calculate the maximum distance needed to cover the entire screen
    final maxDistance = math.max(
      math.max(buttonCenter.dx, screenSize.width - buttonCenter.dx),
      math.max(buttonCenter.dy, screenSize.height - buttonCenter.dy),
    ) * 2.5;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setOverlayState) {
            return AnimatedBuilder(
              animation: Listenable.merge([
                _expandController,
                _contentController,
                _navigationController,
              ]),
              builder: (context, child) {
                return Material(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      // Animated navigation background (shrinks during closing)
                      Transform.scale(
                        scale: _navigationScale.value,
                        child: Opacity(
                          opacity: _navigationOpacity.value,
                          child: Container(
                            width: screenSize.width,
                            height: screenSize.height,
                            color: Colors.transparent,
                            child: widget.shouldExitApp ? Container() :
                            Navigator.of(context).widget,
                          ),
                        ),
                      ),
                      // Circular expanding overlay
                      ClipPath(
                        clipper: CircleClipper(
                          center: buttonCenter,
                          radius: maxDistance * _expandScale.value / 2,
                        ),
                        child: Container(
                          width: screenSize.width,
                          height: screenSize.height,
                          decoration: const BoxDecoration(
                            color:Color(0xFF1A1A2E)
                            // gradient: LinearGradient(
                            //   colors: [
                            //     Color(0xFF0F0F23),
                            //     Color(0xFF1A1A2E),
                            //     Color(0xFF2D1B69),
                            //   ],
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            // ),
                          ),
                        ),
                      ),
                      // Content overlay
                      if (_expandScale.value > 0.3)
                        Center(
                          child: Opacity(
                            opacity: _contentOpacity.value,
                            child: Transform.translate(
                              offset: Offset(0, _textSlide.value),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: RiveAnimation.asset(
                                      widget.riveAssetPath,
                                      controllers: _riveController != null ? [_riveController!] : [],
                                      onInit: (artboard) {
                                        final controller = StateMachineController.fromArtboard(
                                          artboard,
                                          'SynapseBulbStateMachine',
                                        );
                                        if (controller != null) {
                                          artboard.addController(controller);
                                          _stateMachineController = controller;
                                          _stateInput = controller.findSMI('Number 1') as SMINumber?;

                                          if (_stateInput != null) {
                                            _stateInput?.change(_currentState.toDouble());
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Column(
                                    children: [
                                      Text(
                                        'Added to memory',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      ShaderMask(
                                        shaderCallback: (bounds) => LinearGradient(
                                          colors: [
                                            _getStatusColor(_currentState),
                                            _getStatusColor(_currentState).withOpacity(0.7),
                                          ],
                                        ).createShader(bounds),
                                        child: Text(
                                          _getStatusText(_currentState),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    await _startAnimationSequence();

    widget.onAddedToMemory();
  }

  Future<void> _startAnimationSequence() async {
    HapticFeedback.mediumImpact();

    await _expandController.forward();

    await Future.delayed(const Duration(milliseconds: 200));
    await _contentController.forward();
  }

  void _completeAnimation() async {
    if (_overlayEntry == null) return;

    _navigationController.forward();

    await _contentController.reverse();

    await _expandController.reverse();

    _overlayEntry!.remove();
    _overlayEntry = null;

    setState(() {
      _isShowing = false;
    });

    if (widget.shouldExitApp) {
      SystemNavigator.pop();
    } else {
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _expandController.dispose();
    _contentController.dispose();
    _navigationController.dispose();
    _riveController?.dispose();
    _stateMachineController?.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _buttonKey,
      onTap: !_isShowing ? _showMemorySuccessOverlay : null,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF2A2C3A), Color(0xFF3B3D5A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  CircleClipper({required this.center, required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(Rect.fromCircle(center: center, radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CircleClipper oldClipper) {
    return oldClipper.center != center || oldClipper.radius != radius;
  }
}