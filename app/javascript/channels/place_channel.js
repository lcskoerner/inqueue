import consumer from "./consumer";

const initPlaceCable = () => {
  let placeContainers = document.querySelectorAll('.card');

  placeContainers.forEach((placeContainer) => {
    if (placeContainer) {
      const id = placeContainer.dataset.placeId;
      let infoContainer = placeContainer.querySelector('.info-container');

      consumer.subscriptions.create({ channel: "PlaceChannel", id: id }, {
        received(data) {
          placeContainer.style.backgroundColor = data[0];
          infoContainer.innerHTML = data[1];
        },
      });
    }
  });
}

export { initPlaceCable };
