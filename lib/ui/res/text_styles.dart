import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pika_pika_app/ui/res/colors.dart';

/// Стили текстов

TextStyle _text = TextStyle(
      fontStyle: FontStyle.normal,
      color: textColorPrimary,
    ),

//Light
    textLight = _text.copyWith(fontWeight: FontWeight.w300),

//Regular
    textRegular = _text.copyWith(fontWeight: FontWeight.normal),
    textRegular16 = textRegular.copyWith(fontSize: 16.0),
    textRegular14 = textRegular.copyWith(fontSize: 16.0),
    textRegular14Black = textRegular14.copyWith(color: Colors.black),
    textRegular16Secondary = textRegular16.copyWith(color: textColorSecondary),
    textRegular16Grey = textRegular16.copyWith(color: textColorGrey),

//Medium
    textMedium = _text.copyWith(fontWeight: FontWeight.w500),
    textMedium20 = textMedium.copyWith(fontSize: 20.0),
//Bold
    textBold = _text.copyWith(fontWeight: FontWeight.bold);
