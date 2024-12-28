import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_booth/bloc/app_bloc/app_bloc.dart';

class CustomOverlayEntry {
  static OverlayEntry? _overlayEntry;

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static void show(BuildContext context, Widget child, GlobalKey key) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    final appBloc = BlocProvider.of<AppBloc>(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => BlocProvider.value(
        value: appBloc,
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Material(
                elevation: 8,
                shadowColor: Colors.grey,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      child,
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            hide();
                          },
                          icon: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    print("Inserting overlay...");
    Overlay.of(context).insert(_overlayEntry!);
  }
}
