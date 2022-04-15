import 'package:flutter/services.dart';
import 'ip_address_input_formatters.dart';

class InputFormatterService {
  static List<TextInputFormatter> ipAddressInputFilter() {
    return [
      FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
      IpAddressInputFormatter(),
      LengthLimitingTextInputFormatter(15),
    ];
  }
}


