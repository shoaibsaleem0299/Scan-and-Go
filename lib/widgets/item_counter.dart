// import 'package:flutter/material.dart';

// class ItemCounter extends StatefulWidget {
//   final int initialValue;
//   final double pricePerItem;
//   final ValueChanged<int> onChanged;

//   const ItemCounter({
//     super.key,
//     required this.initialValue,
//     required this.pricePerItem,
//     required this.onChanged,
//   });

//   @override
//   _ItemCounterState createState() => _ItemCounterState();
// }

// class _ItemCounterState extends State<ItemCounter> {
//   late int _value;
//   late double _totalPrice;

//   @override
//   void initState() {
//     super.initState();
//     _value = widget.initialValue;
//     _totalPrice = _value * widget.pricePerItem;
//   }

//   void _updateTotalPrice() {
//     setState(() {
//       _totalPrice = _value * widget.pricePerItem;
//     });
//   }

//   void _increment() {
//     setState(() {
//       _value++;
//       _updateTotalPrice();
//       widget.onChanged(_value);
//     });
//   }

//   void _decrement() {
//     if (_value > 1) {
//       setState(() {
//         _value--;
//         _updateTotalPrice();
//         widget.onChanged(_value);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           '\$${_totalPrice.toStringAsFixed(2)}', // Format price to 2 decimal places
//           style: const TextStyle(fontSize: 18),
//         ),
//         const Spacer(),
//         IconButton(
//           icon: const Icon(Icons.remove),
//           onPressed: _decrement,
//         ),
//         Text(
//           '$_value',
//           style: const TextStyle(fontSize: 18),
//         ),
//         IconButton(
//           icon: const Icon(Icons.add),
//           onPressed: _increment,
//         ),
//       ],
//     );
//   }
// }

// // Example usage:
// // ItemCounter(
// //   initialValue: 1,
// //   pricePerItem: 10.0,
// //   onChanged: (value) {
// //     print('New value: $value');
// //   },
// // )

import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class ItemCounter extends StatefulWidget {
  final int initialValue;
  final double pricePerItem;
  final ValueChanged<int> onChanged;

  const ItemCounter({
    super.key,
    required this.initialValue,
    required this.pricePerItem,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ItemCounterState createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  late int _value;
  late double _totalPrice;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _totalPrice = _value * widget.pricePerItem;
  }

  void _updateTotalPrice() {
    setState(() {
      _totalPrice = _value * widget.pricePerItem;
    });
  }

  void _increment() {
    setState(() {
      _value++;
      _updateTotalPrice();
      widget.onChanged(_value);
    });
  }

  void _decrement() {
    if (_value > 1) {
      setState(() {
        _value--;
        _updateTotalPrice();
        widget.onChanged(_value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Rs. ${_totalPrice.toStringAsFixed(2)}', // Format price to 2 decimal places
          style: TextStyle(fontSize: 18, color: AppColor.primary),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Text(
          '$_value',
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
