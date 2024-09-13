import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({required this.value, required this.onChanged});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(

        mainAxisAlignment:MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              widget.onChanged(!widget.value);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 60, // حدد العرض هنا
              height: 30, // يمكنك ضبط الارتفاع هنا
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: widget.value ? const Color.fromARGB(172, 0, 0, 0) : Colors.grey,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: widget.value ? 30 : 5,
                    top: 2,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: widget.value
                          ? Icon(Icons.nightlight_round, color: Colors.white, size: 20, key: UniqueKey())
                          : Icon(Icons.wb_sunny, color: Colors.yellow, size: 20, key: UniqueKey()),
                    ),
                  ),
                  Positioned(
                    left: widget.value ? 5 : 30,
                    top: 5,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: widget.value ? 0.0 : 1.0,
                      child: Text(
                        widget.value ? '' : '',
                        style: TextStyle(
                          color: widget.value ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}