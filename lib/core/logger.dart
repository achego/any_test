import 'dart:developer';
import 'package:flutter/foundation.dart';

void logger(dynamic text, [dynamic title, int maxChars = 3000]) {
  if (kDebugMode) {
    String trace = StackTrace.current.toString().split('\n')[1];
    if (trace.contains('>')) {
      if (trace.split('>').length >= 2) {
        trace = trace.split('>')[1];
      }
    }
    final now = DateTime.now();
    final time = '${now.hour}:${now.minute}:${now.second}';

    if (title != null) {
      log(
        'rqas: \x1B[35m$time\x1B[0m - \x1B[31m${title.toString().toUpperCase()}\x1B[0m === \x1b[33m${text.toString().length > maxChars ? text.toString().substring(0, maxChars) : text.toString()}\x1B[0m \x1b[2m$trace\x1B[0m',
      );
      if ((text.toString().length + title.toString().length) >= 500) {
        log('rqas: \x1b[31m$trace\x1B[0m');
      }
    } else {
      log(
        'rqas: \x1B[35m$time\x1B[0m - \x1b[33m${text.toString().length > maxChars ? text.toString().substring(0, maxChars) : text.toString()}\x1B[0m \x1b[2m$trace\x1B[0m',
      );
      if ((text.toString().length + title.toString().length) >= 500) {
        log('rqas: \x1b[31m$trace\x1B[0m');
      }
    }
  }
}

void loggerR() {
  if (kDebugMode) {
    String trace = StackTrace.current.toString().split('\n')[1];
    if (trace.contains('>')) {
      if (trace.split('>').length >= 2) {
        trace = trace.split('>')[1];
      }
    }
    final now = DateTime.now();
    final time = '${now.hour}:${now.minute}:${now.second}';

    // if()
    const splitText = '(';
    log(
      ' \x1b[46m rqasR: \x1B[35m$time - \x1B[31mRouting To ==>> \x1b[33m${trace.split(splitText)[0]} \x1B[0m \x1b[2m$trace \x1B[0m ',
    );
  }
}





// Colors reference
// You can use the following as so:
// console.log(colorCode, data);
// console.log(`${colorCode}some colorful text string${resetCode} rest of string in normal color`);
// 
// ... and so on.

// export const reset = "\x1b[0m"
// export const bright = "\x1b[1m"
// export const dim = "\x1b[2m"
// export const underscore = "\x1b[4m"
// export const blink = "\x1b[5m"
// export const blink fast = "\x1b[6m"
// export const reverse = "\x1b[7m"
// export const hidden = "\x1b[8m"

// export const black = "\x1b[30m"
// export const red = "\x1b[31m"
// export const green = "\x1b[32m"
// export const yellow = "\x1b[33m"
// export const blue = "\x1b[34m"
// export const magenta = "\x1b[35m"
// export const cyan = "\x1b[36m"
// export const white = "\x1b[37m"

// export const BGblack = "\x1b[40m"
// export const BGred = "\x1b[41m"
// export const BGgreen = "\x1b[42m"
// export const BGyellow = "\x1b[43m"
// export const BGblue = "\x1b[44m"
// export const BGmagenta = "\x1b[45m"
// export const BGcyan = "\x1b[46m"
// export const BGwhite = "\x1b[47m"


// .
// .
// .
// Custom Colors
// .
// .
// .
// .
// \x1b[38;2;r;g;bm - foreground eg \x1b[38;2;0;255;0m == green
// \x1b[48;2;r;g;bm - background
