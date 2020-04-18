import 'package:app_financeiro/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';

class ControlejaButton extends RawMaterialButton{
  ControlejaButton({
    @required VoidCallback onPressed,
    @required String  label,
    Color primaryColor,
    Color highlightColor,
  }) : super(
    onPressed: onPressed,
    child: Container(
      padding:EdgeInsets.all(10),
      height: 55,
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize:20,
          fontWeight: FontWeight.bold
        )
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    fillColor: primaryColor ?? ThemeUtils.primaryColor,
    highlightColor: highlightColor ?? ThemeUtils.primaryColor
  );
}