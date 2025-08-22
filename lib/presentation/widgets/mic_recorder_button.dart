import 'package:flutter/material.dart';

extension GlobalPaintBounds on BuildContext {
  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();

    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}

class MicRecorderButton extends StatefulWidget {
  final Function(String filePath)? onRecordingComplete;
  final VoidCallback? onNext;

  const MicRecorderButton({
    super.key,
    this.onRecordingComplete,
    this.onNext,
  });

  @override
  State<MicRecorderButton> createState() => _MicRecorderButtonState();
}

class _MicRecorderButtonState extends State<MicRecorderButton>
    with TickerProviderStateMixin {
  late AnimationController _flyController;
  late Animation<Offset> _flyAnimation;
  late Animation<double> _sizeAnimation;
  late AnimationController _pulseController;
  late AnimationController _backgroundController;
  late Animation<double> _backgroundOpacity;

  OverlayEntry? _overlayEntry;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();

    _flyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _backgroundOpacity = Tween<double>(
      begin: 0.0,
      end: 0.6,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _pulseController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _pulseController.forward();
      }
    });
  }

  @override
  void dispose() {
    _flyController.dispose();
    _pulseController.dispose();
    _backgroundController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _showRecordingUI() {
    final micBounds = context.globalPaintBounds;
    if (micBounds == null) return;

    final screenSize = MediaQuery.of(context).size;

    final targetPosition = Offset(
      screenSize.width / 2 - 80,
      screenSize.height / 2 - 100,
    );

    final startPosition = Offset(
      micBounds.left,
      micBounds.top,
    );

    _flyAnimation = Tween<Offset>(
      begin: startPosition,
      end: targetPosition,
    ).animate(CurvedAnimation(
      parent: _flyController,
      curve: Curves.easeInOutCirc,
    ));

    _sizeAnimation = Tween<double>(
      begin: 52.0,
      end: 180.0,
    ).animate(CurvedAnimation(
      parent: _flyController,
      curve: Curves.easeInOutCubic,
    ));

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          animation: Listenable.merge([_flyAnimation, _backgroundOpacity, _sizeAnimation]),
          builder: (context, child) {
            return Stack(
              children: [
                // Animated dimmed background
                GestureDetector(
                  onTap: _stopRecording,
                  child: Container(
                    width: screenSize.width,
                    height: screenSize.height,
                    color: Colors.black.withOpacity(_backgroundOpacity.value),
                  ),
                ),

                // Animated recording widget
                Positioned(
                  top: _flyAnimation.value.dy,
                  left: _flyAnimation.value.dx,
                  child: ScaleTransition(
                    scale: _pulseController,
                    child: Material(
                      color: Colors.transparent,
                      child: AnimatedContainer(
                        duration: Duration.zero,
                        width: _sizeAnimation.value,
                        height: _sizeAnimation.value,
                        decoration: BoxDecoration(
                          color: const Color(0xFF041014),
                          shape: BoxShape.circle,
                          gradient: _sizeAnimation.value > 100 ? null : const LinearGradient(
                            colors: [Color(0xFF2A2C3A), Color(0xFF3B3D5A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: _sizeAnimation.value > 100 ? 35 : 15,
                              spreadRadius: _sizeAnimation.value > 100 ? 5 : 2,
                              offset: const Offset(0, 8),
                            ),
                            if (_sizeAnimation.value > 100)
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 45,
                                spreadRadius: 17,
                              ),
                          ],
                        ),
                        child: _sizeAnimation.value > 100
                            ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: FittedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.mic, color: Colors.white, size: 36),
                                const SizedBox(height: 8),
                                const Text(
                                  "Recording...",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: _stopRecording,
                                        style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          backgroundColor: Colors.red,
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(40, 40),
                                        ),
                                        child: const Icon(
                                          Icons.stop,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          widget.onNext?.call();
                                          _stopRecording();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          backgroundColor: Colors.green,
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(40, 40),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                            : const Icon(Icons.mic, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    _backgroundController.forward();
    _flyController.forward();
    _pulseController.forward();
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });
    _showRecordingUI();
    debugPrint("Recording started...");
  }

  void _stopRecording() async {
    if (_overlayEntry != null) {
      await _flyController.reverse();
      await _backgroundController.reverse();

      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    _pulseController.stop();
    _pulseController.reset();

    setState(() => _isRecording = false);
    widget.onRecordingComplete?.call("recorded_audio.wav");
    debugPrint("Recording stopped...");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !_isRecording ? _startRecording : null,
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
        child: const Icon(Icons.mic, color: Colors.white, size: 24),
      ),
    );
  }
}