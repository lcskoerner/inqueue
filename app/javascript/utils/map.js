import GMaps from 'gmaps/gmaps.js';

const initMap = (location) => {
  const mapElement = document.getElementById('map');
  if (mapElement) { // don't try to build a map if there's no div#map to inject in
    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });

    const markers = JSON.parse(mapElement.dataset.markers);
    console.log(markers);
    if (markers === null){
      map.setCenter(location.lat, location.lng);
      map.setZoom(14);
    } else {
      map.addMarkers(markers);

      if (markers.length === 0) {
        map.setCenter(location.lat, location.lng);
        map.setZoom(14);
      } else if (markers.length === 1) {
        // hacking the zoom by creating another marker
        markers.push({lat: markers[0].lat + 0.0025, lng: markers[0].lng + 0.0025})
        map.fitLatLngBounds(markers);
        //original code
        // map.setCenter(markers[0].lat, markers[0].lng);
        // console.log(markers[0].lat, markers[0].lng);
        //map.setZoom(20);
      }
       else {
        map.fitLatLngBounds(markers);
      }

    }
  }
};

export { initMap };
