const buildMarkers = (markers, map) => {
  return markers.map((marker) => {
    const m = new google.maps.Marker({
        position: { lat: marker.lat, lng: marker.lng },
        map,
        title: marker.title,
        icon: marker.icon,
        label: marker.label
      });
    m.addListener("click", () => {
      // TODO
      const placeHeader = document.getElementById("place-header");
      console.log(placeHeader);
      placeHeader.innerHTML = '';
      const placeHeaderContent =
      `
      ${marker.title}
      `;
      placeHeader.innerHTML = placeHeaderContent;
      console.log(placeHeader);
    });
    return m;
  });
};

const initMap = (location) => {
  const mapElement = document.getElementById('map');
  if (mapElement) { // don't try to build a map if there's no div#map to inject in
    const map = new google.maps.Map(mapElement, {
      center: location,
      zoom: 14,
      maxZoom: 14
    });

    let markers = JSON.parse(mapElement.dataset.markers);
    if (markers === null) {
      map.setCenter(location);
    } else {
      const bounds = new google.maps.LatLngBounds();
      markers.forEach((marker) => {
        const loc = new google.maps.LatLng(marker.lat, marker.lng);
        bounds.extend(loc);
      });
      markers = buildMarkers(markers, map);
      map.fitBounds(bounds);
    }
  }
};

export { initMap };
