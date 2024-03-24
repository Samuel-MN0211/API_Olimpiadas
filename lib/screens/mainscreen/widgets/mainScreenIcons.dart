import 'package:flutter/material.dart';
import 'package:teste_olimpiadas/core/app_export.dart';

// Widget precisa ser encapsulado em uma classe e declarado como estático para poder ser chamado dentro do "widget build" de outras classes
// Caso contrário, o widget deve ser declarado dentro do "widget build" da classe que o chama, para que:
//1.O widget seja "Definido" dentro da classe que o chama
//2.O acesso ao contexto seja possível
//3.O widget possa ser construído
class MainScreenIcons {
  static Widget buildMainScreenIcons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgObmProvisorio,
                  height: 125.v,
                  width: 200.h,
                  alignment: Alignment.centerRight,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgLogoObc,
                    height: 93.v,
                    width: 120.h,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgLogoObi,
                  height: 130.v,
                  width: 102.h,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
