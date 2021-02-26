import { Directive, ElementRef, OnInit } from '@angular/core';
import * as Cesium from 'cesium';

@Directive({
  selector: '[appCesium]'
})
export class CesiumDirective implements OnInit {

  constructor(private el: ElementRef) {}

  ngOnInit(): void {
    const viewer = new Cesium.Viewer(this.el.nativeElement, {
      imageryProvider: new Cesium.OpenStreetMapImageryProvider({
        url : 'https://a.tile.openstreetmap.org/'
      }),
      sceneMode: Cesium.SceneMode.SCENE2D,
      homeButton: false,
      fullscreenButton: false,
      sceneModePicker: false,
      infoBox: false,
      geocoder: false,
      navigationHelpButton: false,
      animation: false,
      timeline: false
    });

    viewer.camera.setView({
      destination: Cesium.Rectangle.fromDegrees(
        -107.5831288368725,
        -36.435124924993914,
        4.2768711631275345,
        11.065124924993919
      )
    });

    viewer.cesiumWidget.creditContainer.parentNode.removeChild(
      viewer.cesiumWidget.creditContainer);
  }
}